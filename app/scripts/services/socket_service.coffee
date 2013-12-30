define(['angular', 'jquery', 'namespace', 'app', 'jqueryAtmosphere'], ->
  namespace 'camfire', (exports) ->
    class exports.SocketService
      request = undefined
      socket = $.atmosphere
      subSocket = undefined
      transport = "websocket"

      # TODO: Remove signalservice
      constructor: (@$rootScope, @configurationService, @utilService) ->

      onConnectCallback:  ->
      onDisconnectCallback: ->
      onErrorCallback: ->

      init: (callback) ->
        @request =
          url: @configurationService.signalFullUrl() + "/" + @configurationService.signalResource
          contentType: "application/json"
          logLevel: "debug"
          shared: true
          transport: transport
  #        trackMessageLength: true
          connectTimeout: 5000
          fallbackTransport: "long-polling"

        @request.onOpen = (response) =>
          debug.debug "Atmosphere connected using " + response.transport
          @transport = response.transport
          @$rootScope.$apply =>
            @onConnectCallback()

        @request.onTransportFailure = (errorMsg, r) ->
          debug.error errorMsg
          jQuery.atmosphere.info errorMsg
          if window.EventSource
            r.fallbackTransport = "sse"
            transport = "see"

        @request.onReconnect = (rq, rs) ->
          debug.info "Reconnecting..."
          socket.info "Reconnecting"

  #        subSocket.pushLocal "Name?"  if response.transport is "local"

  #      request.onLocalMessage = (message) ->
  #        unless transport is "local"
  #          header.append $("<h4>",
  #            text: "A new tab/window has been opened"
  #          ).css("color", "green")
  #          subSocket.pushLocal myName  if myName
  #        else
  #          unless myName
  #            myName = message
  #            loggedIn = true
  #            status.text(message + ": ").css "color", "blue"
  #            input.removeAttr("disabled").focus()
  #

        @request.onClose = (rs) =>
          debug.debug("onClose called...")
          @$rootScope.$apply =>
            @onDisconnectCallback()
  #        loggedIn = false

        @request.onError = (rs) =>
          debug.error "Sorry, but there's some problem with your socket or the server is down"
          @$rootScope.$apply =>
            @onErrorCallback()

        callback()

  #    on: (eventName, callback) ->
  #      debug.debug "Registering on #{eventName} event..."
  #      @socket.on eventName, =>
  #        args = arguments
  #        @$rootScope.$apply ->
  #          callback.apply @socket, args
  #

      subscribeToSocket: (callback) ->
        @onConnectCallback = callback
        @subSocket = socket.subscribe(@request)

      reconnect: ->
        debug.debug "Disconnecting..."
        @subSocket.disconnect()
        @subSocket.subscribe()

      emit: (eventName, data, callback) ->
        debug.debug "Emitting '#{eventName}' event with data[#{data}]..."
        @subSocket.push data

      emitWrapped: (eventName, messageName, data, skipDataStringify = false, callback) ->
        @emit eventName, @utilService.wrapMessage(messageName, data, skipDataStringify), callback

      emitWrappedSignal: (messageName, data = {}, skipDataStringify = false, callback) ->
        @emitWrapped "signal", messageName, data, skipDataStringify, callback

    exports.app.service 'socketService', camfire.SocketService
)


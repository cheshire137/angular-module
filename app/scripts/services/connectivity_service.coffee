namespace 'camfire', (exports) ->
  class exports.ConnectivityService
    constructor: (@$rootScope,
                  @$http
                  @configurationService,
                  @socketService,
                  @peerConnectionService,
                  @remoteMediaService,
                  @signalService) ->
      @socketService.onConnectCallback = =>
        @socketConnected()

      @socketService.onDisconnectCallback = =>
        @socketDisconnected()

      @socketService.onErrorCallback = =>
        @socketDisconnected()

    #TODO: Handle when peerconnection loses connection!

    status: {
      isSessionCreated: false
      isSocketConnected: false
      isPeerConnectionConnected: false

      isConnected: ->
        @isSessionCreated && @isSocketConnected && @isPeerConnectionConnected
    }

    init: ->
      async.series
        initSession: (callback) =>
          @initSession(callback)

        initSocket: (callback) =>
          @socketService.init(callback)

        initSignal: (callback) =>
          @signalService.init(callback)

        subscribeToSocket: (callback) =>
          @socketService.subscribeToSocket(callback)

#        restoreOrCreateSession: (callback) =>
#          @restoreOrCreateSession(callback)

#        initPeerConnection: (callback) =>
#          @initPeerConnection(callback)

      , (err, results) =>
        # TODO: Add in error checking logic
        @status.isSessionCreated = true
        @status.isSocketConnected = true
        @status.isPeerConnectionConnected = true

#    restoreOrCreateSession: (callback) ->
#      #TODO: Implement canRestore
#      canRestore = false
#      if (canRestore)
#        @restoreSession(callback)
#      else
#        @createSession(callback)
#
#    restoreSession: (callback) ->
#      # TODO: do restore
#      callback()
#
#    createSession: (callback) ->
#      @socketService.emitWrappedSignal "create-session"
#      # TODO: do create
#      callback()

    initSession: (callback) ->
      @$http(
        method: "POST"
        url: @configurationService.sessionFullUrl()
      ).success((data, status, headers, config) =>
        if (data)
          callback()
      ).error (data, status, headers, config) =>
        # TODO: Add error handling

    initPeerConnection: (callback) ->
      @peerConnectionService.createPeerConnection(@configurationService.peerConnectionConfig)
      @peerConnectionService.createOffer(@configurationService.sdpConstraints)
      @peerConnectionService.setOnAddStream(@remoteMediaService.onAddStream)
      @peerConnectionService.setOnRemoveStream(@remoteMediaService.onRemoveStream)
      callback()

    socketConnected: ->
      @status.isSocketConnected = true

    socketDisconnected: ->
      @status.isSocketConnected = false

  exports.app.service 'connectivityService', camfire.ConnectivityService

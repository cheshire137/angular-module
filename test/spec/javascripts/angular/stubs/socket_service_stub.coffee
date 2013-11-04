namespace 'camfire', (exports) ->
  class exports.SocketServiceMock extends camfire.SocketService
    constructor: (@$rootScope, configurationService, utilService) ->
      super $rootScope, configurationService, utilService

    events: {}
    transport: {name: "fake-websocket"}

    connectSocket: ->
      this

    on: (eventName, callback) ->
      @events[eventName] = []  unless @events[eventName]
      @events[eventName].push callback

    emit: (eventName, data, callback) ->
      if @events[eventName]
        angular.forEach @events[eventName], (callback) =>
#          @$rootScope.$apply ->
            callback data

      callback() if callback

  exports.appMock.service 'socketService', camfire.SocketServiceMock



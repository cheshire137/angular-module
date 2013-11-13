namespace 'camfire', (exports) ->
  class exports.ConnectivityService
    constructor: (@$rootScope,
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
      isSocketConnected: false
      isPeerConnectionConnected: false

      isConnected: ->
        @isSocketConnected && @isPeerConnectionConnected
    }

    init: ->
      async.series
        initSocket: (callback) =>
          @socketService.init(callback)

        initSignal: (callback) =>
          @signalService.init(callback)

        subscribeToSocket: (callback) =>
          @socketService.subscribeToSocket(callback)

#        initPeerConnection: (callback) =>
#          @initPeerConnection(callback)

      , (err, results) =>
        # TODO: Add in error checking logic
        @status.isSocketConnected = true
#        @status.isPeerConnectionConnected = true

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

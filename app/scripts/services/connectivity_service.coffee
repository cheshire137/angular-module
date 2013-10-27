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
      @initSocket()
      @signalService.init()
      @socketService.subscribeToSocket()
#      @initPeerConnection()

    initPeerConnection: ->
      @peerConnectionService.createPeerConnection(@configurationService.peerConnectionConfig)
      @peerConnectionService.createOffer(@configurationService.sdpConstraints)
      @peerConnectionService.setOnAddStream(@remoteMediaService.onAddStream)
      @peerConnectionService.setOnRemoveStream(@remoteMediaService.onRemoveStream)
      @peerConnectionConnected()

    peerConnectionConnected: ->
      @status.isPeerConnectionConnected = true
#      @initSocket()

    initSocket: ->
      @socketService.init()

    socketConnected: ->
      @initPeerConnection()
      @status.isSocketConnected = true

    socketDisconnected: ->
      @status.isSocketConnected = false

  exports.app.service 'connectivityService', camfire.ConnectivityService

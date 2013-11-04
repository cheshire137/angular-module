namespace 'camfire', (exports) ->
  class exports.PeerConnectionServiceMock extends camfire.PeerConnectionService
    constructor: (@$rootScope, @socketService) ->
      super $rootScope, socketService

    newPeerConnection: (configuration) ->
      sinon.createStubInstance(RTCPeerConnection)

  exports.appMock.service 'peerConnectionService', camfire.PeerConnectionServiceMock



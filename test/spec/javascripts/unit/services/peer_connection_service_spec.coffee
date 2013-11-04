describe "Unit:PeerConnectionService", ->
  beforeEach(->
    angular.mock.module('Camfire')
    angular.mock.module('CamfireMock')
  )

  it "should contain peerConnectionService", inject((peerConnectionService) ->
    expect(peerConnectionService).toNotEqual(null)
  )

  it "should create peerconnection", inject((peerConnectionService) ->
    peerConnectionService.createPeerConnection()
    expect(peerConnectionService.localPeerConnection).toNotEqual(null)
  )









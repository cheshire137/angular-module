describe "Unit:ConnectivityService", ->
  beforeEach(->
    angular.mock.module('Camfire')
    angular.mock.module('CamfireMock')
  )
  it "should contain connectivityService", inject((connectivityService) ->
    expect(connectivityService).toNotEqual(null)
  )

  it "should handle connecting and disconnecting", inject((connectivityService, socketService) ->
    connectivityService.init()
    socketService.emit("connect", {})
    expect(connectivityService.status.isConnected()).toBeTruthy()
    socketService.emit("disconnect", {})
    expect(connectivityService.status.isConnected()).toBeFalsy()
  )


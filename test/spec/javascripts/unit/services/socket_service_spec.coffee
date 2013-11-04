describe "Unit:SocketService", ->
  beforeEach(->
    angular.mock.module('Camfire')
    angular.mock.module('CamfireMock')
  )

  it "should contain socketService", inject((socketService) ->
    expect(socketService).toNotEqual(null)
  )

  it "should emit and receieve", inject((socketService) ->
    testRecieved = false
    socketService.on("test", -> testRecieved = true)
    socketService.emit("test", { info: "test" })
    expect(testRecieved).toEqual(true)
  )







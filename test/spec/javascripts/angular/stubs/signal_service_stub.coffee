namespace 'camfire', (exports) ->
  signalServiceStub = sinon.createStubInstance(camfire.SignalService)
  exports.appMock.factory 'signalService', ->
    signalServiceStub
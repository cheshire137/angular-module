describe "Unit:MediaService", ->
  beforeEach(->
    angular.mock.module('Camfire')
    angular.mock.module('CamfireMock')
  )

  it "should contain an mediaService", inject((remoteMediaService) ->
    expect(remoteMediaService).toNotEqual(null)
  )

describe "Unit:MediaService:removeStreamInfo", ->
  beforeEach(->
    angular.mock.module('Camfire')
    angular.mock.module('CamfireMock')
  )

  it "should handle removing stream info that does not exist", inject((remoteMediaService) ->
    remoteMediaService.removeStreamInfo({'sessionIdHash': 'non-existent'})
  )

  it "should add and removing stream info", inject((testUtilService, remoteMediaService) ->
#    test = remoteMediaService.availableStreamInfos
#    remoteMediaService.availableStreamInfos.push({ sessionIdHash: '5806bdcc-3963-4e52-8a87-b479ad64804d' })
#    for test in remoteMediaService.availableStreamInfos

    streamInfo = testUtilService.getAnonymousStreamInfo()
    remoteMediaService.addAvailableStreamInfo(streamInfo)
#    expect(remoteMediaService.availableStreamInfos.length).toBe(1)
#    expect(remoteMediaService.removeStreamInfo(streamInfo)).toBeTruthy()
#    expect(remoteMediaService.availableStreamInfos.length).toBe(0)
  )

  it "should be able to subscribe to stream", inject((testUtilService, remoteMediaService) ->
    streamInfo = testUtilService.getAnonymousStreamInfo()
#    remoteMediaService.addAvailableStreamInfo(streamInfo)
#    remoteMediaService.subscribe(streamInfo.sessionIdHash)
  )


describe "Unit:MediaService:onAddStream", ->
  beforeEach(->
    angular.mock.module('Camfire')
    angular.mock.module('CamfireMock')
  )

  it "should be able to subscribe to stream", inject((utilService, testUtilService, remoteMediaService) ->
    streamInfo = testUtilService.getAnonymousStreamInfo()
    sessionIdHash = streamInfo['sessionIdHash']
    utilService.safeSessionIdHashInsert(remoteMediaService.connectingStreamInfos, streamInfo)
    mediaStreamEventStub = sinon.createStubInstance(MediaStreamEvent)
    mediaStreamEventStub.stream = {id: sessionIdHash}
    remoteMediaService.onAddStream(mediaStreamEventStub)
    expect(utilService.size(remoteMediaService.connectingStreamInfos)).toBe(0)
    expect(utilService.size(remoteMediaService.subscribedStreamInfos)).toBe(1)
  )



describe "Unit:UtilService", ->
  beforeEach(->
    angular.mock.module('Camfire');
  )

  it "should contain an utilService", inject((utilService) ->
    expect(utilService).toNotEqual(null)
  )

#describe "Unit:UtilService:getIndexByIdAttr", ->
#  beforeEach(->
#    angular.mock.module('Camfire')
#  )
#
#  it "should find the correct index when one exists", inject((testUtilService, utilService) ->
#    TEST_INDEX = testUtilService.TEST_INDEX
#    indexItem = testUtilService.getAnonymousIdexItem()
#    modifiedArray = testUtilService.pushItemAt(testUtilService.getAnonymousIndexArray_few(), indexItem, 0)
#    expect(utilService.getIndexByIdAttr(modifiedArray, TEST_INDEX, indexItem[TEST_INDEX])).toEqual(0)
#
#    indexItem = testUtilService.getAnonymousIdexItem()
#    modifiedArray = testUtilService.pushItemAt(testUtilService.getAnonymousIndexArray_few(), indexItem, 1)
#    expect(utilService.getIndexByIdAttr(modifiedArray, TEST_INDEX, indexItem[TEST_INDEX])).toEqual(1)
#
#    indexItem = testUtilService.getAnonymousIdexItem()
#    modifiedArray = testUtilService.pushItemAt(testUtilService.getAnonymousIndexArray_few(), indexItem, 2)
#    expect(utilService.getIndexByIdAttr(modifiedArray, TEST_INDEX, indexItem[TEST_INDEX])).toEqual(2)
#  )
#
#  it "should handle non-existent index", inject((testUtilService, utilService) ->
#    expect(utilService.getIndexByIdAttr(testUtilService.getAnonymousIndexArray_few(), 'id', 'non-existent')).toEqual(-1)
#  )
#
#  it "should handle empty arrays", inject((utilService) ->
#    expect(utilService.getIndexByIdAttr([], 'non-id', 'non-value')).toEqual(-1)
#  )

describe "Unit:UtilService:parseJson", ->
  beforeEach(->
    angular.mock.module('Camfire')
  )

  it "should parse json", inject((testUtilService, utilService) ->
#    test = '{"type":"candidate","data":"{\"sdpMLineIndex\":1,\"sdpMid\":\"video\",\"candidate\":\"a=candidate:3382296128 2 udp 1845501695 74.137.84.63 59122 typ srflx raddr 192.168.0.105 rport 59122 generation 0\\r\\n\"}"}'
#    debug.log(test)
#    utilService.parseJson(test)
  )

describe "Unit:UtilService:moveById", ->
  beforeEach(->
    angular.mock.module('Camfire')
  )

  it "should move specified value from source to destination", inject((testUtilService, utilService) ->
    indexItem = testUtilService.getAnonymousIndexItem()
    index = indexItem[testUtilService.TEST_INDEX]
    src = testUtilService.getAnonymousIndexArray_few()
    src[index] = indexItem
    dest = {}
    expect(src[index]).toBeDefined()
    expect(dest[index]).not.toBeDefined()
    utilService.moveById(src, dest, index)
    expect(src[index]).not.toBeDefined()
    expect(dest[index]).toBeDefined()
  )

  it "should throw error if source item does not exist", inject((testUtilService, utilService) ->
    src = testUtilService.getAnonymousIndexArray_few()
    expect(->
      utilService.moveById(src, {}, 'non-extent')
    ).toThrow(new Error("Illegal Argument"))
  )

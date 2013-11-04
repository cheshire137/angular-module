namespace 'camfire', (exports) ->
  exports.app.service 'testUtilService', ($rootScope, utilService) ->
    {
    TEST_INDEX: 'sessionIdHash'

    getAnonymousIndexItem: ->
      item = {}
      item[@TEST_INDEX] = uuidV4()
      item

    getAnonymousIndexArray_few: ->
      object = {}
      for i in [0..2]
        utilService.indexItem(object, @getAnonymousIndexItem, @TEST_INDEX)
      object

    STREAM_INFO_ID: 'sessionIdHash'
    getAnonymousStreamInfo: ->
      {sessionIdHash: @getAnonymousSessionIdHash()}

    getAnonymousSessionIdHash: ->
      # This just returned a uuid prefixed with a dollar sign to mock a hashed session id
      "$#{uuidV4()}"
    }

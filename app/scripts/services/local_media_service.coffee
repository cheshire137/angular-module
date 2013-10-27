namespace 'camfire', (exports) ->
  exports.app.service 'localMediaService', ($rootScope, socketService) ->
    {
    # GetUserMedia success callback is here:
    localStream: null


    # Right now empty object is pushed here that triggers directive
    localStreams: []

    sessionIdHash: null
    }

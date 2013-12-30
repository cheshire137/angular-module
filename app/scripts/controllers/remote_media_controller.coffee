define(['namespace'], ->
  namespace 'camfire', (exports) ->
    class exports.RemoteMediaCtrl
      constructor: ($scope, utilService, remoteMediaService) ->
        $scope.remoteMediaService = remoteMediaService

        $scope.availableStreamInfos = remoteMediaService.availableStreamInfos
        $scope.connectingStreamInfos = remoteMediaService.connectingStreamInfos
        $scope.subscribedStreamInfos = remoteMediaService.subscribedStreamInfos
        $scope.areStreams =  remoteMediaService.areStreams()

        $scope.remoteStreams =  remoteMediaService.remoteStreams
        $scope.size = utilService.size

        $scope.$watch('remoteMediaService.availableStreamInfos', (data) ->
          $scope.availableStreamInfos = data
          $scope.areStreams = remoteMediaService.areStreams()
        , true)

        $scope.$watch('remoteMediaService.connectingStreamInfos', (data) ->
          $scope.connectingStreamInfos = data
          $scope.areStreams = remoteMediaService.areStreams()
        , true)

        $scope.$watch('remoteMediaService.subscribedStreamInfos', (data) ->
          $scope.subscribedStreamInfos = data
          $scope.areStreams = remoteMediaService.areStreams()
        , true)

  #      $scope.$watch('remoteMediaService.remoteStreams', (data) ->
  #        $scope.remoteStreams = data
  #      , true)


        $scope.subscribe = (sessionIdHash) ->
          remoteMediaService.subscribe(sessionIdHash)

)

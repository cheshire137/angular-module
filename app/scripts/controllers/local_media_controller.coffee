define(['namespace'], ->
  namespace 'camfire', (exports) ->
    class exports.LocalMediaCtrl
      constructor: ($scope, configurationService, userService, peerConnectionService, localMediaService) ->
        $scope.localStreams = localMediaService.localStreams
        $scope.state = 'ready'

        # Can you put this in a helper?
        $scope.userService = userService
        $scope.isLoggedIn = userService.isLoggedIn.val
        $scope.$watch('userService.isLoggedIn', (data) ->
          $scope.isLoggedIn = userService.isLoggedIn.val
        , true)

        $scope.start = ->
          $scope.state = 'started'
          $scope.localStreams.push({})

        $scope.stop = ->
          $scope.state = 'ready'
          peerConnectionService.stopLocalStreamAndBroadcast()
          $scope.localStreams.pop()

        $scope.broadcast = ->
          $scope.state = 'broadcasting'
          peerConnectionService.addStream(localMediaService.localStream)
          peerConnectionService.createOffer(configurationService.sdpConstraints)
)

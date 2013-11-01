namespace 'camfire', (exports) ->
  class exports.UserCtrl
#    constructor: ($scope, userService) ->
    constructor: ($scope, userService) ->
      $scope.userService = userService
      $scope.isLoggedIn = userService.isLoggedIn.val
      $scope.resource = userService.resource

      $scope.$watch('userService.isLoggedIn', (data) ->
        $scope.isLoggedIn = data.val
      , true)

      $scope.$watch('userService.resource', (data) ->
        $scope.resource = data
      , true)


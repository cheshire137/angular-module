"use strict"

# Controllers
angular.module(camfire.APP_NAME).controller "NavCtrl",
  ["$rootScope", "$scope", "$location", "Auth", ($rootScope, $scope, $location, Auth) ->
    $scope.user = Auth.user
    $scope.userRoles = Auth.userRoles
    $scope.accessLevels = Auth.accessLevels
    $scope.logout = ->
      Auth.logout (->
        $location.path "/login"
      ), ->
        $rootScope.error = "Failed to logout"

  ]
angular.module(camfire.APP_NAME).controller "LoginCtrl",
  ["$rootScope", "$scope", "$location", "$window", "Auth", ($rootScope, $scope, $location, $window, Auth) ->
    $scope.rememberme = true
    $scope.login = ->
      Auth.login
        username: $scope.username
        password: $scope.password
        rememberme: $scope.rememberme
      , ((res) ->
        $location.path "/"
      ), (err) ->
        $rootScope.error = "Failed to login"


    $scope.loginOauth = (provider) ->
      $window.location.href = "/auth/" + provider
  ]
angular.module(camfire.APP_NAME).controller "HomeCtrl", ["$rootScope", ($rootScope) ->
]
angular.module(camfire.APP_NAME).controller "RegisterCtrl",
  ["$rootScope", "$scope", "$location", "Auth", ($rootScope, $scope, $location, Auth) ->
    $scope.role = Auth.userRoles.user
    $scope.userRoles = Auth.userRoles
    $scope.register = ->
      Auth.register
        username: $scope.username
        password: $scope.password
        role: $scope.role
      , (->
        $location.path "/"
      ), (err) ->
        $rootScope.error = err

  ]
angular.module(camfire.APP_NAME).controller "PrivateCtrl", ["$rootScope", ($rootScope) ->
]
angular.module(camfire.APP_NAME).controller "AdminCtrl",
  ["$rootScope", "$scope", "Users", "Auth", ($rootScope, $scope, Users, Auth) ->
    $scope.loading = true
    $scope.userRoles = Auth.userRoles
    Users.getAll ((res) ->
      $scope.users = res
      $scope.loading = false
    ), (err) ->
      $rootScope.error = "Failed to fetch users."
      $scope.loading = false

  ]
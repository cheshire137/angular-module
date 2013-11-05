NAMESPACE = "camfire"

namespace NAMESPACE, (exports) ->
  exports.APP_NAME = APP_NAME = 'camfire'

#  exports.app = angular.module(APP_NAME, ["ngCookies"]).config("$routeProvider", "$locationProvider", "$httpProvider", ($routeProvider, $locationProvider, $httpProvider) ->
  exports.app = angular.module(APP_NAME, ['config', 'ngCookies']).config ($routeProvider, $locationProvider, $httpProvider) ->
    access = routingConfig.accessLevels
    $routeProvider.when "/",
      templateUrl: "home"
      controller: "HomeCtrl"
      access: access.user
#      access: access.anon

    $routeProvider.when "/login",
      templateUrl: "login"
      controller: "LoginCtrl"
      access: access.anon

    $routeProvider.when "/register",
      templateUrl: "register"
      controller: "RegisterCtrl"
      access: access.anon

    $routeProvider.when "/private",
      templateUrl: "private"
      controller: "PrivateCtrl"
      access: access.user

    $routeProvider.when "/admin",
      templateUrl: "admin"
      controller: "AdminCtrl"
      access: access.admin

    $routeProvider.when "/404",
      templateUrl: "404"
      access: access.public

    $routeProvider.otherwise redirectTo: "/404"
    $locationProvider.html5Mode true
    interceptor = ["$location", "$q", ($location, $q) ->
      success = (response) ->
        response
      error = (response) ->
        if response.status is 401
          $location.path "/login"
          $q.reject response
        else
          $q.reject response
      (promise) ->
        promise.then success, error
    ]
    $httpProvider.responseInterceptors.push interceptor



#    $routeProvider.when("/",
#      templateUrl: "views/index.html"
##      templateUrl: "views/main.html"
#  #    controller: "MainCtrl"
#    ).otherwise redirectTo: "/"

  # We will load all templates at start, this will prevent multiple get requests for each template.
  # see http://cuscuz-ads.blogspot.com/2012/12/abstract-by-default-angular-makes.html
  exports.app.run ['$window', '$templateCache'
  , ($window, $templateCache) ->
      templates = $window.JST

      for fileName, fileContent of templates
        $templateCache.put fileName, fileContent()
  ]

  exports.app.run ["$rootScope", "$location", "Auth", ($rootScope, $location, Auth) ->
    $rootScope.$on "$routeChangeStart", (event, next, current) ->
      $rootScope.error = null
      unless Auth.authorize(next.access)
        if Auth.isLoggedIn()
          $location.path "/"
        else
          $location.path "/login"
  ]




NAMESPACE = "camfire"

namespace NAMESPACE, (exports) ->
  exports.APP_NAME = APP_NAME = 'camfire'

  exports.app = angular.module(APP_NAME, ['config']).config ($routeProvider) ->
    $routeProvider.when("/",
      templateUrl: "views/main.html"
  #    controller: "MainCtrl"
    ).otherwise redirectTo: "/"

  # We will load all templates at start, this will prevent multiple get requests for each template.
  # see http://cuscuz-ads.blogspot.com/2012/12/abstract-by-default-angular-makes.html
  exports.app.run ['$window', '$templateCache'
  , ($window, $templateCache) ->
      templates = $window.JST

      for fileName, fileContent of templates
        $templateCache.put fileName, fileContent()
  ]


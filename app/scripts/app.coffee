NAMESPACE = "camfire"

namespace NAMESPACE, (exports) ->
  exports.APP_NAME = APP_NAME = 'camfire'

  exports.app = angular.module(APP_NAME, ['config', 'ngCookies']).config ($routeProvider, $locationProvider, $httpProvider) ->
    $httpProvider.defaults.withCredentials = true

  # We will load all templates at start, this will prevent multiple get requests for each template.
  # see http://cuscuz-ads.blogspot.com/2012/12/abstract-by-default-angular-makes.html
  exports.app.run ['$window', '$templateCache'
  , ($window, $templateCache) ->
      templates = JST

      for fileName, fileContent of templates
        $templateCache.put fileName, fileContent()
  ]


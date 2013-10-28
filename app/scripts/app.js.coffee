# namespace function from the coffeescript faq
@namespace = (target, name, block) ->
  [target, name, block] = [(if typeof exports isnt 'undefined' then exports else window), arguments...] if arguments.length < 3
  top    = target
  target = target[item] or= {} for item in name.split '.'
  block target, top

namespace 'camfire', (exports) ->
#  # Angular-devise
#  angular.module 'angularDevise.resources', ['ngResource']
#  angular.module 'angularDevise.services', ['ngResource']
#  angular.module 'angularDevise.directives', []
#  angular.module 'angularDevise.filters', []
#  angular.module 'angularDevise.controllers', ['ngCookies']

#  exports.app = angular.module('Camfire', ['angularSpinner',
#    #The Following are all angular-devise
#                                           'angularDevise.resources',
#                                           'angularDevise.services',
#                                           'angularDevise.directives',
#                                           'angularDevise.filters',
#                                           'angularDevise.controllers',
#                                           '$strap.directives'])

  exports.app = angular.module("yeomanAngularHamlApp", []).config ($routeProvider) ->
    $routeProvider.when("/",
      templateUrl: "views/main.html"
      controller: "MainCtrl"
    ).otherwise redirectTo: "/"

  # We will load all templates at start, this will prevent multiple get requests for each template.
  # see http://cuscuz-ads.blogspot.com/2012/12/abstract-by-default-angular-makes.html
  exports.app.run ['$window', '$templateCache'
  , ($window, $templateCache) ->
      templates = $window.JST

      for fileName, fileContent of templates
        $templateCache.put fileName, fileContent()
  ]
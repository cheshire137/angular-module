define(['app'], ->
  namespace 'camfire', (exports) ->
    exports.app.directive 'connectingStreamInfo', ($compile, $templateCache) ->
      restrict: 'E'
      template: '<div class="remote stream connecting"></div>'

      link: (scope, element, attrs) ->
        $base = $(element.children()[0])
        spinner = '<span us-spinner />'
        compiledSpinner = $compile(spinner)(scope)
        $base.html(compiledSpinner)
)

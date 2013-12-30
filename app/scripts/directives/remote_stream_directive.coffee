define(['app'], ->
  namespace 'camfire', (exports) ->
    exports.app.directive 'remoteStream', ($templateCache) ->
      restrict: 'E'
      template: $templateCache.get('remote_stream_template')

      link: (scope, element, attrs) ->
        content = $('video', element).get()[0]
        attachMediaStream content, scope.remoteStream.stream
)

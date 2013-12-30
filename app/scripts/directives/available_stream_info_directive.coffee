define(['app'], ->
  namespace 'camfire', (exports) ->
    exports.app.directive 'availableStreamInfo', ($templateCache) ->
      restrict: 'E'
      template: $templateCache.get('available_stream_info_template')
)


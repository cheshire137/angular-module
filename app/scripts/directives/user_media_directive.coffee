namespace 'camfire', (exports) ->
  exports.app.directive 'userMedia', ($templateCache, configurationService, localMediaService) ->
    restrict: 'E'
    template: $templateCache.get('user_media_template')

    link: (scope, element, attrs) ->
      content = $('video', element).get()[0]
      debug.debug "Requesting local stream"
      getUserMedia configurationService.media, ((stream) ->
        debug.debug "Received local stream"
        attachMediaStream content, stream
        localMediaService.localStream = stream
      ), ->
        throw new Error("Failed to get access to local media.")


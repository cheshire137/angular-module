namespace 'camfire', (exports) ->
  exports.app.directive 'bootstrapModal', ($compile, connectivityService) ->
    restrict: 'E'

    link: (scope, element, attrs) ->
      body = $('body')
      spinner = '<div class="loading-spinner fade" ><span us-spinner/></div>'
      compiledSpinner = $compile(spinner)(scope)
      body.modalmanager(spinner: compiledSpinner)

      # Below is a work around to prevent user from clicking away the loading modal.
      # see: https://github.com/jschr/bootstrap-modal/issues/41
      body.modalmanager('loading').find('.modal-scrollable').off('click.modalmanager')

      scope.status = connectivityService.status

      scope.$watch('status', (newValue, oldValue) ->
        wasConnected = oldValue.isConnected()
        isConnected = newValue.isConnected()
        debug.debug("connectivity status has been changed from [#{wasConnected}] to [#{isConnected}]")
        if wasConnected != isConnected
          body.modalmanager('loading')
      , true)




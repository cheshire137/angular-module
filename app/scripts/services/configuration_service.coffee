namespace 'camfire', (exports) ->
  exports.app.service "configurationService", ($rootScope) ->
    # The actual implementation of this depends on the environment. Check app/assets/javascripts/angular/config/environments
    new camfire.Configuration




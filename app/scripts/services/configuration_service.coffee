namespace 'camfire', (exports) ->
  exports.app.service "configurationService", ($rootScope, ENV) ->
    # The actual implementation of this depends on the environment.
    if ENV == 'development' then new camfire.DevelopmentConfiguration else new camfire.DevelopmentConfiguration



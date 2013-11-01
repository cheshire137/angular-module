#async.series({
#  before: (callback) ->
#    callback(null, ['lib/namespace', 'lib/adapter', 'lib/jsdebug', 'config', 'app'])
#  services: (callback) ->
#    $.get "scripts/services/dir-index.json", (data) ->
#      callback(null, data)
#  controllers: (callback) ->
#    $.get "scripts/controllers/dir-index.json", (data) ->
#      callback(null, data)
#  directives: (callback) ->
#    $.get "scripts/directives/dir-index.json", (data) ->
#      callback(null, data)
#  config: (callback) ->
#    $.get "scripts/config/dir-index.json", (data) ->
#      callback(null, data)
#  after: (callback) ->
#    callback(null, [])
#}, (err, results) ->
#
#  require([],  -> angular.bootstrap(document, [camfire.APP_NAME]))
#)

#includes = [].concat.apply([],
#  [results.before, results.services, results.controllers, results.directives, results.after])
#require(includes, ->)
#angular.bootstrap(document, ['camfire'])

require([
  'lib/namespace','lib/adapter','lib/jsdebug',
  'config',
  'config/development',
  'app',
  "services/configuration_service","services/connectivity_service","services/local_media_service","services/peer_connection_service","services/remote_media_service","services/signal_service","services/signal_service_socket_io","services/socket_service","services/user_service","services/util_service",
  "controllers/connectivity_controller","controllers/local_media_controller","controllers/main","controllers/remote_media_controller","controllers/user_controller",
  "directives/available_stream_info_directive","directives/bootstrap_modal_directive","directives/connecting_stream_info_directive","directives/remote_stream_directive","directives/template_directive","directives/user_media_directive"
],
  -> angular.bootstrap(document, [camfire.APP_NAME]))

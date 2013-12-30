define([
  'namespace'
#  'async'
  'jsdebugRails'
  'jqueryAtmosphere'
  './app'
  './jst',
  './services/configuration_service'
  './services/connectivity_service'
  './services/socket_service'
  './services/util_service'
  './services/peer_connection_service'
  './services/remote_media_service'
  './services/local_media_service'
  './services/signal_service'

  './controllers/connectivity_controller',
  './controllers/remote_media_controller',
  './controllers/local_media_controller',

  './directives/available_stream_info_directive',
  './directives/connecting_stream_info_directive',
  './directives/remote_stream_directive',
  './directives/template_directive',
  './directives/user_media_directive',
],
  ->
)




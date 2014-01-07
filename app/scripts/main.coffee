define([
  # Libraries
  'namespace',
#  'async'
  'jsdebugRails', # TODO: change this out for a different js logger library
  'jqueryAtmosphere',

  # Application
  './app',
  './jst',

  # Services
  './services/configuration_service',
  './services/connectivity_service',
  './services/socket_service',
  './services/util_service',
  './services/peer_connection_service',
  './services/remote_media_service',
  './services/local_media_service',
  './services/signal_service',

  # Controllers
  './controllers/connectivity_controller',
  './controllers/remote_media_controller',
  './controllers/local_media_controller',

  # Directives
  './directives/available_stream_info_directive',
  './directives/connecting_stream_info_directive',
  './directives/remote_stream_directive',
  './directives/template_directive',
  './directives/user_media_directive',
],
  ->
)




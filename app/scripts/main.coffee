require([
  'lib/namespace',
  'config',
  'config/development',
  'app',
  'controllers/controllers', 'directives/directives', 'services/services', 'config/routing'
  "services/configuration_service","services/connectivity_service","services/local_media_service","services/peer_connection_service","services/remote_media_service","services/signal_service","services/signal_service_socket_io","services/socket_service","services/user_service","services/util_service",
  "controllers/connectivity_controller","controllers/local_media_controller","controllers/remote_media_controller","controllers/user_controller",
  "directives/available_stream_info_directive","directives/bootstrap_modal_directive","directives/connecting_stream_info_directive","directives/remote_stream_directive","directives/template_directive","directives/user_media_directive"
],
  -> angular.bootstrap(document, [camfire.APP_NAME]))

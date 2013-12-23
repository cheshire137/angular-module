base = '../components/camfire-angular-module/'
baseTmpScripts = base + '.tmp/scripts/'
baseScripts = base + 'scripts/'

require([
  baseScripts + 'lib/adapter',

  baseTmpScripts + 'jst',
  baseTmpScripts + "services/configuration_service",
  baseTmpScripts + "services/connectivity_service",
  baseTmpScripts + "services/local_media_service",
  baseTmpScripts + "services/peer_connection_service",
  baseTmpScripts + "services/remote_media_service",
  baseTmpScripts + "services/signal_service",
  baseTmpScripts + "services/socket_service",
  baseTmpScripts + "services/util_service",

  baseTmpScripts + "controllers/connectivity_controller",
  baseTmpScripts + "controllers/local_media_controller",
  baseTmpScripts + "controllers/remote_media_controller",

  baseTmpScripts + "directives/available_stream_info_directive",
  baseTmpScripts + "directives/connecting_stream_info_directive",
  baseTmpScripts + "directives/remote_stream_directive",
  baseTmpScripts + "directives/template_directive",
  baseTmpScripts + "directives/user_media_directive",

  'lib/namespace',
  'config',
  'config/development',
  'app',
],
  -> angular.bootstrap(document, [camfire.APP_NAME]))

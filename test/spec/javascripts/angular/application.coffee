# These lines prevent jsdebug from logging messages in the karma tests.
window.debug.error = (msg) ->
window.debug.warn = (msg) ->
window.debug.info = (msg) ->
window.debug.debug = (msg) ->
# Note that I am reserving the log function in case I actually need to log through karma. It should only really be
# used to track changes. The other logging modes should be sufficient in normal practice.
#window.debug.log = (msg) ->

namespace 'camfire', (exports) ->
  # See: http://southdesign.de/blog/mock-angular-js-modules-for-test-di.html
  exports.appMock = angular.module("CamfireMock", [])






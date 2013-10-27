namespace 'camfire', (exports) ->
  class exports.ConnectivityCtrl
    constructor: ($scope, @connectivityService) ->
      @connectivityService.init()




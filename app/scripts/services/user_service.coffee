namespace 'camfire', (exports) ->
  class exports.UserService
#    constructor: () ->

    isLoggedIn: {val: false}
    resource: undefined

    login: ->
      @isLoggedIn.val = true

    logout: ->
      @isLoggedIn.val = false

  exports.app.service 'userService', camfire.UserService

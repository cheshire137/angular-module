((exports) ->

  # List all the roles you wish to use in the app
  #        * You have a max of 31 before the bit shift pushes the accompanying integer out of
  #        * the memory footprint for an integer
  #

  #
  #        Build out all the access levels you want referencing the roles listed above
  #        You can use the "*" symbol to represent access to all roles
  #

  #
  #        Method to build a distinct bit mask for each role
  #        It starts off with "1" and shifts the bit to the left for each element in the
  #        roles array parameter
  #
  buildRoles = (roles) ->
    bitMask = "01"
    userRoles = {}
    for role of roles
      intCode = parseInt(bitMask, 2)
      userRoles[roles[role]] =
        bitMask: intCode
        title: roles[role]

      bitMask = (intCode << 1).toString(2)
    userRoles

  #
  #    This method builds access level bit masks based on the accessLevelDeclaration parameter which must
  #    contain an array for each access level containing the allowed user roles.
  #
  buildAccessLevels = (accessLevelDeclarations, userRoles) ->
    accessLevels = {}
    for level of accessLevelDeclarations
      if typeof accessLevelDeclarations[level] is "string"
        if accessLevelDeclarations[level] is "*"
          resultBitMask = ""
          for role of userRoles
            resultBitMask += "1"

          #accessLevels[level] = parseInt(resultBitMask, 2);
          accessLevels[level] =
            bitMask: parseInt(resultBitMask, 2)
            title: accessLevelDeclarations[level]
        else
          console.log "Access Control Error: Could not parse '" + accessLevelDeclarations[level] + "' as access definition for level '" + level + "'"
      else
        resultBitMask = 0
        for role of accessLevelDeclarations[level]
          if userRoles.hasOwnProperty(accessLevelDeclarations[level][role])
            resultBitMask = resultBitMask | userRoles[accessLevelDeclarations[level][role]].bitMask
          else
            console.log "Access Control Error: Could not find role '" + accessLevelDeclarations[level][role] + "' in registered roles while building access for '" + level + "'"
        accessLevels[level] =
          bitMask: resultBitMask
          title: accessLevelDeclarations[level][role]
    accessLevels
  config =
    roles: ["public", "user", "admin"]
    accessLevels:
      # TODO: public is a reserved word in coffeescript, make sure quoting this works
      'public': "*"
      anon: ["public"]
      user: ["user", "admin"]
      admin: ["admin"]

  exports.userRoles = buildRoles(config.roles)
  exports.accessLevels = buildAccessLevels(config.accessLevels,
    exports.userRoles)) (if typeof exports is "undefined" then this["routingConfig"] = {} else exports)
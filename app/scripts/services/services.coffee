angular.module(camfire.APP_NAME).factory "Auth", ($http, $cookieStore) ->
  changeUser = (user) ->
    _.extend currentUser, user
  accessLevels = routingConfig.accessLevels
  userRoles = routingConfig.userRoles
  currentUser = $cookieStore.get("user") or
  username: ""
  role: userRoles.public

  $cookieStore.remove "user"
  authorize: (accessLevel, role) ->
    role = currentUser.role  if role is `undefined`
    accessLevel.bitMask & role.bitMask

  isLoggedIn: (user) ->
    user = currentUser  if user is `undefined`
    user.role.title is userRoles.user.title or user.role.title is userRoles.admin.title

  register: (user, success, error) ->
    $http.post("/register", user).success((res) ->
      changeUser res
      success()
    ).error error

  login: (user, success, error) ->
    $http.post("/login", user).success((user) ->
      changeUser user
      success user
    ).error error

  logout: (success, error) ->
    $http.post("/logout").success(->
      changeUser
        username: ""
        role: userRoles.public

      success()
    ).error error

  accessLevels: accessLevels
  userRoles: userRoles
  user: currentUser

angular.module(camfire.APP_NAME).factory "Users", ($http) ->
  getAll: (success, error) ->
    $http.get("/users").success(success).error error

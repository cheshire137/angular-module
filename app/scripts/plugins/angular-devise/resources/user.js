angular.module('angularDevise.resources').factory(
    'UserSession', ['$http', '$location', 'userService',
        function ($http, $location, userService) {

            var UserSession = function (options) {
                angular.extend(this, options);
            };

            UserSession.prototype.$save = function () {
                return $http.post('/users/sign_in.json', {
                    "user": {
                        "email": this.email,
                        "password": this.password,
                        "remember_me": this.remember_me ? 1 : 0
                    }
                }).success(function (response) {
                        if (response.success) {
                            userService.login();
                            userService.resource = response.resource;
                            $location.path('/');
                            alertify.success(response.message)
                        } else {
                            alertify.error(response.error)
                        }
                    });
            };

            UserSession.prototype.$destroy = function () {
                return $http.delete('/users/sign_out').success(function(response) {
                    userService.logout();
                    userService.resource = undefined;
                    alertify.success(response.message)
                });
            };

            return UserSession;

        }]);

angular.module('angularDevise.resources').factory('UserRegistration', ['$http', '$location', 'userService', function ($http, $location, userService) {

    var UserRegistration = function (options) {
        angular.extend(this, options);
    };

    UserRegistration.prototype.$save = function () {
        return $http.post('/users.json', {
            "user": {
                "email": this.email,
                "password": this.password,
                "password_confirmation": this.password_confirmation
            }
        }).success(function (response) {
                if (response.success) {
                    if (response.active) {
                        userService.login();
                        userService.resource = response.resource;
                        $location.path('/');
                        alertify.success(response.message)
                    } else {
                        // TODO: set notification
                    }
                } else {
                    response.errors.forEach(function (error) {
                        alertify.error(error)
                    });
                }
            }).error(function () {
                alertify.error("Sorry, there are serious server problems!")
            }
        );
    };

    return UserRegistration;

}]);
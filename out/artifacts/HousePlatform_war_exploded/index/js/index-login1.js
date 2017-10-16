(function($){
//        validator.resetForm();
    var app = angular.module('myApp', []);
    app.controller('myCtrl', function ($scope, $http, $timeout) {
        $http({
            method: 'POST',
            url: $("#path").val()+"/user/queryUser"
        }).then(function successCallback(response) {
            $scope.user = response.data.user;
        }, function errorCallback(response) {
        });
    });
}(jQuery));
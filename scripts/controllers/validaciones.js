'use strict';

app.controller('ngpatternCtrl', function ($scope) {

$scope.sendForm = function () {
if ($scope.text) {
    $scope.msg = "Form Validated";
    $scope.nombre=this.nombre;
    $scope.email=this.email;
    $scope.ciudad=this.ciudad;
    $scope.fecha=this.dt;
}

};

});

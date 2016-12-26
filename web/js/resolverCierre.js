angular.module('resolverCierreApp', []).controller('CierreCtrl', function ($scope) {
    
$scope.resolucion;
$scope.CambiarEstadoCierre = function (){
    $scope.resolucion = $scope.resolucion="CERRAR";
};
$scope.CambiarEstadoCorreccion = function (){
    $scope.resolucion = $scope.resolucion="CORRECCION";
};
  });

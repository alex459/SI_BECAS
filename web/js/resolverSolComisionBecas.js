/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

angular.module('resolverSolComisionBecasApp', []).controller('resolverSolComisionBecasCtrl', function ($scope) {
    
$scope.idTipo;
$scope.observacion;
$scope.resolucion="NO SE HA SELECCIONADO UNA OPCION";
$scope.CambiarEstadoAprobado = function (){
    $scope.resolucion = $scope.resolucion="APROBADO";
};
$scope.CambiarEstadoDenegado = function (){
    $scope.resolucion = $scope.resolucion="DENEGADO";
};
$scope.CambiarEstadoCorreccion = function (){
    $scope.resolucion = $scope.resolucion="CORRECCION";
};
  });

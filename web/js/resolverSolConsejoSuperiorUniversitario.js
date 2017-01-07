/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


angular.module('resolverSolConsejoSuperiorUniversitarioApp', []).controller('resolverSolConsejoSuperiorUniversitarioCtrl', function ($scope) {
    
$scope.idTipo;
$scope.observacion;
$scope.requerido = true;
$scope.obsReq = true;
$scope.resolucion;
$scope.tipoCorreccion = "documento";
$scope.mostrartipocorrecion = false;
$scope.CambiarEstadoAprobado = function (){
    $scope.resolucion = $scope.resolucion="APROBADO";
    $scope.requerido = $scope.requerido = true;
    $scope.obsReq = $scope.obsReq = true;
    $scope.obsReq = $scope.obsReq = !$scope.obsReq;
    $scope.mostrartipocorrecion = $scope.mostrartipocorrecion = false;
};
$scope.CambiarEstadoDenegado = function (){
    $scope.resolucion = $scope.resolucion="DENEGADO";
    $scope.requerido = $scope.requerido = true;
    $scope.obsReq = $scope.obsReq = true;
    $scope.mostrartipocorrecion = $scope.mostrartipocorrecion = false;
};
$scope.CambiarEstadoCorreccion = function (){
    $scope.resolucion = $scope.resolucion="CORRECCION";
    $scope.requerido = $scope.requerido = true;
    $scope.requerido = $scope.requerido = !$scope.requerido;
    $scope.obsReq = $scope.obsReq = true;
    $scope.mostrartipocorrecion = $scope.mostrartipocorrecion = false;
    $scope.mostrartipocorrecion = $scope.mostrartipocorrecion = !$scope.mostrartipocorrecion;
};
  })
  
.directive('validFile',function(){
    return {
        require:'ngModel',
        link:function(scope,el,attrs,ngModel){

            //change event is fired when file is selected
            el.bind('change',function(){
                 scope.$apply(function(){
                     ngModel.$setViewValue(el.val());
                     ngModel.$render();
                 });
            });
        }
    };
});

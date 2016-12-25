/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



angular.module('resolverSolFiscaliaAsesoriaContratoApp', []).controller('resolverSolFiscaliaAsesoriaContratoCtrl', function ($scope) {
    
$scope.idTipo;
$scope.observacion;
$scope.resolucion;
$scope.CambiarEstadoAprobado = function (){
    $scope.resolucion = $scope.resolucion="APROBADO";
};
$scope.CambiarEstadoDenegado = function (){
    $scope.resolucion = $scope.resolucion="DENEGADO";
};
$scope.CambiarEstadoCorreccion = function (){
    $scope.resolucion = $scope.resolucion="CORRECCION";
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


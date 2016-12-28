var resolverSolComisionBecasApp=angular.module('resolverSolComisionBecasApp', []);
resolverSolComisionBecasApp.controller('resolverSolComisionBecasCtrl',['$scope', function ($scope) {
    
$scope.idTipo;
$scope.observacion;
$scope.requerido = true;
$scope.obsReq = true;
$scope.resolucion;
$scope.CambiarEstadoAprobado = function (){
    $scope.resolucion = $scope.resolucion="APROBADO";
    $scope.requerido = $scope.requerido = true;
    $scope.obsReq = $scope.obsReq = true;
    $scope.obsReq = $scope.obsReq = !$scope.obsReq;
};
$scope.CambiarEstadoDenegado = function (){
    $scope.resolucion = $scope.resolucion="DENEGADO";
    $scope.requerido = $scope.requerido = true;
    $scope.obsReq = $scope.obsReq = true;
};
$scope.CambiarEstadoCorreccion = function (){
    $scope.resolucion = $scope.resolucion="CORRECCION";
    $scope.requerido = $scope.requerido = true;
    $scope.requerido = $scope.requerido = !$scope.requerido;
    $scope.obsReq = $scope.obsReq = true;
};
  }]);

resolverSolComisionBecasApp.directive('validFile',function(){
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

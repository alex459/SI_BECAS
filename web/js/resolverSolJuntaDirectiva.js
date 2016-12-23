var resolverSolJuntaDirectivaApp=angular.module('resolverSolJuntaDirectivaApp', []);
resolverSolJuntaDirectivaApp.controller('resolverSolJuntaDirectivaCtrl',['$scope', function ($scope) {
    
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
  }]);
  
  resolverSolJuntaDirectivaApp.directive('validFile',function(){
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


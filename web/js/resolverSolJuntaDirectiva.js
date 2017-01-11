var resolverSolJuntaDirectivaApp=angular.module('resolverSolJuntaDirectivaApp', []);
resolverSolJuntaDirectivaApp.controller('resolverSolJuntaDirectivaCtrl',['$scope', function ($scope) {
    
$scope.idTipo;
$scope.observacion;
$scope.requerido = true;
$scope.obsReq = true;
$scope.resolucion;
$scope.tipoCorreccion = "documento";
$scope.mostrartipocorrecion = false;
$scope.mostrarfechaprorroga = false;
$scope.fecharequerida = true;
$scope.CambiarEstadoAprobado = function (){
    $scope.resolucion = $scope.resolucion="APROBADO";
    $scope.requerido = $scope.requerido = true;
    $scope.obsReq = $scope.obsReq = true;
    $scope.obsReq = $scope.obsReq = !$scope.obsReq;
    $scope.mostrartipocorrecion = $scope.mostrartipocorrecion = false;
    $scope.mostrarfechaprorroga = $scope.mostrarfechaprorroga = false;
    $scope.mostrarfechaprorroga = $scope.mostrarfechaprorroga = !$scope.mostrarfechaprorroga;
    $scope.fecharequerida = $scope.fecharequerida = true;
};
$scope.CambiarEstadoDenegado = function (){
    $scope.resolucion = $scope.resolucion="DENEGADO";
    $scope.requerido = $scope.requerido = true;
    $scope.obsReq = $scope.obsReq = true;
    $scope.mostrartipocorrecion = $scope.mostrartipocorrecion = false;
    $scope.mostrarfechaprorroga = $scope.mostrarfechaprorroga = false;
    $scope.fecharequerida = $scope.fecharequerida = true;
    $scope.fecharequerida = $scope.fecharequerida = !$scope.fecharequerida;
};
$scope.CambiarEstadoCorreccion = function (){
    $scope.resolucion = $scope.resolucion="CORRECCION";
    $scope.requerido = $scope.requerido = true;
    $scope.requerido = $scope.requerido = !$scope.requerido;
    $scope.obsReq = $scope.obsReq = true;
    $scope.mostrartipocorrecion = $scope.mostrartipocorrecion = false;
    $scope.mostrartipocorrecion = $scope.mostrartipocorrecion = !$scope.mostrartipocorrecion;
    $scope.mostrarfechaprorroga = $scope.mostrarfechaprorroga = false;
    $scope.fecharequerida = $scope.fecharequerida = true;
    $scope.fecharequerida = $scope.fecharequerida = !$scope.fecharequerida;
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


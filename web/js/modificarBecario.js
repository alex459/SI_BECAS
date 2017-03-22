var solicitudApp=angular.module('ModificarBecaApp', []);
solicitudApp.controller('ModificarBecaCtrl', ['$scope',function ($scope) {
        $scope.mostrarBecario = false;
        $scope.mostrarExpediente = false;
        
        $scope.seleccionarBecario = function(){
            $scope.mostrarExpediente = $scope.mostrarExpediente = false;
            $scope.mostrarBecario = $scope.mostrarBecario = true;            
        };
        
        $scope.seleccionarExpediente = function(){
            $scope.mostrarBecario = $scope.mostrarBecario = false;
            $scope.mostrarExpediente = $scope.mostrarExpediente = true;
        };
}]);
  
  solicitudApp.directive('validFile',function(){
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
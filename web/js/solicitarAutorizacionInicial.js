var solicitudApp=angular.module('solicitudApp', []);
solicitudApp.controller('SolicitarAutorizacionCtrl',['$scope', function ($scope) {
    $scope.verFila = false;
    $scope.verAgregar= true;
    $scope.anexos =[];
    $scope.anexo = {};
    $scope.Nanexos= 1;
    $scope.tipoAnexo = [{id:101,
                         tipoDocumento:"CARTA DE SOLICITUD DE LA ESCUELA O DEPARTAMENTO"},
                        {id:102,
                         tipoDocumento:"CARTA DE SOLICITUD DE LA INSTITUCION QUE OFERTA LA BECA"}];
    
    $scope.agregar = function (){
     if($scope.Nanexos <=2){
        $scope.verFila = $scope.verFila = true;
        $scope.anexos.push({
           id: $scope.Nanexos,
           nombre: "anexo"+$scope.Nanexos,
           tipo: "tipoAnexo"+$scope.Nanexos
       });

       $scope.Nanexos=$scope.Nanexos+1;
       if($scope.Nanexos >2){
           $scope.verAgregar = $scope.verAgregar = false;
       }
     }else{
         $scope.verFila = $scope.verFila = false;   
        }
    };
    
    $scope.eliminar = function (item){
        if($scope.Nanexos <=0){
            
        }else{
            var index = $scope.anexos.indexOf(item);
            $scope.anexos.splice(index, 1);
            $scope.Nanexos=$scope.Nanexos-1;
            if($scope.Nanexos <=2){
                $scope.verFila = $scope.verAgregar = true;
            }
        }
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
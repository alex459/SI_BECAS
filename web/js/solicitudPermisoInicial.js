var solicitudApp=angular.module('solicitudApp', []);
solicitudApp.controller('SolicitarPermisoCtrl', ['$scope',function ($scope) {
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
    
    $scope.accCarta = "ninguna";
    $scope.accCartaEscuela = "ninguna";
    $scope.accCartaInstitucion = "ninguna";
    $scope.mostrarCarta = false;
    $scope.mostrarCartaEscuela = false;
    $scope.mostrarCartaInstitucion = false;
    $scope.EliminarCarta = function (){
        $scope.accCarta = $scope.accCarta="eliminar";        
        $scope.mostrarCarta = $scope.mostrarCarta = false;
    };
    $scope.EliminarCartaEscuela = function (){
        $scope.accCartaEscuela = $scope.accCartaEscuela="eliminar";
        $scope.mostrarCartaEscuela = $scope.mostrarCartaEscuela = false;
    };
    $scope.EliminarCartaInstitucion = function (){
        $scope.accCartaInstitucion = $scope.accCartaInstitucion="eliminar";
        $scope.mostrarCartaInstitucion = $scope.mostrarCartaInstitucion = false;
    };
    $scope.NadaCarta = function (){
        $scope.accCarta = $scope.accCarta="ninguna";        
        $scope.mostrarCarta = $scope.mostrarCarta = false;
    };
    $scope.NadaCartaEscuela = function (){
        $scope.accCartaEscuela = $scope.accCartaEscuela="ninguna";
        $scope.mostrarCartaEscuela = $scope.mostrarCartaEscuela = false;
    };
    $scope.NadaCartaInstitucion = function (){
        $scope.accCartaInstitucion = $scope.accCartaInstitucion="ninguna";
        $scope.mostrarCartaInstitucion = $scope.mostrarCartaInstitucion = false;
    };
    $scope.ActualizarCarta = function (){
        $scope.accCarta = $scope.accCarta="actualizar";
        $scope.mostrarCarta = $scope.mostrarCarta = false;
        $scope.mostrarCarta = $scope.mostrarCarta = !$scope.mostrarCarta;
    };
    $scope.ActualizarCartaEscuela = function (){
        $scope.accCartaEscuela = $scope.accCartaEscuela="actualizar";
        $scope.mostrarCartaEscuela = $scope.mostrarCartaEscuela = false;
        $scope.mostrarCartaEscuela = $scope.mostrarCartaEscuela = !$scope.mostrarCartaEscuela;
    };
    $scope.ActualizarCartaInstitucion = function (){
        $scope.accCartaInstitucion = $scope.accCartaInstitucion="actualizar";
        $scope.mostrarCartaInstitucion = $scope.mostrarCartaInstitucion = false;
        $scope.mostrarCartaInstitucion = $scope.mostrarCartaInstitucion = !$scope.mostrarCartaInstitucion;
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
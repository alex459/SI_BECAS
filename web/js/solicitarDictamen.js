var solicitudApp=angular.module('solicitudApp', []);
solicitudApp.controller('SolicitarDictamenCtrl', ['$scope',function ($scope) {
    $scope.verFila = false;
    $scope.verAgregar= true;
    $scope.anexos =[];
    $scope.anexo = {};
    $scope.Nanexos= 1;
    $scope.tipos= [{id:107, tipoDocumento: "Carta de recomendación de la Escuela o Departamento"},
                   {id:108, tipoDocumento: "Carta  de aceptación de la institución que ofrece la beca"},
                   {id:109, tipoDocumento: "Plan de Estudios"},
                   {id:110, tipoDocumento: "Constancia de la Unidad de Recursos Humanos del Tiempo de Servicio"},
                   {id:111, tipoDocumento: "Carta de legalización de maestría ante el MINED"}];
    
    $scope.agregar = function (){
     if($scope.Nanexos <=5){
        $scope.verFila = $scope.verFila = true;
        $scope.anexos.push({
           id: $scope.Nanexos,
           nombre: "anexo"+$scope.Nanexos,
           tipo: "tipoAnexo"+$scope.Nanexos
       });

       $scope.Nanexos=$scope.Nanexos+1;
       if($scope.Nanexos >5){
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
            if($scope.Nanexos <=5){
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
    $scope.accPlan = "ninguna";
    $scope.mostrarPlan = false;
    $scope.EliminarPlan = function (){
        $scope.accPlan = $scope.accPlan="eliminar";        
        $scope.mostrarPlan = $scope.mostrarPlan = false;
    };
    $scope.NadaPlan = function (){
        $scope.accPlan = $scope.accPlan="ninguna";        
        $scope.mostrarPlan = $scope.mostrarPlan = false;
    };
    $scope.ActualizarPlan = function (){
        $scope.accPlan = $scope.accPlan="actualizar";
        $scope.mostrarPlan = $scope.mostrarPlan = false;
        $scope.mostrarPlan = $scope.mostrarPlan = !$scope.mostrarPlan;
    };
    
    $scope.accConstanciaRRHH = "ninguna";
    $scope.mostrarConstanciaRRHH = false;
    $scope.EliminarConstanciaRRHH = function (){
        $scope.accConstanciaRRHH = $scope.accConstanciaRRHH="eliminar";        
        $scope.mostrarConstanciaRRHH = $scope.mostrarConstanciaRRHH = false;
    };
    $scope.NadaConstanciaRRHH = function (){
        $scope.accConstanciaRRHH = $scope.accConstanciaRRHH="ninguna";        
        $scope.mostrarConstanciaRRHH = $scope.mostrarConstanciaRRHH = false;
    };
    $scope.ActualizarConstanciaRRHH = function (){
        $scope.accConstanciaRRHH = $scope.accConstanciaRRHH="actualizar";
        $scope.mostrarConstanciaRRHH = $scope.mostrarConstanciaRRHH = false;
        $scope.mostrarConstanciaRRHH = $scope.mostrarConstanciaRRHH = !$scope.mostrarConstanciaRRHH;
    };
    $scope.accCartaMined = "ninguna";
    $scope.mostrarCartaMined = false;
    $scope.EliminarCartaMined = function (){
        $scope.accCartaMined = $scope.accCartaMined="eliminar";        
        $scope.mostrarCartaMined = $scope.mostrarCartaMined = false;
    };
    $scope.NadaCartaMined = function (){
        $scope.accCartaMined = $scope.accCartaMined="ninguna";        
        $scope.mostrarCartaMined = $scope.mostrarCartaMined = false;
    };
    $scope.ActualizarCartaMined = function (){
        $scope.accCartaMined = $scope.accCartaMined="actualizar";
        $scope.mostrarCartaMined = $scope.mostrarCartaMined = false;
        $scope.mostrarCartaMined = $scope.mostrarCartaMined = !$scope.mostrarCartaMined;
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
angular.module('AgregarBecaApp', []).controller('AgregarBecaCtrl', function ($scope) {
    $scope.checkOferta = !true;
    $scope.mostrarFormularioOferta = function (){
        if ($scope.checkOferta === true){
        $scope.checkOferta = $scope.checkOferta = false;
        $scope.checkOferta = $scope.checkOferta = !$scope.checkOferta;
    }else{
        $scope.checkOferta = $scope.checkOferta = !false;
        $scope.checkOferta = $scope.checkOferta = !$scope.checkOferta;
    }
    };
    
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
    $scope.activarEstudio = function(){
        $scope.verContractual = $scope.verContractual = false;  
        $scope.verCompromiso = $scope.verCompromiso = false;
        $scope.verLiberacion = $scope.verLiberacion = false;
        $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
        $scope.verFinReintegro = $scope.verFinReintegro = false;
    };
    $scope.verContractual = false;
    $scope.activarContractual = function(){
        $scope.verContractual = $scope.verContractual = false;  
        $scope.verCompromiso = $scope.verCompromiso = false;
        $scope.verLiberacion = $scope.verLiberacion = false;
        $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
        $scope.verFinReintegro = $scope.verFinReintegro = false;
        $scope.verContractual = $scope.verContractual = !$scope.verContractual;
    };
    $scope.verCompromiso = false;
    $scope.activarCompromiso = function(){
        $scope.verContractual = $scope.verContractual = false;  
        $scope.verCompromiso = $scope.verCompromiso = false;
        $scope.verLiberacion = $scope.verLiberacion = false;
        $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
        $scope.verFinReintegro = $scope.verFinReintegro = false;
        $scope.verContractual = $scope.verContractual = !$scope.verContractual;
        $scope.verCompromiso = $scope.verCompromiso = !$scope.verCompromiso;
    };
    $scope.verLiberacion = false;
    $scope.activarLiberacion = function(){
        $scope.verContractual = $scope.verContractual = false;  
        $scope.verCompromiso = $scope.verCompromiso = false;
        $scope.verLiberacion = $scope.verLiberacion = false;
        $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
        $scope.verFinReintegro = $scope.verFinReintegro = false;
        $scope.verContractual = $scope.verContractual = !$scope.verContractual;
        $scope.verCompromiso = $scope.verCompromiso = !$scope.verCompromiso;
        $scope.verLiberacion = $scope.verLiberacion = !$scope.verLiberacion;
    };
    $scope.verBecaFinalizada = false;
    $scope.activarBecaFinalizada = function(){
        $scope.verContractual = $scope.verContractual = false;  
        $scope.verCompromiso = $scope.verCompromiso = false;
        $scope.verLiberacion = $scope.verLiberacion = false;
        $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
        $scope.verFinReintegro = $scope.verFinReintegro = false;
        $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
        $scope.verContractual = $scope.verContractual = !$scope.verContractual;
        $scope.verCompromiso = $scope.verCompromiso = !$scope.verCompromiso;
        $scope.verLiberacion = $scope.verLiberacion = !$scope.verLiberacion;
        $scope.verBecaFinalizada = $scope.verBecaFinalizada = !$scope.verBecaFinalizada;
    };
    
    $scope.verFinReintegro = false;
    $scope.activarFinReintegro = function(){
        $scope.verContractual = $scope.verContractual = false;  
        $scope.verCompromiso = $scope.verCompromiso = false;
        $scope.verLiberacion = $scope.verLiberacion = false;
        $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
        $scope.verFinReintegro = $scope.verFinReintegro = false;
        $scope.verFinReintegro = $scope.verFinReintegro = !$scope.verFinReintegro;
    };
    
});



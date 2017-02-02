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
    $scope.accProyecto = "ninguna";
    $scope.mostrarProyecto = false;
    $scope.EliminarProyecto = function (){
        $scope.accProyecto = $scope.accProyecto="eliminar";        
        $scope.mostrarProyecto = $scope.mostrarProyecto = false;
    };
    $scope.NadaProyecto = function (){
        $scope.accProyecto = $scope.accProyecto="ninguna";        
        $scope.mostrarProyecto = $scope.mostrarProyecto = false;
    };
    $scope.ActualizarProyecto = function (){
        $scope.accProyecto = $scope.accProyecto="actualizar";
        $scope.mostrarProyecto = $scope.mostrarProyecto = false;
        $scope.mostrarProyecto = $scope.mostrarProyecto = !$scope.mostrarProyecto;
    };
    
    $scope.accDui = "ninguna";
    $scope.mostrarDui = false;
    $scope.EliminarDui = function (){
        $scope.accDui = $scope.accDui="eliminar";        
        $scope.mostrarDui = $scope.mostrarDui = false;
    };
    $scope.NadaDui = function (){
        $scope.accDui = $scope.accDui="ninguna";        
        $scope.mostrarDui = $scope.mostrarDui = false;
    };
    $scope.ActualizarDui = function (){
        $scope.accDui = $scope.accDui="actualizar";
        $scope.mostrarDui = $scope.mostrarDui = false;
        $scope.mostrarDui = $scope.mostrarDui = !$scope.mostrarDui;
    };
    
    $scope.accNombramiento = "ninguna";
    $scope.mostrarNombramiento = false;
    $scope.NadaNombramiento = function (){
        $scope.accNombramiento = $scope.accNombramiento="ninguna";        
        $scope.mostrarNombramiento = $scope.mostrarNombramiento = false;
    };
    $scope.ActualizarNombramiento = function (){
        $scope.accNombramiento = $scope.accNombramiento="actualizar";
        $scope.mostrarNombramiento = $scope.mostrarNombramiento = false;
        $scope.mostrarNombramiento = $scope.mostrarNombramiento = !$scope.mostrarNombramiento;
    };
    
    $scope.accCartaJefe = "ninguna";
    $scope.mostrarCartaJefe = false;
    $scope.NadaCartaJefe = function (){
        $scope.accCartaJefe = $scope.accCartaJefe="ninguna";        
        $scope.mostrarCartaJefe = $scope.mostrarCartaJefe = false;
    };
    $scope.ActualizarCartaJefe = function (){
        $scope.accCartaJefe = $scope.accCartaJefe="actualizar";
        $scope.mostrarCartaJefe = $scope.mostrarCartaJefe = false;
        $scope.mostrarCartaJefe = $scope.mostrarCartaJefe = !$scope.mostrarCartaJefe;
    };
    
    $scope.accConstanciaExpediente = "ninguna";
    $scope.mostrarConstanciaExpediente = false;
    $scope.NadaConstanciaExpediente = function (){
        $scope.accConstanciaExpediente = $scope.accConstanciaExpediente="ninguna";        
        $scope.mostrarConstanciaExpediente = $scope.mostrarConstanciaExpediente = false;
    };
    $scope.ActualizarConstanciaExpediente = function (){
        $scope.accConstanciaExpediente = $scope.accConstanciaExpediente="actualizar";
        $scope.mostrarConstanciaExpediente = $scope.mostrarConstanciaExpediente = false;
        $scope.mostrarConstanciaExpediente = $scope.mostrarConstanciaExpediente = !$scope.mostrarConstanciaExpediente;
    };
    
    $scope.accConstanciaMedica = "ninguna";
    $scope.mostrarConstanciaMedica = false;
    $scope.NadaConstanciaMedica = function (){
        $scope.accConstanciaMedica = $scope.accConstanciaMedica="ninguna";        
        $scope.mostrarConstanciaMedica = $scope.mostrarConstanciaMedica = false;
    };
    $scope.ActualizarConstanciaMedica = function (){
        $scope.accConstanciaMedica = $scope.accConstanciaMedica="actualizar";
        $scope.mostrarConstanciaMedica = $scope.mostrarConstanciaMedica = false;
        $scope.mostrarConstanciaMedica = $scope.mostrarConstanciaMedica = !$scope.mostrarConstanciaMedica;
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
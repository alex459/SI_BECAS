
angular.module('solicitudbecaApp', ["ngRoute"]).config(function($routeProvider){
    $routeProvider
    .when("/",{
        templateUrl: "308_candidato_sol_beca1.html"
    })
    .when("/laboral",{
        templateUrl: "309_candidato_sol_beca2.html"
    })
    .when("/educacion",{
        templateUrl: "310_candidato_sol_beca3.html"
    })
    .when("/cargos",{
        templateUrl: "311_candidato_sol_beca4.html"
    })
    .when("/oferta",{
        templateUrl: "312_candidato_sol_beca5.html"
    })
    .when("/referencias",{
        templateUrl: "313_candidato_sol_beca6.html"
    })
    .when("/documentos",{
        templateUrl: "314_candidato_sol_beca7.html"
    });
})
.controller('solicitudCtrl', function($scope) {
    
    $scope.action= "";
    $scope.oferta={};
    $scope.data = {nombre:"",
    nombre2: "",
    apellido1: "",
    apellido2: "",
    fecha_nacimiento:"",
    departamento_nacimiento:"",
    municipio_nacimiento:"",
    genero:"",
    direccion:"",
    departamento_direccion:"",
    municipio_direccion:"",
    tel_casa:"",
    tel_movil:"",
    tel_oficina:"",
    
    profesion:"",
    cargo:"",
    unidad:"",
    facultad:"",
    fecha_contratacion:"",

    educacion:[{
        id: 1,
        tipo: "tipoEducacion1",
        grado: "grado1",
        institucion: "institucion1",
        anyo: "anyo1"
    }],
    proyectos:[{
         id: 1,
         titulo: "tituloProyecto1",
            publicado: "publicado1"
        }],
    idiomas:[{
            id: 1,
            idioma: "idioma1",
            nivelHabla: "nivelHabla1",
            nivelEscritura: "nivelEscritura1",
            nivelLectura: "nivelLectura1"
        }],
    asociaciones:[{
            id: 1,
            asociacion: "asociacion1"
        }],
    cargos:[{
            id: 1,
            lugar: "lugarCargo1",
            cargo: "cargoAnterior1",
            fechaInicio: "fechaInicioCargo1",
            fechaFin: "fechaFinCargo1",
            responsabilidades: "responsabilidad1"
        }],
    beneficios:"",
    
    programas:[{
            semestre: "semestre1",
            programa: "programa1"
    }],
    nombre1R1:"",
    nombre2R1:"",
    apellido1R1:"",
    apellido2R1:"",
    direccionR1:"",
    departamentoR1:"",
    municipioR1:"",
    telefonoR1:"",
    
    nombre1R2:"",
    nombre2R2:"",
    apellido1R2:"",
    apellido2R2:"",
    direccionR2:"",
    departamentoR2:"",
    municipioR2:"",
    telefonoR2:"",
    
    nombre1R3:"",
    nombre2R3:"",
    apellido1R3:"",
    apellido2R3:"",
    direccionR3:"",
    departamentoR3:"",
    municipioR3:"",
    telefonoR3:""
    };

    $scope.aux={
        auxTipoEdu :{},
        auxGradoEdu : {},
        auxInstitucionEdu : {},
        auxAnyoEdu :{},
        
        auxTituloProy:{},
        auxPublicado:{},
        
        auxIdioma:{},
        auxNivelHabla:{},
        auxNivelEscritura:{},
        auxNivelLectura:{},
        
        auxAsociacion:{},
        
        auxLugar: {},
        auxCargo: {},
        auxFechaInicio: {},
        auxFechaFin: {},
        auxResponsabilidades: {},
        
        auxSemestre:{},
        auxPrograma:{}
        
    };
    
    $scope.edu={};  
    $scope.Nedu= 2;
    $scope.verAgregarEducacion= true;
    $scope.agregarEducacion = function(){
    if($scope.Nedu <=7){
        $scope.data.educacion.push({
            id: $scope.Nedu,
            tipo: "tipoEducacion"+$scope.Nedu,
            grado: "grado"+$scope.Nedu,
            institucion: "institucion"+$scope.Nedu,
            anyo: "anyo"+$scope.Nedu
        });
    }
        $scope.Nedu=$scope.Nedu+1;
        if($scope.Nedu >7){
           $scope.verAgregarEducacion = $scope.verAgregarEducacion = false;
       }
    };
    $scope.eliminarEducacion = function (item){
        if($scope.Nedu <=1){
            
        }else{
            var index = $scope.data.educacion.indexOf(item);
            $scope.data.educacion.splice(index, 1);
            $scope.Nedu=$scope.Nedu-1;
            if($scope.Nedu <=7){
                $scope.verAgregarEducacion = $scope.verAgregarEducacion = true;
            }
        }
    };
    
    $scope.proy={};
    $scope.Nproy= 2;
    $scope.verAgregarProyecto= true;
    $scope.checkProyecto = false;
    $scope.agregarProyecto = function(){
    if($scope.Nproy <=4){
        $scope.data.proyectos.push({
            id: $scope.Nproy,
            titulo: "tituloProyecto"+$scope.Nproy,
            publicado: "publicado"+$scope.Nproy
        });
    }
        $scope.Nproy=$scope.Nproy+1;
        if($scope.Nproy >4){
           $scope.verAgregarProyecto = $scope.verAgregarProyecto = false;
       }
       $scope.proy.titulo_proyecto ="";
       $scope.proy.publicado ="";
 
    };
    $scope.eliminarProyecto = function (item){
        if($scope.Nproy <=1){
            
        }else{
            var index = $scope.data.proyectos.indexOf(item);
            $scope.data.proyectos.splice(index, 1);
            $scope.Nproy=$scope.Nproy-1;
            if($scope.Nproy <=4){
                $scope.verAgregarProyecto = $scope.verAgregarProyecto = true;
            }
        }
    };
    
    $scope.idi={};  
    $scope.Nidi= 2;
    $scope.verAgregarIdioma= true;
    $scope.agregarIdioma = function(){
    if($scope.Nidi <=7){
        $scope.data.idiomas.push({
            id: $scope.Nidi,
            idioma: "idioma"+$scope.Nidi,
            nivelHabla: "nivelHabla"+$scope.Nidi,
            nivelEscritura: "nivelEscritura"+$scope.Nidi,
            nivelLectura: "nivelLectura"+$scope.Nidi
        });
    }
        $scope.Nidi=$scope.Nidi+1;
        if($scope.Nidi >7){
           $scope.verAgregarIdioma = $scope.verAgregarIdioma = false;
       }
    };
    $scope.eliminarIdioma = function (item){
        if($scope.Nedu <=1){
            
        }else{
            var index = $scope.data.idiomas.indexOf(item);
            $scope.data.idiomas.splice(index, 1);
            $scope.Nidi=$scope.Nidi-1;
            if($scope.Nidi <=7){
                $scope.verAgregarIdioma = $scope.verAgregarIdioma = true;
            }
        }
    };
    
    $scope.aso={};  
    $scope.checkAsociacion = false;
    $scope.Naso= 2;
    $scope.verAgregarAsociacion= true;
    $scope.agregarAsociacion = function(){
    if($scope.Nedu <=3){
        $scope.data.asociaciones.push({
            id: $scope.Naso,
            asociacion: "asociacion"+$scope.Naso
        });
    }
        $scope.Naso=$scope.Naso+1;
        if($scope.Naso >3){
           $scope.verAgregarAsociacion = $scope.verAgregarAsociacion = false;
       }
    };
    $scope.eliminarAsociacion = function (item){
        if($scope.Naso <=1){
            
        }else{
            var index = $scope.data.asociaciones.indexOf(item);
            $scope.data.asociaciones.splice(index, 1);
            $scope.Naso=$scope.Naso-1;
            if($scope.Naso <=3){
                $scope.verAgregarAsociacion = $scope.verAgregarAsociacion = true;
            }
        }
    };
    
    $scope.car={};  
    $scope.Ncar= 2;
    $scope.verAgregarCargo= true;
    $scope.agregarCargo = function(){
    if($scope.Ncar <=3){
        $scope.data.cargos.push({
            id: $scope.Ncar,
            lugar: "lugarCargo"+$scope.Ncar,
            cargo: "cargoAnterior"+$scope.Ncar,
            fechaInicio: "fechaInicioCargo"+$scope.Ncar,
            fechaFin: "fechaFinCargo"+$scope.Ncar,
            responsabilidades: "responsabilidad"+$scope.Ncar
        });
    }
        $scope.Ncar=$scope.Ncar+1;
        if($scope.Ncar >3){
           $scope.verAgregarCargo = $scope.verAgregarCargo = false;
       }
    };
    $scope.eliminarCargo = function (item){
        if($scope.Ncar <=1){
            
        }else{
            var index = $scope.data.cargos.indexOf(item);
            $scope.data.cargos.splice(index, 1);
            $scope.Ncar=$scope.Ncar-1;
            if($scope.Ncar <=3){
                $scope.verAgregarCargo = $scope.verAgregarCargo = true;
            }
        }
    };
    

    $scope.Npro= 2;
    $scope.verAgregarPrograma= true;
    $scope.agregarPrograma = function(){
    if($scope.Npro <=12){
        $scope.data.programas.push({
            semestre: "semestre"+$scope.Npro,
            programa: "programa"+$scope.Npro
        });
    }
        $scope.Npro=$scope.Npro+1;
        if($scope.Npro >12){
           $scope.verAgregarPrograma = $scope.verAgregarPrograma = false;
       }
    };
    $scope.eliminarPrograma = function (item){
        if($scope.Npro <=1){
            
        }else{
            var index = $scope.data.programas.indexOf(item);
            $scope.data.programas.splice(index, 1);
            $scope.Npro=$scope.Npro-1;
            if($scope.Npro <=12){
                $scope.verAgregarPrograma = $scope.verAgregarPrograma = true;
            }
        }
    };

});
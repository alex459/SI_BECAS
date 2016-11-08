
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

    educacion:[],
    proyectos:[]



    };

    $scope.edu={};
    $scope.proy={};

    $scope.addEducacion = function(){
        $scope.data.educacion.push({
            tipo_educacion: $scope.edu.tipo_educacion,
            grado_alcanzado: $scope.edu.grado_alcanzado,
            nombre_institucion: $scope.edu.nombre_institucion,
            anyo_educacion: $scope.edu.anyo_educacion
        });

        $scope.edu.tipo_educacion ="";
        $scope.edu.grado_alcanzado ="";
        $scope.edu.nombre_institucion ="";
        $scope.edu.anyo_educacion ="";
    };

    $scope.addProyecto = function(){
        $scope.data.proyectos.push({
            titulo_proyecto: $scope.proy.titulo_proyecto,
            publicado: $scope.proy.publicado
        });

        $scope.proy.titulo_proyecto ="";
        $scope.proy.publicado ="";
    };

});
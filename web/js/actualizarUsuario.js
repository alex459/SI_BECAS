angular.module('ActualizarUsuarioApp', []).controller('ActualizarUsuarioCtrl', function ($scope) {
    
$scope.datos={tipoUsuario:''};    
    $scope.mostrarfacultades= function(){
        if ($scope.datos.tipoUsuario < 5){
            $scope.facultades=$scope.facultades=[{id:1,nombre:'JURISPRUDENCIA Y CIENCIAS SOCIALES'},
                       {id:2,nombre:'INGENIERÍA Y ARQUITECTURA'},
                       {id:3,nombre:'MEDICINA'},
                       {id:4,nombre:'ODONTOLOGÍA'},
                       {id:5,nombre:'MULTIDISCIPLINARIA PARACENTRAL'},
                       {id:6,nombre:'MULTIDISCIPLINARIA ORIENTAL'},
                       {id:7,nombre:'MULTIDISCIPLINARIA DE OCCIDENTE'},
                       {id:8,nombre:'QUÍMICA Y FARMACIA'},
                       {id:9,nombre:'CIENCIAS AGRONÓMICAS'},
                       {id:10,nombre:'CIENCIAS Y HUMANIDADES'},
                       {id:11,nombre:'CIENCIAS NATURALES MATEMÁTICA'},
                       {id:12,nombre:'CIENCIAS ECONÓMICAS'}
                   ];
        }else{
            $scope.facultades=$scope.facultades=[{id:13,nombre:'ADMINISTRATIVO'}];
        }
    };
    $scope.facultades=[{id:0,nombre:'SELECCIONE UN ROL'}];
    
  });
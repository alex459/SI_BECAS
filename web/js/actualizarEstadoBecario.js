angular.module('ActualizarEstadoBecarioApp', []).controller('ActualizarEstadoBecarioCtrl', function ($scope) {   
 
    var option1Options = ["ACTIVO","CONTRACTUAL","INACTIVO","LIBERADO"];
    var option2Options = [["REALIZACION DE ESTUDIOS DE POSTGRADO","ACUERDO FISCAL","ENTREGA DOCUMENTOS FINALIZACION DE BECA",
                    "ACUERDO DE PRORROGA DE JUNTA DIRECTIVA","ACUERDO DE PRORROGA CONSEJO DE BECAS","ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO"],
                ["CUMPLIMIENTO DE SERVICIO CONTRACTUAL","ACUERDO DE GESTION DE COMPROMISO CONTRACTUAL",
                    "ACUERDO DE GESTION DE LIBERACION","ACUERDO DE LIBERACION DE BECARIO"],
                ["INACTIVO"],
                ["BECA FINALIZADA"]];
    $scope.options1 = option1Options;
    $scope.options2 = [];
   
   $scope.getOptions2 = function(){
        var key = $scope.options1.indexOf($scope.option1);
        var myNewOptions = option2Options[key];
        $scope.options2 = myNewOptions;
    };
});


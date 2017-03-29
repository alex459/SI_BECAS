var solicitudApp = angular.module('ModificarBecaApp', []);
solicitudApp.controller('ModificarBecaCtrl', ['$scope', function ($scope) {
        $scope.mostrarBecario = false;
        $scope.mostrarExpediente = false;

        $scope.seleccionarBecario = function () {
            $scope.mostrarExpediente = $scope.mostrarExpediente = false;
            $scope.mostrarBecario = $scope.mostrarBecario = true;
        };

        $scope.seleccionarExpediente = function () {
            $scope.mostrarBecario = $scope.mostrarBecario = false;
            $scope.mostrarExpediente = $scope.mostrarExpediente = true;
        };

        $scope.activarEstudio = function () {
            $scope.verContractual = $scope.verContractual = false;
            $scope.verCompromiso = $scope.verCompromiso = false;
            $scope.verLiberacion = $scope.verLiberacion = false;
            $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
            $scope.verFinReintegro = $scope.verFinReintegro = false;
        };
        $scope.verContractual = false;
        $scope.activarContractual = function () {
            $scope.verContractual = $scope.verContractual = false;
            $scope.verCompromiso = $scope.verCompromiso = false;
            $scope.verLiberacion = $scope.verLiberacion = false;
            $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
            $scope.verFinReintegro = $scope.verFinReintegro = false;
            $scope.verContractual = $scope.verContractual = !$scope.verContractual;
        };
        $scope.verCompromiso = false;
        $scope.activarCompromiso = function () {
            $scope.verContractual = $scope.verContractual = false;
            $scope.verCompromiso = $scope.verCompromiso = false;
            $scope.verLiberacion = $scope.verLiberacion = false;
            $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
            $scope.verFinReintegro = $scope.verFinReintegro = false;
            $scope.verContractual = $scope.verContractual = !$scope.verContractual;
            $scope.verCompromiso = $scope.verCompromiso = !$scope.verCompromiso;
        };
        $scope.verLiberacion = false;
        $scope.activarLiberacion = function () {
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
        $scope.activarBecaFinalizada = function () {
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
        $scope.activarFinReintegro = function () {
            $scope.verContractual = $scope.verContractual = false;
            $scope.verCompromiso = $scope.verCompromiso = false;
            $scope.verLiberacion = $scope.verLiberacion = false;
            $scope.verBecaFinalizada = $scope.verBecaFinalizada = false;
            $scope.verFinReintegro = $scope.verFinReintegro = false;
            $scope.verFinReintegro = $scope.verFinReintegro = !$scope.verFinReintegro;
        };

        //Documentos
        $scope.accpermisoGestion = "ninguna";
        $scope.mostrarpermisoGestion = false;
        $scope.NadapermisoGestion = function () {
            $scope.accpermisoGestion = $scope.accpermisoGestion = "ninguna";
            $scope.mostrarpermisoGestion = $scope.mostrarpermisoGestion = false;
        };
        $scope.ActualizarpermisoGestion = function () {
            $scope.accpermisoGestion = $scope.accpermisoGestion = "actualizar";
            $scope.mostrarpermisoGestion = $scope.mostrarpermisoGestion = false;
            $scope.mostrarpermisoGestion = $scope.mostrarpermisoGestion = !$scope.mostrarpermisoGestion;
        };

        $scope.accautorizacionInicial = "ninguna";
        $scope.mostrarautorizacionInicial = false;
        $scope.NadaautorizacionInicial = function () {
            $scope.accautorizacionInicial = $scope.accautorizacionInicial = "ninguna";
            $scope.mostrarautorizacionInicial = $scope.mostrarautorizacionInicial = false;
        };
        $scope.ActualizarautorizacionInicial = function () {
            $scope.accautorizacionInicial = $scope.accautorizacionInicial = "actualizar";
            $scope.mostrarautorizacionInicial = $scope.mostrarautorizacionInicial = false;
            $scope.mostrarautorizacionInicial = $scope.mostrarautorizacionInicial = !$scope.mostrarautorizacionInicial;
        };

        $scope.accdictamen = "ninguna";
        $scope.mostrardictamen = false;
        $scope.Nadadictamen = function () {
            $scope.accdictamen = $scope.accdictamen = "ninguna";
            $scope.mostrardictamen = $scope.mostrardictamen = false;
        };
        $scope.Actualizardictamen = function () {
            $scope.accdictamen = $scope.accdictamen = "actualizar";
            $scope.mostrardictamen = $scope.mostrardictamen = false;
            $scope.mostrardictamen = $scope.mostrardictamen = !$scope.mostrardictamen;
        };

        $scope.accacuerdoBecaJD = "ninguna";
        $scope.mostraracuerdoBecaJD = false;
        $scope.NadaacuerdoBecaJD = function () {
            $scope.accacuerdoBecaJD = $scope.accacuerdoBecaJD = "ninguna";
            $scope.mostraracuerdoBecaJD = $scope.mostraracuerdoBecaJD = false;
        };
        $scope.ActualizaracuerdoBecaJD = function () {
            $scope.accacuerdoBecaJD = $scope.accacuerdoBecaJD = "actualizar";
            $scope.mostraracuerdoBecaJD = $scope.mostraracuerdoBecaJD = false;
            $scope.mostraracuerdoBecaJD = $scope.mostraracuerdoBecaJD = !$scope.mostraracuerdoBecaJD;
        };

        $scope.accacuerdoBecaCNB = "ninguna";
        $scope.mostraracuerdoBecaCNB = false;
        $scope.NadaacuerdoBecaCNB = function () {
            $scope.accacuerdoBecaCNB = $scope.accacuerdoBecaCNB = "ninguna";
            $scope.mostraracuerdoBecaCNB = $scope.mostraracuerdoBecaCNB = false;
        };
        $scope.ActualizaracuerdoBecaCNB = function () {
            $scope.accacuerdoBecaCNB = $scope.accacuerdoBecaCNB = "actualizar";
            $scope.mostraracuerdoBecaCNB = $scope.mostraracuerdoBecaCNB = false;
            $scope.mostraracuerdoBecaCNB = $scope.mostraracuerdoBecaCNB = !$scope.mostraracuerdoBecaCNB;
        };

        $scope.accacuerdoBecaCSU = "ninguna";
        $scope.mostraracuerdoBecaCSU = false;
        $scope.NadaacuerdoBecaCSU = function () {
            $scope.accacuerdoBecaCSU = $scope.accacuerdoBecaCSU = "ninguna";
            $scope.mostraracuerdoBecaCSU = $scope.mostraracuerdoBecaCSU = false;
        };
        $scope.ActualizaracuerdoBecaCSU = function () {
            $scope.accacuerdoBecaCSU = $scope.accacuerdoBecaCSU = "actualizar";
            $scope.mostraracuerdoBecaCSU = $scope.mostraracuerdoBecaCSU = false;
            $scope.mostraracuerdoBecaCSU = $scope.mostraracuerdoBecaCSU = !$scope.mostraracuerdoBecaCSU;
        };

        $scope.acccontrato = "ninguna";
        $scope.mostrarcontrato = false;
        $scope.Nadacontrato = function () {
            $scope.acccontrato = $scope.acccontrato = "ninguna";
            $scope.mostrarcontrato = $scope.mostrarcontrato = false;
        };
        $scope.Actualizarcontrato = function () {
            $scope.acccontrato = $scope.acccontrato = "actualizar";
            $scope.mostrarcontrato = $scope.mostrarcontrato = false;
            $scope.mostrarcontrato = $scope.mostrarcontrato = !$scope.mostrarcontrato;
        };
        
        $scope.acctituloObtenido = "ninguna";
$scope.mostrartituloObtenido = false;
$scope.NadatituloObtenido = function (){
        $scope.acctituloObtenido = $scope.acctituloObtenido="ninguna";        
        $scope.mostrartituloObtenido = $scope.mostrartituloObtenido = false;
    };
$scope.ActualizartituloObtenido = function (){
        $scope.acctituloObtenido = $scope.acctituloObtenido="actualizar";
        $scope.mostrartituloObtenido = $scope.mostrartituloObtenido = false;
        $scope.mostrartituloObtenido = $scope.mostrartituloObtenido = !$scope.mostrartituloObtenido;
    };
    
    $scope.acccertificacionNotasFin = "ninguna";
$scope.mostrarcertificacionNotasFin = false;
$scope.NadacertificacionNotasFin = function (){
        $scope.acccertificacionNotasFin = $scope.acccertificacionNotasFin="ninguna";        
        $scope.mostrarcertificacionNotasFin = $scope.mostrarcertificacionNotasFin = false;
    };
$scope.ActualizarcertificacionNotasFin = function (){
        $scope.acccertificacionNotasFin = $scope.acccertificacionNotasFin="actualizar";
        $scope.mostrarcertificacionNotasFin = $scope.mostrarcertificacionNotasFin = false;
        $scope.mostrarcertificacionNotasFin = $scope.mostrarcertificacionNotasFin = !$scope.mostrarcertificacionNotasFin;
    };
    
    $scope.accactaEvaluacion = "ninguna";
$scope.mostraractaEvaluacion = false;
$scope.NadaactaEvaluacion = function (){
        $scope.accactaEvaluacion = $scope.accactaEvaluacion="ninguna";        
        $scope.mostraractaEvaluacion = $scope.mostraractaEvaluacion = false;
    };
$scope.ActualizaractaEvaluacion = function (){
        $scope.accactaEvaluacion = $scope.accactaEvaluacion="actualizar";
        $scope.mostraractaEvaluacion = $scope.mostraractaEvaluacion = false;
        $scope.mostraractaEvaluacion = $scope.mostraractaEvaluacion = !$scope.mostraractaEvaluacion;
    };
    
    $scope.accconstanciaEgresado = "ninguna";
$scope.mostrarconstanciaEgresado = false;
$scope.NadaconstanciaEgresado = function (){
        $scope.accconstanciaEgresado = $scope.accconstanciaEgresado="ninguna";        
        $scope.mostrarconstanciaEgresado = $scope.mostrarconstanciaEgresado = false;
    };
$scope.ActualizarconstanciaEgresado = function (){
        $scope.accconstanciaEgresado = $scope.accconstanciaEgresado="actualizar";
        $scope.mostrarconstanciaEgresado = $scope.mostrarconstanciaEgresado = false;
        $scope.mostrarconstanciaEgresado = $scope.mostrarconstanciaEgresado = !$scope.mostrarconstanciaEgresado;
    };
    
    $scope.acctomaPosesion = "ninguna";
$scope.mostrartomaPosesion = false;
$scope.NadatomaPosesion = function (){
        $scope.acctomaPosesion = $scope.acctomaPosesion="ninguna";        
        $scope.mostrartomaPosesion = $scope.mostrartomaPosesion = false;
    };
$scope.ActualizartomaPosesion = function (){
        $scope.acctomaPosesion = $scope.acctomaPosesion="actualizar";
        $scope.mostrartomaPosesion = $scope.mostrartomaPosesion = false;
        $scope.mostrartomaPosesion = $scope.mostrartomaPosesion = !$scope.mostrartomaPosesion;
    };
    
    $scope.accproyecto = "ninguna";
$scope.mostrarproyecto = false;
$scope.Nadaproyecto = function (){
        $scope.accproyecto = $scope.accproyecto="ninguna";        
        $scope.mostrarproyecto = $scope.mostrarproyecto = false;
    };
$scope.Actualizarproyecto = function (){
        $scope.accproyecto = $scope.accproyecto="actualizar";
        $scope.mostrarproyecto = $scope.mostrarproyecto = false;
        $scope.mostrarproyecto = $scope.mostrarproyecto = !$scope.mostrarproyecto;
    };
    
    $scope.acccartaRRHH = "ninguna";
$scope.mostrarcartaRRHH = false;
$scope.NadacartaRRHH = function (){
        $scope.acccartaRRHH = $scope.acccartaRRHH="ninguna";        
        $scope.mostrarcartaRRHH = $scope.mostrarcartaRRHH = false;
    };
$scope.ActualizarcartaRRHH = function (){
        $scope.acccartaRRHH = $scope.acccartaRRHH="actualizar";
        $scope.mostrarcartaRRHH = $scope.mostrarcartaRRHH = false;
        $scope.mostrarcartaRRHH = $scope.mostrarcartaRRHH = !$scope.mostrarcartaRRHH;
    };
    
    $scope.accacuerdoGestionContractual = "ninguna";
$scope.mostraracuerdoGestionContractual = false;
$scope.NadaacuerdoGestionContractual = function (){
        $scope.accacuerdoGestionContractual = $scope.accacuerdoGestionContractual="ninguna";        
        $scope.mostraracuerdoGestionContractual = $scope.mostraracuerdoGestionContractual = false;
    };
$scope.ActualizaracuerdoGestionContractual = function (){
        $scope.accacuerdoGestionContractual = $scope.accacuerdoGestionContractual="actualizar";
        $scope.mostraracuerdoGestionContractual = $scope.mostraracuerdoGestionContractual = false;
        $scope.mostraracuerdoGestionContractual = $scope.mostraracuerdoGestionContractual = !$scope.mostraracuerdoGestionContractual;
    };
    
    $scope.accactaReintegro = "ninguna";
$scope.mostraractaReintegro = false;
$scope.NadaactaReintegro = function (){
        $scope.accactaReintegro = $scope.accactaReintegro="ninguna";        
        $scope.mostraractaReintegro = $scope.mostraractaReintegro = false;
    };
$scope.ActualizaractaReintegro = function (){
        $scope.accactaReintegro = $scope.accactaReintegro="actualizar";
        $scope.mostraractaReintegro = $scope.mostraractaReintegro = false;
        $scope.mostraractaReintegro = $scope.mostraractaReintegro = !$scope.mostraractaReintegro;
    };
    
    $scope.accacuerdoGestionLiberacion2 = "ninguna";
$scope.mostraracuerdoGestionLiberacion2 = false;
$scope.NadaacuerdoGestionLiberacion2 = function (){
        $scope.accacuerdoGestionLiberacion2 = $scope.accacuerdoGestionLiberacion2="ninguna";        
        $scope.mostraracuerdoGestionLiberacion2 = $scope.mostraracuerdoGestionLiberacion2 = false;
    };
$scope.ActualizaracuerdoGestionLiberacion2 = function (){
        $scope.accacuerdoGestionLiberacion2 = $scope.accacuerdoGestionLiberacion2="actualizar";
        $scope.mostraracuerdoGestionLiberacion2 = $scope.mostraracuerdoGestionLiberacion2 = false;
        $scope.mostraracuerdoGestionLiberacion2 = $scope.mostraracuerdoGestionLiberacion2 = !$scope.mostraracuerdoGestionLiberacion2;
    };
    
    $scope.accacuerdoLiberacion2 = "ninguna";
$scope.mostraracuerdoLiberacion2 = false;
$scope.NadaacuerdoLiberacion2 = function (){
        $scope.accacuerdoLiberacion2 = $scope.accacuerdoLiberacion2="ninguna";        
        $scope.mostraracuerdoLiberacion2 = $scope.mostraracuerdoLiberacion2 = false;
    };
$scope.ActualizaracuerdoLiberacion2 = function (){
        $scope.accacuerdoLiberacion2 = $scope.accacuerdoLiberacion2="actualizar";
        $scope.mostraracuerdoLiberacion2 = $scope.mostraracuerdoLiberacion2 = false;
        $scope.mostraracuerdoLiberacion2 = $scope.mostraracuerdoLiberacion2 = !$scope.mostraracuerdoLiberacion2;
    };
    
    $scope.accacuerdoGestionLiberacion = "ninguna";
$scope.mostraracuerdoGestionLiberacion = false;
$scope.NadaacuerdoGestionLiberacion = function (){
        $scope.accacuerdoGestionLiberacion = $scope.accacuerdoGestionLiberacion="ninguna";        
        $scope.mostraracuerdoGestionLiberacion = $scope.mostraracuerdoGestionLiberacion = false;
    };
$scope.ActualizaracuerdoGestionLiberacion = function (){
        $scope.accacuerdoGestionLiberacion = $scope.accacuerdoGestionLiberacion="actualizar";
        $scope.mostraracuerdoGestionLiberacion = $scope.mostraracuerdoGestionLiberacion = false;
        $scope.mostraracuerdoGestionLiberacion = $scope.mostraracuerdoGestionLiberacion = !$scope.mostraracuerdoGestionLiberacion;
    };
    
    $scope.accacuerdoLiberacion = "ninguna";
$scope.mostraracuerdoLiberacion = false;
$scope.NadaacuerdoLiberacion = function (){
        $scope.accacuerdoLiberacion = $scope.accacuerdoLiberacion="ninguna";        
        $scope.mostraracuerdoLiberacion = $scope.mostraracuerdoLiberacion = false;
    };
$scope.ActualizaracuerdoLiberacion = function (){
        $scope.accacuerdoLiberacion = $scope.accacuerdoLiberacion="actualizar";
        $scope.mostraracuerdoLiberacion = $scope.mostraracuerdoLiberacion = false;
        $scope.mostraracuerdoLiberacion = $scope.mostraracuerdoLiberacion = !$scope.mostraracuerdoLiberacion;
    };
    }]);

solicitudApp.directive('validFile', function () {
    return {
        require: 'ngModel',
        link: function (scope, el, attrs, ngModel) {

            //change event is fired when file is selected
            el.bind('change', function () {
                scope.$apply(function () {
                    ngModel.$setViewValue(el.val());
                    ngModel.$render();
                });
            });
        }
    };
});
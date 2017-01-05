<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="POJO.Expediente"%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page import="MODEL.variablesDeSesion"%>
<% 
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String rol=(String)actual.getAttribute("rol");
    String user=(String)actual.getAttribute("user");
     if(user==null){
     response.sendRedirect("login.jsp");
        return;
     }
     boolean expedienteAbierto = false;
     try{
        // Comprobando si tiene un proceso de beca abierto
        ExpedienteDAO expDao = new ExpedienteDAO();
        expedienteAbierto = expDao.expedienteAbierto(user);
    } catch (Exception e){
        e.printStackTrace();
    }
     //Si no ha iniciado un proceso de beca lo reenvia a la pagina de las ofertas
     if(expedienteAbierto == false){
     response.sendRedirect("301_inf_publica_ofertas_beca.jsp");
        return;
     }
     //obtener el expediente
     ExpedienteDAO expDao = new ExpedienteDAO();
     Expediente expediente = expDao.obtenerExpedienteAbierto(user);
     //obtener el id_Progreso del expediente
     
     //obtener el estado_Progreso
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Sistema informático para la administración de becas de postgrado</title>

        <meta name="description" content="Source code generated using layoutit.com">
        <meta name="author" content="LayoutIt!">

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/customfieldset.css" rel="stylesheet">
    <div class="row">
        <div class="col-md-4">
            <img alt="Bootstrap Image Preview" src="img/logo.jpg" align="middle"  class="img-responsive center-block">
            <h3 class="text-center text-danger" >
                Universidad De El Salvador
            </h3>
        </div>
        <div class="col-md-8">
            <div class="col-xs-12" style="height:50px;"></div>
            <h2 class="text-center text-danger" style="text-shadow:3px 3px 3px #666;">
                Consejo de Becas y de Investigaciones Científicas <br> Universidad de El Salvador
            </h2>
            <h3 class="text-center text-danger" style="text-shadow:3px 3px 3px #666;">
                Sistema informático para la administración de becas de postgrado
            </h3>
        </div>
    </div>

    <p class="text-right" style="font-weight:bold;">Rol: <%= rol %></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user %></p>


    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>
</head>
<body ng-app = "solicitudApp" ng-controller="SolicitarDictamenCtrl">

    <div class="container-fluid">        
            <H3 class="text-center" style="color:#E42217;">Solicitud de Dictamen de Propuesta</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Solicitud de dictamen de propuesta</legend>
        <div class="row">
            <div class="col-md-12">                
                <fieldset class="custom-border">
                    <legend class="custom-border">Adjuntar documentación necesaria</legend>
                    <%if(expediente.getIdProgreso() == 3){%>
                        <% if(expediente.getEstadoProgreso().equals("EN PROCESO")){%>
                            <div class="text-center">
                                <h3 class="text-danger"> Ya ha realizado una Solicitud de Dictamen de Propuesta ante Junta Directiva</h3>
                                <a href="303_candidato_estado_solicitudes.jsp" class="btn btn-primary">Ver Estado de Solicitud</a>
                            </div>
                        <%}else{%>
                            <form name="solicitudDictamen" action="SolicitarDictamenServlet" method="post" enctype="multipart/form-data">
                                <div class="row"> 
                                    <div class="col-md-2"></div>
                                    <div class="col-md-3">
                                        <label> Carta de Solicitud de Autorizacion inicial:</label>
                                    </div>
                                    <div class="col-md-5">
                                        <input type="file" class="" name="cartaSolicitud" accept="application/pdf" ng-model="cartaSolicitud" valid-file required>
                        <span class="text-danger" ng-show="solicitudDictamen.cartaSolicitud.$invalid">Debe ingresar un documento en formato PDF.</span>
                                    </div>
                                    <div class="col-md-2"></div>                    
                                </div>
                    
                                <div class="row">
                                    <div class="row text-right">
                                        <div class="col-md-10">
                                            <a ng-click="agregar()" ng-show="verAgregar">Agregar Otro Documento</a><br>
                                        </div>
                                        <div class="col-md-2"></div>                    
                                    </div>
                                    
                                    <div class="row text-left" ng-repeat="x in anexos">
                                        <div class="col-md-1"></div>  
                                        <div class="col-md-2">
                                            <label>Tipo de Documento: </label><br>
                                        </div>
                                        <div class="col-md-4">
                                            <select  name="{{x.tipo}}" class="form-control" ng-required="true">
                                                <option ng-repeat="option in tipos" value="{{option.id}}">{{option.tipoDocumento}}</option>
                                            </select>
                                            <span class="text-danger" ng-show="!solicitudDictamen.$pristine && solicitudDictamen.{{x.tipo}}.$error.required">Debe de Seleccionar un Tipo de Documento.</span><br>
                                        </div>
                                        <div class="col-md-3">
                                            <input type="file" name="{{x.nombre}}" accept="application/pdf" ng-model="docAnexo" valid-file required><br>
                                            <span class="text-danger" ng-show="solicitudDictamen.{{x.nombre}}.$invalid">Debe ingresar un documento en formato PDF.</span><br>
                                        </div>
                                        <div class="col-md-1">
                                            <a class="btn btn-danger" ng-click="eliminar(item)">Eliminar</a><br>
                                        </div>
                                        <div class="col-md-1"></div>  
                                    </div>   
                                </div>
                                
                                <div class="row text-center">
                                    <br>
                                    <input type="hidden" name="idExpediente" value="<%=expediente.getIdExpediente()%>">
                                    <input type="hidden" name="user" value="<%=user%>">
                                    <input type="hidden" name="nAnexos" value="{{Nanexos-1}}">
                                    <input type="submit" name="guardar" value="Enviar" class="btn btn-success" ng-disabled="!solicitudDictamen.$valid">
                                </div> 
                            </form>
                        <%}%>
                    <%}else{%>
                        <div class="text-center">
                            <h3 class="text-danger">No corresponde solicitar este documento </h3>
                            <a href="305_candidato_estado_proceso.jsp" class="btn btn-primary">Ver Estado del Proceso de Beca</a>
                        </div>
                    <%}%>
                </fieldset>
            </div> 
        </div></fieldset>

        <div class="row" style="background:url(img/pie.jpg) no-repeat center top scroll;background-size: 99% auto;">
            <div class="col-md-6">
                <h3>
                    Dirección
                </h3>
                <p>
                    2016 Universidad De El Salvador  <br/>
                    Ciudad Universitaria, Final de Av.Mártires y Héroes del 30 julio, San Salvador, El Salvador, América Central. 
                </p>
            </div>
            <div class="col-md-6">
                <h3>
                    Información de contacto
                </h3>
                <p>
                    Universidad De El Salvador
                    Tél: +(503) 2511-2000 <br/>
                    Consejo de becas
                    Tél: +(503) 2511- 2016
                </p>
            </div>
        </div>    
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/angular.min.js"></script>
    <script src="js/solicitarDictamen.js"></script>
</body>
</html>

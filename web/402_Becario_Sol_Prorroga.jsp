<%-- 
    Document   : 402_Becario_Sol_Prorroga
    Created on : 11-16-2016, 04:25:46 PM
    Author     : aquel
--%>
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String rol = (String) actual.getAttribute("rol");
    String user = (String) actual.getAttribute("user");
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    Integer tipo_usuario_logeado = (Integer) actual.getAttribute("id_tipo_usuario");
    ArrayList<String> tipo_usuarios_permitidos = new ArrayList<String>();
    //AGREGAR SOLO LOS ID DE LOS USUARIOS AUTORIZADOS PARA ESTA PANTALLA------
    tipo_usuarios_permitidos.add("2");
    tipo_usuarios_permitidos.add("7");
    tipo_usuarios_permitidos.add("8");
    tipo_usuarios_permitidos.add("9");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user==null) {
        response.sendRedirect("logout.jsp");        
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Sistema informático para la administración de becas de postgrado</title>

        <meta name="description" content="Source code generated using layoutit.com">
        <meta name="author" content="LayoutIt!">

        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/menuSolicitudBeca.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker3.min.css" />
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

    <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>
    </head>
<body ng-app = "solicitudApp" ng-controller="SolicitarAutorizacionCtrl">

    <div class="container-fluid">        
        <H3 class="text-center" style="color:#E42217;">Solicitar Prórroga</H3>
        <fieldset class="custom-border">
            <legend class="custom-border">Solcitar Prórroga</legend>
            <div class="row">
                <div class="col-md-12">                
                    <fieldset class="custom-border">
                        <legend class="custom-border">Adjuntar documentación necesaria</legend>
                        <form name="solitarProrroga" class="form-horizontal" action="SolicitarProrroga" method="post" enctype="multipart/form-data">
                            <div class="row">   
                                <div class="col-md-12">
                                    <div class="col-md-5">
                                        <label>Carta de Solicitud de Prórroga para el Consejo de Becas: </label>
                                        <input type="hidden" id="consejo" name="consejo" value="Consejo de Becas" disabled>
                                    </div> 
                                    <div class="col-md-7">
                                        <div class="form-group">
                                            <div class="col-md-6">      
                                                    <input type="file" name="doc_digital1" accept="application/pdf" ng-model="doc_digital1" valid-file required>
                                                    <span class="text-danger" ng-show="solitarProrroga.doc_digital1.$invalid">Debe ingresar un documento en formato PDF.</span>   
                                            </div> 
                                        </div>
                                    </div> 
                                </div>    
                            </div>  

                            <div class="row">   
                                <div class="col-md-12">
                                    <div class="col-md-5">
                                        <label>Carta de Solicitud de Prórroga para Junta Directiva:</label>
                                        <input type="hidden" id="junta" name="junta" value="Junta Directiva" disabled> 
                                    </div> 
                                    <div class="col-md-7">
                                        <div class="form-group">
                                            <div class="col-md-6">      
                                                    <input type="file" name="doc_digital2" accept="application/pdf" ng-model="doc_digital2" valid-file required>
                                                    <span class="text-danger" ng-show="solitarProrroga.doc_digital2.$invalid">Debe ingresar un documento en formato PDF.</span>   
                                            </div> 
                                        </div>
                                    </div>  
                                </div>    
                            </div>  

                            <div class="row">   
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <label>Constancia de la Institución:</label>
                                    </div>  
                                    <div class="col-md-7 col-md-offset-2">
                                        <div class="form-group">
                                            <div class="col-md-6">    
                                                    <input type="file" name="doc_digital3" accept="application/pdf" ng-model="doc_digital3" valid-file required>
                                                    <span class="text-danger" ng-show="solitarProrroga.doc_digital3.$invalid">Debe ingresar un documento en formato PDF.</span>
                                            </div> 
                                        </div>
                                    </div> 
                                </div>    
                            </div>  

                            </br></br>
                            <div class="row">   
                                <div class="col-md-2 col-md-offset-5">
                                    <input type='hidden' name='user' value='<%=user%>'>
                                    <input type='submit' class='btn btn-success' name='submit' value='Enviar Solicitud' ng-disabled="!solitarProrroga.$valid">
                                </div>    
                            </div> </br>
                        </form></fieldset>
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
    <script src="js/solicitarAutorizacionInicial.js"></script>
</body>
</html>
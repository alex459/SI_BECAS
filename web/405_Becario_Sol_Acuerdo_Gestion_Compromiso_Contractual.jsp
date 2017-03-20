<%-- 
    Document   : 405_Becario_Sol_Acuerdo_Gestion_Compromiso_Contractual
    Created on : 11-16-2016, 06:22:47 PM
    Author     : aquel
--%>
<%@page import="MODEL.variablesDeSesion"%>
<% 
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String user=(String)actual.getAttribute("user");
     if(user==null){
     response.sendRedirect("login.jsp");
        return;
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
     <link href="css/customfieldset.css" rel="stylesheet">
     
<jsp:include page="cabecera.jsp"></jsp:include>
<p class="text-right">Rol: </p>
<p class="text-right">Usuario: </p>
<jsp:include page="menuBecario.jsp"></jsp:include>
</head>
<body>

    <div class="container-fluid">        
            <H3 class="text-center" style="color:#E42217;">Solocitar Acuerdo de Gestión de Compromiso Contractual</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Solocitar Acuerdo de Gestión de Compromiso Contractual</legend>
        <div class="row">
            <div class="col-md-12">                
                <fieldset class="custom-border">
                <legend class="custom-border">Adjuntar documentación necesaria</legend>
                    <form class="form-horizontal">
                        
                    <div class="row">   
                                <div class="col-md-12">
                                    <div class="col-md-4 col-md-offset-1">
                                        <div class="form-group">
                                            <label>Carta de solicitud:</label>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" id="labelDurac" placeholder="Ruta del archivo" disable>    

                                    </div> 
                                    <div class="col-md-3">
                                        <button id="button1id" name="examinar" class="btn btn-success">Examinar</button>
                                        <button id="button2id" name="eliminar" class="btn btn-danger">Eliminar</button>
                                    </div>  
                                </div>    
                            </div>
                        </br>
                       
                        
                        
                        <div class="row">   
                                <div class="col-md-12">
                                    <div class="col-md-4 col-md-offset-1">
                                        <div class="form-group">
                                            <select id="facultad" name="tipoDoc" class="form-control">
                                                <option value="1">Carta de RRHH</option>
                                                
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <input type="text" class="form-control" id="labelDurac" placeholder="Ruta del archivo" disable>    

                                    </div> 
                                    <div class="col-md-3">
                                        <button id="button1id" name="examinar" class="btn btn-success">Examinar</button>
                                        <button id="button2id" name="eliminar" class="btn btn-danger">Eliminar</button>
                                    </div>  
                                </div>    
                            </div>  
                        
                       
                           

                            </br></br>
                            <div class="row">   
                                <div class="col-md-2 col-md-offset-5">
                                        <button id="button1id" name="enviar" class="btn btn-success">Enviar solicitud</button>
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
    <script src="js/scripts.js"></script>
</body>
</html>

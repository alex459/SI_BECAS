<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page import="DAO.DetalleUsuarioDAO"%>
<%@page import="MODEL.variablesDeSesion"%>
<% 
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String user=(String)actual.getAttribute("user");
    Integer idFacultad = 0;
    boolean expedienteAbierto = false;
    try{
        DetalleUsuarioDAO DetUsDao = new DetalleUsuarioDAO();
        idFacultad = DetUsDao.obtenerFacultad(user);
        ExpedienteDAO expDao = new ExpedienteDAO();
        expedienteAbierto = expDao.expedienteAbierto(user);
    } catch (Exception e){
        e.printStackTrace();
    }
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
<div class="row">
    <div class="col-md-4">
        <img alt="Bootstrap Image Preview" src="img/logo.jpg" align="middle"  class="img-responsive center-block">
        <h3 class="text-center text-danger" >
            Universidad De El Salvador
        </h3>
    </div>
    <div class="col-md-8">
        <div class="col-xs-12" style="height:50px;"></div>
        <h2 class="text-center">
            <p class="text-danger" style="text-shadow:3px 3px 3px #666;">Consejo de Becas y de Investigaciones Científicas <br> Universidad de El Salvador</p>
        </h2>
        <h3 class="text-center">
            <p class="text-danger" style="text-shadow:3px 3px 3px #666;">Sistema informático para la administración de becas de postgrado</p>
        </h3>
    </div>
</div>
<p class="text-right">Rol: </p>
<p class="text-right">Usuario: </p>
<jsp:include page="menuCandidato.jsp"></jsp:include>
</head>
<body>

    <div class="container-fluid">        
                <H3 class="text-center" style="color:#E42217;">Solicitud de permiso inicial</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Solicitud de permiso inicial</legend>
        <div class="row">
            <div class="col-md-12">
                
            <%if (expedienteAbierto == true){%>
            <div class="text-center">
                    <h3 class="text-danger">Ya ha iniciado un Proceso de Solicitud de Beca </h3>
                    <a href="303_candidato_estado_solicitudes.jsp" class="btn btn-primary">Ver Estado de Solicitud</a>
                </div>
                
            <%}else{%>
            <fieldset class="custom-border">
                <legend class="custom-border">Adjuntar documentación necesaria</legend>
                <form name="solicitudPermisoInicial" action="PermisoInicial" method="post" enctype="multipart/form-data">
                <div class="row"> 
                    <div class="col-md-2"></div>
                    <div class="col-md-3">
                        <label> Carta de Solicitud de permiso inicial:</label>
                    </div>
                    <div class="col-md-5">
                        <input type="file" class="" name="cartaSolicitud" accept="application/pdf">
                    </div>
                    <div class="col-md-2"></div>
                                    
                </div>
                    <div class="row text-center">
                        <br>
                        <input type="hidden" name="user" value="<%=user%>">
                        <input type="submit" name="guardar" value="Enviar" class="btn btn-success">
                    </div> 
                </form>
            </fieldset>          
            <%}%>
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

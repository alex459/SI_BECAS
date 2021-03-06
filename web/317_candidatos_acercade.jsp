<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String user = (String) actual.getAttribute("user");
    if (user == null) {
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
<div class="row">
    <div class="col-md-4">
        <img alt="Bootstrap Image Preview" src="img/logo.jpg" align="middle"  class="img-responsive center-block">
        <h3 class="text-center" >
            <p class="text-danger">Universidad De El Salvador</p>
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
        <div class="row">
            <div class="col-md-12">

                <div class="col-xs-12" style="height:50px;"></div>
                <div class="jumbotron">
                    <div class="row">
                        <div class="col-md-4">				
                            <img alt="Bootstrap Image Preview" src="img/minerva2.png" align="middle"  class="img-responsive center-block" style="width:300px;height:500px">
                        </div>				  
                        <div class="col-md-8">
                            <h2>Consejo de becas e investicaciones cientificas</h2>                            
                            <p>
                                El Consejo de Becas ofrece becas de posgrado a docentes, profesionales no docentes que 
                                laboran en la universidad y a estudiantes graduados. Además, mantiene informada a la comunidad
                                universitaria sobre las ofertas de becas que organismos internacionales o universidades extranjeras
                                remiten a la Universidad de El Salvador. 	
                            </p>
                            <h3>Misión:</h3>  
                            <p>
                                Promover y prever la formación, capacitación y especialización a nivel superior de postgrado al personal
                                académico y administrativo, por medio de la información concerniente a las necesidades de postgrados 
                                existentes en las facultades, además de la gestión de becas nacionales e internacionales, logrando de
                                esta manera contar con profesionales académicos y administrativos de alta calidad en función de la excelencia
                                académica de los estudiantes de la Universidad de El Salvador.	
                            </p>
                            <h3>Visión:</h3>
                            <p>
                                Ser un ente con un alto nivel de calidad académica con credibilidad y confianza nacional e internacional.	
                            </p>
                        </div>	
                    </div>
                </div>
            </div>
        </div>

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

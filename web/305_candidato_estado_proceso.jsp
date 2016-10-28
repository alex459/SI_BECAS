<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>

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
<nav class="navbar navbar-custom" role="navigation">
    <div class="navbar-header">

        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
        </button> <a class="navbar-brand active" href="index.html">Inicio</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Información pública<strong class="caret"></strong></a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="315_candidato_ofertas_beca.jsp">Ofertas de beca</a>
                        <a href="316_candidatos_documentos.jsp">Documentos</a>
                        <a href="317_candidatos_acercade.jsp">Acerca de</a>
                        <a href="#">Login/Logout</a>
                    </li>								
                </ul>
            </li>
        </ul>
        <ul class="nav navbar-nav">
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Candidatos<strong class="caret"></strong></a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="315_candidato_ofertas_beca.jsp">Ofertas de becas</a>
                        <a href="303_candidato_estado_solicitudes.jsp">Estado de solicitudes</a>
                        <a href="305_candidato_estado_proceso.jsp">Estado de proceso de beca</a>
                        <a href="304_candidato_sol_permiso_inicial.jsp">Solicitud de permiso inicial</a>
                        <a href="306_candidato_sol_autorizacion_inicial.jsp">Solicitud de autorización inicial</a>
                        <a href="307_candidato_sol_dictamen_propuesta.jsp">Solicitud de dictamen de propuesta</a>
                        <a href="308_candidato_sol_beca1.jsp">Solicitud de beca</a>
                    </li>								
                </ul>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">						
            <li>
                <a href="#">Ayuda</a>
            </li>
            <li>
                <a href="#">Contacto</a>
            </li>
            <li>
                <a href="#">Acerca de</a>
            </li>
            <li>
                <a href="login.jsp">Iniciar Sesión</a>
            </li>
        </ul>
    </div>

</nav>
</head>
<body>

    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Estado del proceso de beca</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Becas</legend>
        <div class="row">            
            <div class="col-md-5">
                <div class = "panel panel-default">
                   <table class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <th>Proceso</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Sin iniciar</td>
                            <td style="background-color:#E5E4E2;">Poner estado aqui</td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Permiso inicial de junta directova</td>
                            <td style="background-color:#E5E4E2;">Poner estado aqui</td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Autorización inicial del consejo de becas</td>
                            <td style="background-color:#E5E4E2;">Poner estado aqui</td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Dictamen de la comisión de beca</td>
                            <td style="background-color:#E5E4E2;">Poner estado aqui</td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Acuerdos de permisos de beca de junta directiva</td>
                            <td style="background-color:#E5E4E2;">Poner estado aqui</td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Solicitud de beca</td>
                            <td style="background-color:#E5E4E2;">Poner estado aqui</td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Resolución del expediente de beca</td>
                            <td style="background-color:#E5E4E2;">Poner estado aqui</td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Acuerdos de beca del consejo superior universitario</td>
                            <td style="background-color:#E5E4E2;">Poner estado aqui</td>
                        </tr>
                    </tbody>
                </table> 
                </div>
            </div>  
            <div class="col-md-2">
                <div class = "panel panel-default">
                     <table class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>icono aqui</td>
                        </tr>
                        <tr>
                            <td>icono aqui </td>
                        </tr>
                        <tr>
                            <td>icono aqui </td>
                        </tr>
                        <tr>
                            <td>icono aqui </td>
                        </tr>
                        <tr>
                            <td>icono aqui </td>
                        </tr>
                        <tr>
                            <td>icono aqui </td>
                        </tr>
                        <tr>
                            <td>icono aqui </td>
                        </tr>
                        <tr>
                            <td>icono aqui </td>
                        </tr>
                    </tbody>
                </table>
                </div>
            </div> 
            <div class="col-md-5">
                <h3>Detalle</h3>
                <div class = "panel panel-default">
                    </br><div class="row">
                        <div class="col-md-12 col-md-offset-1">
                        colocar aqui descripcion del proceso 
                        </div>
                    </div></br>
                    <div class="row">
                        <div class="col-md-12 col-md-offset-4">
                        <button id="solicitar" name="solicitar" class="btn btn-success">Solicitar ahora</button>
                        </div>
                    </div></br>
                    <div class="row">
                        <div class="col-md-12 col-md-offset-4">
                         <button id="cancelar" name="cancelar" class="btn btn-danger">Cancelar proceso</button>
                        </div>
                    </div></br>
                </div>
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

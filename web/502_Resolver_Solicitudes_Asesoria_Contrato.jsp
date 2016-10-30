<%-- 
    Document   : 502_Resolver_Solicitudes_Asesoria_Contrato
    Created on : 26/10/2016, 11:19:15 AM
    Author     : adminPC
--%>

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
    <link href="css/menuSolicitudBeca.css" rel="stylesheet">    
    <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker3.min.css" />
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
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Solicitudes y Acuerdos<strong class="caret"></strong></a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="501_Solicitudes_Asesoria_Contrato.jsp">Solicitudes de Asesoria de Contrato de Beca</a>
                        <a href="502_Resolver_Solicitudes_Asesoria_Contrato.jsp">Resolver Solicitudes de Asesoria de Contrato de Beca</a>
                        <a href="503_Solicitudes_Reintegro_Beca.jsp">Solicitudes de Reintegracion de Beca</a>
                        <a href="504_Resolver_Solicitudes_Reintegro_Beca.jsp">Resolver Solicitudes de Reintegracion de Beca</a>
                        <a href="505_Buscar_Contrato.jsp">Buscar Contrato Beca</a>
                        <a href="506_Buscar_Acta_Reintegro.jsp">Buscar Acta de Reintegro de Beca</a>

                    </li>                               
                </ul>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">                        
            <li>
                <a href="#">Ayuda</a>
            </li>
            <li>
                <a href="login.jsp">Cerrar Sesión</a>
            </li>
        </ul>
    </div>

</nav>
</head>



<body>

    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Resolver Solicitud de Asesoria de Contrato de Beca</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Solicitud</legend>
                    <div class="row">            
                        <div class="col-md-2"></div> 
                        <div class="col-md-8">
                            <table class="table">
                                <tr>
                                    <td>Solicitante:</td><td>Nombre del solicitante</td><td></td><td></td><td></td><td></td><td>Codigo de Empleado:</td><td>########</td>
                                </tr>
                                <tr>
                                    <td>Unidad:</td><td>Nombre de la Unidad</td><td></td><td></td><td></td><td></td><td>Expediente:</td><td>######</td>
                                </tr> 
                                <tr>
                                    <td>Documento Solicitado:</td><td>Nombre del Documento</td><td></td><td></td><td></td><td></td><td>Fecha de Solicitud:</td><td>fecha</td>
                                </tr> 
                            </table>
                        </div>
                        <div class="col-md-2"></div> 
                    </div>

                    <div class="row">
                        <div class="col-md-2"></div>
                        <div class="col-md-8">
                            <fieldset class="custom-border">
                                <legend class="custom-border"> Documentos Adjuntados</legend>
                                <div class="col-md-2"></div>
                                <div class="col-md-8">
                                    <table class="table">
                                        <thead>
                                            <th>No.</th>
                                            <th>Documento</th>
                                            <th>Accion</th>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td> #</td>
                                                <td> Nombre Documento</td>
                                                <td> <input type="button" name="ver" value="Ver Documento" class="btn btn-success"></td>
                                            </tr>
                                            <tr>
                                                <td> #</td>
                                                <td> Nombre Documento</td>
                                                <td> <input type="button" name="ver" value="Ver Documento" class="btn btn-success"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-md-2"></div>
                            </fieldset>
                        </div>
                        <div class="col-md-2"></div>
                    </div>

                    <div class="row">
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <fieldset class="custom-border">
                                <legend class="custom-border"> Resolucion</legend>
                                <form class="">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <label >Contrato:</label><br>
                                        </div>
                                        <div class="col-md-6">
                                            <input type="text" name="ruta" class="form-control"><br>
                                        </div>
                                        <div class="col-md-3">
                                            <button class="btn btn-primary">Examinar</button><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <label>Observaciones:</label><br>
                                        </div>
                                        <div class="col-md-9">
                                            <textarea class="form-control"></textarea><br>
                                        </div>
                                    </div>
                                    <div class="row text-center">
                                        <div class="col-md-3"></div>
                                        <div class="col-md-3 ">
                                            <input type="button" name="aprobar" value="Aprobar" class="btn btn-success">
                                        </div>
                                        <div class="col-md-3 ">
                                            <input type="button" name="denegar" value="Denegar" class="btn btn-danger">
                                        </div>
                                        <div class="col-md-3"></div>
                                    </div>
                                </form>
                            </fieldset>
                        </div>
                        <div class="col-md-3"></div>
                    </div>
        </fieldset>
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
<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>

</body>
</html>
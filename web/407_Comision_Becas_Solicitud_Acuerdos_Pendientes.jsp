<%-- 
    Document   : 407_Comision_Becas_Solicitud_Acuerdos_Pendientes
    Created on : 11-08-2016, 09:49:28 PM
    Author     : alex
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
                        <a href="407_Comision_Becas_Solicitud_Acuerdos_Pendientes.jsp">Solicitudes de Acuerdos Pendientes</a>
                        <a href="408_Comision_Becas_Resolver_Solicitud.jsp">Resolver Solicitud de Acuerdo Pendiente</a>
                        <a href="409_Comision_Becas_Buscar_Acuerdo.jsp">Buscar Acuerdo</a>
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
        <H3 class="text-center" style="color:#E42217;">Solicitudes de Acuerdos Pendientes</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Solicitudes de Acuerdos Pendientes</legend>
                    <div class="row">            
                        <div class="col-md-2"></div> 
                        <div class="col-md-8"> 
                            <fieldset class="custom-border">
                                <legend class="custom-border">Filtros</legend>
                                <form>
                                    <div class="row"> 
                                        <div class="col-md-6">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-10">
                                                <label>Solicitante:</label><input type="text" class="form-control" name="solicitante"><br>
                                                <label>Codigo Empleado:</label><input type="text" class="form-control" name="codigo_empleado"><br>
                                            </div>
                                            <div class="col-md-1"></div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="col-md-1"></div>
                                            <div class="col-md-10">                                                
                                                <label>Fecha Solicitud:</label><input type="text" class="form-control" name="fecha_solicitud"><br>
                                                
                                            </div>
                                            <div class="col-md-1"></div>
                                        </div>
                                    </div>
                                    <div class="row text-center"> 
                                    <input type="button" name="buscar" value="Buscar" class="btn btn-primary">
                                    </div>
                                </form>
                                    
                            </fieldset>              
                        </div>
                        <div class="col-md-2"></div> 
                    </div>
                    <div class="row">
                        <h5>Resultados</h5>
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <table class="table text-center">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Solicitante</th>
                                        <th>Unidad</th>
                                        <th>Fecha Solicitud</th>
                                        <th>Documento Solicitado</th>
                                        <th>Acción</th>
                                    </tr>  
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td><input type="button" name="resolver" value="Resolver" class="btn btn-success"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td><input type="button" name="resolver" value="Resolver" class="btn btn-success"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-1"></div>
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

<%-- 
    Document   : 511_Reporte_Institucion_Financiera
    Created on : 30/10/2016, 03:54:19 PM
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
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Consejo de Becas<strong class="caret"></strong></a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="507_Consejo_Becas_Solicitudes_Pendientes.jsp">Solicitudes de Acuerdos Pendientes</a>
                        <a href="508_Consejo_Becas_Resolver_Solicitud.jsp">Resolver Solicitud de Acuerdo Pendiente</a>
                        <a href="509_Consejo_Becas_Buscar_Acuerdo.jsp">Buscar Acuerdo</a>
                        <a href="510_Reportes.jsp">Reportes</a>
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
        <H3 class="text-center" style="color:#E42217;">Reporte de Becarios por Institucion Financiera</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Reporte de Becarios por Institucion Financiera</legend>
                    
                    <div class="row">            
                        <div class="col-md-9">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Filtros</legend>
                                <h5 style="color:#E42217">Ingrese los Fitros de Busqueda del Reporte</h5>
                                <form>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Tipo de Beca:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select class="form-control">
                                                    <option>Seleccione Tipo de Beca</option>
                                                    <option>Externa</option>
                                                    <option>Interna</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label >
                                                <label class="text-center">Rango para fecha de Inicio de Beca</label><br>
                                            <div class="col-md-2">
                                                <label>Inicio:</label>
                                            </div>
                                            <div class="col-md-4">
                                                <input type="date" name="fecha_inicio" class="form-control">
                                            </div>
                                            <div class="col-md-2">
                                                <label>Fin:</label>
                                            </div>
                                            <div class="col-md-4">
                                                <input type="date" name="fecha_fin" class="form-control">
                                            </div>
                                            </label>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Facultad:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select class="form-control">
                                                    <option>Seleccione Facultad</option>
                                                    <option>Facultad 1</option>
                                                    <option>Facultad 2</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="text-center">Rango para fecha de Finalizacion de Beca</label><br>
                                            <div class="col-md-2">
                                                <label>Inicio:</label><br>
                                            </div>
                                            <div class="col-md-4">
                                                <input type="date" name="fecha_inicio" class="form-control">
                                            </div>
                                            <div class="col-md-2">
                                                <label>Fin:</label><br>
                                            </div>
                                            <div class="col-md-4">
                                                <input type="date" name="fecha_fin" class="form-control">
                                            </div>

                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Tipo de Becario:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select class="form-control">
                                                    <option>Seleccione Tipo de Becario</option>
                                                    <option>Activo</option>
                                                    <option>Contractual</option>
                                                    <option>Inactivo</option>
                                                    <option>Liberado</option>
                                                    <option>Incumplimiento de Contrato</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Institucion Financiera:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select class="form-control">
                                                    <option>Seleccione Institucion</option>
                                                    <option>Institucion 1</option>
                                                    <option>Institucion 2</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Tipo de Estudio Realizado:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select class="form-control">
                                                    <option>Seleccione Tipo de Estudio</option>
                                                    <option>Maestria</option>
                                                    <option>Doctorado</option>
                                                    <option>Especializacion</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-center">
                                            <br>
                                            <input type="button" name="filtrar" value="Realizar Busqueda" class="btn btn-primary">
                                        </div>
                                    </div>

                                </form>
                            </fieldset>
                        </div>

                        <div class="col-md-3 text-center">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Acciones</legend>
                                <div class="col-md-6">
                                    <br>
                                    <label class="">PDF</label>
                                    <button type="submit" class="btn btn-success form-control">
                                       <span class="glyphicon glyphicon-file"></span> 
                                       PDF
                                    </button><br><br>
                                    <label>Enviar Por Correo</label>
                                    <button type="submit" class="btn btn-success form-control">
                                       <span class="glyphicon glyphicon-file"></span> 
                                       E-mail
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <label>Hoja de Cálculo</label>
                                    <button type="submit" class="btn btn-success form-control">
                                       <span class="glyphicon glyphicon-file"></span> 
                                       Excel
                                    </button><br><br>
                                    <br>
                                    <label>Imprimir</label>
                                    <button type="submit" class="btn btn-success form-control">
                                       <span class="glyphicon glyphicon-print"></span> 
                                       Imprimir
                                    </button>
                                    
                                </div>                                                                
                            </fieldset>
                        </div>
                    </div>


                    <div class="row">
                        <h5>Resultados de la busqueda</h5>
                        <div class="col-md-12">
                            <table class="table text-center">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Nombre</th>
                                        <th>Tipo de Beca</th>
                                        <th>Fecha de Inicio de Beca</th>
                                        <th>Fecha de Finalizacion de Beca</th>
                                        <th>Pais</th>
                                        <th>Estudio Realizado</th>
                                        <th>Institucion que Financia</th>
                                        <th>Facultad</th>
                                        <th>Observaciones</th>
                                    </tr>  
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>###</td>
                                        <td>Nombre Becario</td>
                                        <td>Tipo Beca</td>
                                        <td>##/##/####</td>
                                        <td>##/##/####</td>
                                        <td>Pais</td>
                                        <td>Titulo de Estudio Postgrado</td>
                                        <td>Nombre de la Institucion Financiera</td>
                                        <td>Nombre de la Facultad</td>
                                        <td>Observaciones</td>
                                    </tr>
                                    <tr>
                                        <td>###</td>
                                        <td>Nombre Becario</td>
                                        <td>Tipo Beca</td>
                                        <td>##/##/####</td>
                                        <td>##/##/####</td>
                                        <td>Pais</td>
                                        <td>Titulo de Estudio Postgrado</td>
                                        <td>Nombre de la Institucion Financiera</td>
                                        <td>Nombre de la Facultad</td>
                                        <td>Observaciones</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
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

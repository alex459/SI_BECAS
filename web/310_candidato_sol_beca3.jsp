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
        <H3 class="text-center" style="color:#E42217;">Solicitud de beca</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Solicitud de beca de postgrado</legend>
        <div class="row">            
            <div class="col-md-2">
                <ul id="sidebar" class="nav nav-pills nav-stacked" style="max-width: 200px;">
                    <li><a href="308_candidato_sol_beca1.jsp">Datos personales</a></li>
                    <li><a href="309_candidato_sol_beca2.jsp">Información laboral</a></li>
                    <li class="active"><a href="310_candidato_sol_beca3.jsp">Educación</a></li>
                    <li><a href="311_candidato_sol_beca4.jsp">Cargos desempeñados</a></li>
                    <li><a href="312_candidato_sol_beca5.jsp">Información de beca</a></li>
                    <li><a href="313_candidato_sol_beca6.jsp">Referencias personales</a></li>
                    <li><a href="314_candidato_sol_beca7.jsp">Adjuntar documentos</a></li>
                </ul>
            </div>  
            <div class="col-md-10">
                    <fieldset class="custom-border">
                <legend class="custom-border">Educación</legend>
                    <form class="form-horizontal">                        
                            <div class="row">   
                                <div class="col-md-2">
                                    <label for="textinput">Tipo de educación</label>
                                    <select id="selectbasic" name="selectbasic" class="form-control">
                                        <option value="1">Option one</option>
                                        <option value="2">Option two</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label for="textinput">Grado alcanzado</label>
                                    <select id="selectbasic" name="selectbasic" class="form-control">
                                        <option value="1">Option one</option>
                                        <option value="2">Option two</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label for="textinput">Nombre de la institución</label>
                                    <input id="textinput" name="textinput" type="text" placeholder="Ingrese el nombre de la institución" class="form-control input-md">
                                </div>
                                <div class="col-md-6">
                                    <label for="textinput">Año</label>
                                    <div class="row">
                                    <div class="col-md-6">    
                                    <div class="input-group date">
                                        <input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    </div>
                                    </div>
                                    <div class="col-md-6">
                                    <div class="form-group">
                                            <div class="row"></div>
                                            <button id="button1id" name="agEducacion" class="btn btn-primary">Agregar información</button>
                                    </div>                                   
                                </div>    
                                    </div>    
                                </div>
                                
                            </div>
                            <div class="row">  
                                <div class="col-md-12">
                                    <table class="table table-bordered"></br>
                                        <label for="textinput">información de educación ingresada</label>
                                        <thead>
                                            <tr class="success">
                                                <th>No</th>
                                                <th>Tipo de educación</th>
                                                <th>Grado alcanzado</th>
                                                <th>Institución</th>
                                                <th>Año</th>
                                                <th>Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="info">
                                                <td> </td>
                                                <td> </td>
                                                <td> </td>
                                                <td> </td>
                                                <td></td>
                                                <td><button id="Editar" name="Editar" class="btn btn-success">Editar</button><button id="eliminar" name="eliminar" class="btn btn-danger">Eliminar</button></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div> 
                            </div></br>
                            <div class="row">
                                <div class="row">
                                    <div class="col-md-12 col-md-offset-2">
                                        <label>Trabajo de investigación o tesis realizada </label>
                                    </div>
                                </div>
                                <div class="col-md-12 col-md-offset-2">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <input id="searchinput" name="busqueda" type="input" placeholder="Ruta del archivo" class="form-control input-md" disable>
                                            <p class="help-block"></p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">    
                                        <div class="form-group">
                                            <div class="col-md-4">
                                                <button id="singlebutton" name="cargarArchivo" type="file" class="btn btn-primary">Agregar proyecto</button>
                                            </div>
                                        </div>
                                    </div> 
                                </div>
                            </div></br>
                            <div class="row">
                                <div class="col-md-2">
                                    <label for="textinput">Idioma</label>
                                    <select id="selectbasic" name="selectbasic" class="form-control">
                                        <option value="1">Option one</option>
                                        <option value="2">Option two</option>
                                    </select>             
                                </div>
                                <div class="col-md-2">
                                    <label for="textinput">Nivel de habla</label>
                                    <select id="selectbasic" name="selectbasic" class="form-control">
                                        <option value="1">Option one</option>
                                        <option value="2">Option two</option>
                                    </select>           
                                </div>
                                <div class="col-md-2">
                                    <label for="textinput">Nivel de lectura</label>
                                    <select id="selectbasic" name="selectbasic" class="form-control">
                                        <option value="1">Option one</option>
                                        <option value="2">Option two</option>
                                    </select>             
                                </div>
                                <div class="col-md-4">
                                    <label for="textinput">Nivel de escritura</label>
                                    <div class="row">
                                    <div class="col-md-6">    
                                    <select id="selectbasic" name="selectbasic" class="form-control">
                                        <option value="1">Option one</option>
                                        <option value="2">Option two</option>
                                    </select>        
                                    </div>
                                        <div class="col-md-6">
                                          <button id="singlebutton" name="cargarArchivo" type="file" class="btn btn-primary">Agregar idioma</button>     
                                        </div>    
                                    </div>    
                                </div>
                            </div></br>
                            <div class="row">
                                <div class="col-md-12">
                                    <table class="table table-bordered">
                                        <H5>Idiomas ingresados</H5>
                                        <thead>
                                            <tr class="success">
                                                <th>No</th>
                                                <th>Idioma</th>
                                                <th>Nivel de habla</th>
                                                <th>Nivel de lectura</th>
                                                <th>Nivel de escritura</th>
                                                <th>Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr class="info">
                                                <td> </td>
                                                <td> </td>
                                                <td> </td>
                                                <td> </td>
                                                <td> </td>
                                                <td><button id="Editar" name="Editar" class="btn btn-success">Editar</button><button id="eliminar" name="eliminar" class="btn btn-danger">Eliminar</button></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div> 
                            </div>
                            <div class="row">
                            </div></br>
                            <div class="row">
                            </div></br>
                    </form> </fieldset>         
                <div class="row">
                    <div class="col-md-4 col-lg-offset-4">
                        <button id="button1id" name="continuar" class="btn btn-primary">Continuar</button>
                        <button id="button1id" name="regresar" class="btn btn-primary">Regresar</button>
                        <button id="button2id" name="cancelar" class="btn btn-danger">Cancelar</button>
                    </div>
                </div></br>
            </br>
        </div>
    </div>  </fieldset>

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
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
    $(function () {
        $('.input-group.date').datepicker({
            format: "yyyy",
            autoclose: true,
            minViewMode: "years"
        });
    });
</script>
</body>
</html>

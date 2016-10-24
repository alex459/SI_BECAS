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
    <link href="css/formSquare.css" rel="stylesheet">
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
        <div class="row">
            <div class="col-md-12">
                <div class="container">


                    <h3>Información de la beca:</h3>

                    <div class="bootstrap-iso">
                        <form>
                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labeltitulo" value="Titulo del proyecto:" disabled style="font-weight: bold; background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="titulo" disabled>    
                                    </div>
                                </div>
                            </div>   

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelinstofer" value="Institución oferente:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="instOferente" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelinstestu" value="Institución de estudio:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="instEstudio" disabled>    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelPais" value="País:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="pais" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelTipoBeca" value="Tipo de beca:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="tipoBeca" disabled>    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelmodalidad" value="Modalidad:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="modalidad" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelDuracion" value="Duración:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="duracion" disabled>    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelFechainicio" value="Fecha de inicio:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="fechaInicio" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelIdioma" value="Idioma" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="idioma" disabled>    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelFinanciamiento" value="Financiamiento:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="financiamiento" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelPerfil" value="Perfil participantes:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="perfil" disabled>    
                                    </div>
                                </div>
                            </div>  

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelpagina" value="Página web:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="pagina" disabled>    
                                    </div>
                                </div>
                            </div>  

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelemail" value="Correo electrónico:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="correo" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labeltel" value="Télefono:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="tel" disabled>    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelCierre" value="Cierre convocatoria:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="cierre" disabled>    
                                    </div>
                                </div>
                            </div></br> 

                            <div clas="row">
                                <div class="col-md-12 col-md-offset-4"> 
                                    <button type="submit" class="btn btn-success">
                                       <span class="glyphicon glyphicon-check"></span> 
                                       Aplicar beca
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <span class="glyphicon glyphicon-cloud-download"></span> 
                                        Descargar prospecto
                                    </button>
                                </div>
                            </div>          
                        </form></div>

                </div>

            </div> 

        </div>
        </br></br>

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

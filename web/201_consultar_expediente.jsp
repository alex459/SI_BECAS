<%-- 
    Document   : 201_consultar_expediente
    Created on : 11-07-2016, 01:49:00 AM
    Author     : Manuel Miranda
--%>

<%@page import="MODEL.variablesDeSesion"%>
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



<p class="text-right">Rol: </p>
<p class="text-right">Usuario: </p>


<%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
<jsp:include page="menu.jsp"></jsp:include>

</head>
<body>
    
    <div class="container-fluid">
        
        <div class="row"><!-- TITULO DE LA PANTALLA -->
            
            <h2>
                <p class="text-center" style="color:#cf2a27">Consultar expediente</p>
            </h2>
            
            <br></br> 
        </div><!-- TITULO DE LA PANTALLA -->                
        
        <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA --> 
            <fieldset class="custom-border">
                <legend class="custom-border">Consultar expediiente</legend>
                <div class="col-md-6 col-md-offset-3">
                    <fieldset class="custom-border">
                        <legend class="custom-border">filtros</legend>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">N° Expediente : </label>
                            </div>
                            <div class="col-md-6">
                                <input id="textinput" name="NUM_EXPEDIENTE" type="text" placeholder="ingrese el numero de expediente" class="form-control input-md">
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Nombre del becario : </label>
                            </div>
                            <div class="col-md-6">
                                <input id="textinput" name="NOM_BECARIO" type="text" placeholder="ingrese el nombre del becario" class="form-control input-md">
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Facultad : </label>
                            </div>
                            <div class="col-md-6">
                                <select id="selectbasic" name="FACULTAD" class="form-control">                            
                                    <option value=0>facultad</option>
                                </select>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Fecha inicio : </label>
                            </div>
                            <div class="input-group date col-md-6">
                                <input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Fecha fin : </label>
                            </div>
                            <div class="input-group date col-md-6">
                                <input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                        </div>
                        <br>
                        <div class="row text-center">
                            <button class="btn btn-primary">Consultar</button><br>
                        </div>
                    </fieldset>
                </div>
                <br>
                <div class="row">
                   <table class="table">
                        <thead>
                            <th>No. Expediente</th>
                            <th>Nombre del becario</th>
                            <th>Facultad</th>
                            <th>Fecha inicio</th>
                            <th>Fecha fin</th>
                            <th>Facultad</th>
                            <th>Duracion</th>
                            <th>Opcion</th>
                        </thead>
                        <tbody>
                            <tr>
                                <td> #</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="text-center"> <input type="button" name="ver" value="Ver" class="btn btn-success"></td>
                            </tr>
                            <tr>
                                <td> #</td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td class="text-center"> <input type="button" name="ver" value="Ver" class="btn btn-success"></td>
                            </tr>
                        </tbody>
                    </table> 
                </div>
            </fieldset>
        </div><!-- CONTENIDO DE LA PANTALLA -->

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
    

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>

<%-- 
    Document   : 205_modificar_institucion
    Created on : 11-07-2016, 04:45:15 AM
    Author     : Manuel Miranda
--%>

<%@page import="MODEL.variablesDeSesion"%>
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
                    <p class="text-center" style="color:#cf2a27">Modificar institucion</p>
                </h2>
                <br></br> 
            </div><!-- TITULO DE LA PANTALLA -->  

            <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->
                <fieldset class="custom-border">
                    <legend class="custom-border">Datos de Institucion</legend>
                    <div class="row col-md-6 col-md-offset-3">
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Nombre de la institucion : </label>
                            </div>
                            <div class="col-md-8">
                                <input id="text_NomInstitucion" name="NOM_INSTITUCION" type="text" class="form-control input-md">
                            </div>
                        </div>
                        <br>
                        <div class="row text-center">
                            <button class="btn btn-success">Cargar Datos</button>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Pais : </label>
                            </div>
                            <div class="col-md-6">
                                <input id="tex_paisInstitucion" name="PAIS_INSITUCION" type="text" class="form-control input-md">
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Pagina web : </label>
                            </div>
                            <div class="col-md-6">
                                <input id="tex_webInstitucion" name="WEB_INSITUCION" type="text" class="form-control input-md">
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Correo electronico : </label>
                            </div>
                            <div class="col-md-6">
                                <input id="tex_correoInstitucion" name="CORREO_INSITUCION" type="text" class="form-control input-md">
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Telefono : </label>
                            </div>
                            <div class="col-md-6">
                                <input id="tex_telefonoInstitucion" name="TELEFONO_INSITUCION" type="text" class="form-control input-md">
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Tipo de institucion : </label>
                            </div>
                            <div class="col-md-6">
                                <select id="select_tipoInstitucion" name="TIPO_INSTITUCION" class="form-control">                            
                                    <option value=0></option>
                                </select>
                            </div>
                        </div>
                        <br>
                        <div class="row text-center">
                            <button class="btn btn-primary">Actualizar</button>
                            <button class="btn btn-danger">Cancelar</button><br>
                        </div>
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
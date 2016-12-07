<%-- 
    Document   : 802_solicitar_inicio_de_servicio_contractual
    Created on : 12-04-2016, 06:27:01 PM
    Author     : Manuel Miranda
--%>

<%-- 
    Document   : 801_agregar_documeto_finalizaciom_beca
    Created on : 12-04-2016, 07:03:26 AM
    Author     : Manuel Miranda
--%>

<%@page import="MODEL.variablesDeSesion"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String rol=(String)actual.getAttribute("rol");
    String user=(String)actual.getAttribute("user");
     if(user==null){
     response.sendRedirect("login.jsp");
        return;
     }
%>

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

        <p class="text-right" style="font-weight:bold;">Rol: <%= rol %></p>
        <p class="text-right" style="font-weight:bold;">Usuario: <%= user %></p>

        <%-- todo el menu esta contenido en la siguiente linea
             el menu puede ser cambiado en la pagina menu.jsp --%>
        <jsp:include page="menu_corto.jsp"></jsp:include>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row"><!-- TITULO DE LA PANTALLA -->
                <h2>
                    <p class="text-center" style="color:#cf2a27">Solicitar inicio de servicio contractual</p>
                </h2>
                <br></br> 
            </div><!-- TITULO DE LA PANTALLA -->  

            <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->
                <form class="form-horizontal" action="" method="post" enctype="multipart/form-data">
                    <fieldset class="custom-border">
                        <legend class="custom-border">Adjuntar documentos necesarios</legend>
                        <div class="col-md-8 col-md-offset-2 row">
                            <div class="row">
                                <div class="col-md-5">
                                    Acta de toma de posesión:
                                </div>
                                <div class="col-md-7">
                                    <input type="file" name="doc_digital" accept="application/pdf" valid-file ng-required="true">
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-5">
                                    Proyecto en que apoyara:
                                </div>
                                <div class="col-md-7">
                                    <input type="file" name="doc_digital" accept="application/pdf" valid-file ng-required="true">
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-5">
                                    <div class="col-md-5" style="padding-left: 0px;">Carta Solicitud:</div>
                                    <div class="col-md-7">para:
                                        <select>
                                            <option>Junta Directiva</option>
                                            <option>Consejo de Becas</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <input type="file" name="doc_digital" accept="application/pdf" valid-file ng-required="true">
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-5">
                                    <div class="col-md-5" style="padding-left: 0px;">Carta Solicitud:</div>
                                    <div class="col-md-7">para:
                                        <select>
                                            <option>Junta Directiva</option>
                                            <option>Consejo de Becas</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <input type="file" name="doc_digital" accept="application/pdf" valid-file ng-required="true">
                                </div>
                            </div>
                            <br>
                            <div class="row text-center">
                                <input type="submit" class="btn btn-success" name="submit" value="Emviar">
                            </div>
                        </div>
                    </fieldset>
                </form>
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
        <script src="js/angular.min.js"></script>
    </body>
</html>
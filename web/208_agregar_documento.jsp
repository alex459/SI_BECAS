<%-- 
    Document   : 208_agregar_documento
    Created on : 11-07-2016, 04:53:51 AM
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
        <H3 class="text-center" style="color:#E42217;">Agregar Documento</H3>
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <fieldset class="custom-border">
                <legend class="custom-border">Datos del Documento</legend>
                <h5 style="color:#E42217;">Ingrese la informacion del documento</h5><br>
                <form  action="AgregarDocumentoServlet" method="POST" enctype="multipart/form-data">
                    <div class="row">
                        <div class="col-md-4">
                            <label>Tipo de Documento:</label>
                        </div>
                        <div class="col-md-7">
                            <select class="form-control" name="tipo">
                                <option value="1">Doc 1</option>
                                <option value="2">Doc 2</option>
                            </select><br>
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <label>Documento Digital:</label>
                        </div>
                        <div class="col-md-8">
                            <input type="file" name="doc_digital" accept="application/pdf"><br>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <label>Observacion:</label>
                        </div>
                        <div class="col-md-7">
                            <textarea class="form-control" name="observacion"></textarea><br>
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="row text-center">
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <div class="col-md-6">
                                <input type="submit" name="guardar" value="Guardar" class="btn btn-primary">
                            </div>
                            <div class="col-md-6">
                                <button class="btn btn-danger">Cancelar</button>
                            </div>
                        </div>
                        <div class="col-md-3"></div>   
                    </div>
                </form>


            </fieldset>
        </div>
        <div class="col-md-3"></div>

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


</body>
</html>
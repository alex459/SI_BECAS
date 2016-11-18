<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
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
                <p class="text-center" style="color:#cf2a27">Titulo de la pantalla</p>
            </h2>
            <br></br> 
        </div><!-- TITULO DE LA PANTALLA -->  

        <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->

            <form class="form-horizontal" action="" method="post">

                <div class="row"> 
                    <div class="row">
                        <div class="col-md-2 text-right">
                            <label for="textinput">campo de texto : </label>                             
                        </div>
                        <div class="col-md-2">
                            <input id="CAMPO1" name="CAMPO1" type="text" onFocus="mostrarMensaje('help1', 'Ingrese solo letras. Maximo 15')" onBlur="ocultarMensaje('help1')" onkeypress="return validarTexto('CAMPO1', event, 15)" placeholder="ingrese letras" class="form-control input-md">                                                                                            
                            <small id="help1"></small>
                        </div>
                        <div class="col-md-2 text-right">
                            <label for="textinput">campo de numeros :</label>                                
                        </div>
                        <div class="col-md-2">
                            <input id="CAMPO2" name="CAMPO2" type="text" onFocus="mostrarMensaje('help2', 'Ingrese solo numeros. Maximo 10')" onBlur="ocultarMensaje('help2')" onkeypress="return validarTexto('CAMPO2', event, 10)" placeholder="ingrese numeros" class="form-control input-md">                                
                            <small id="help2"></small>
                        </div>  
                        <div class="col-md-2 text-right">
                            <label for="textinput">campo alfanumerico :</label>                                
                        </div>
                        <div class="col-md-2">
                            <input id="CAMPO3" name="CAMPO3" type="text" onFocus="mostrarMensaje('help3', 'Ingrese alfanumericos. Maximo 5')" onBlur="ocultarMensaje('help3')" onkeypress="return validarTexto('CAMPO3', event, 5)" placeholder="ingrese caracteres alfanumericos" class="form-control input-md"> 
                            <small id="help3"></small>
                        </div> 
                    </div> 
                </div>

                <br>

                <div class="row">
                    <div class="col-md-12 text-center">                        
                        <input type="submit" class="btn btn-primary" name="submit" onclick="return ValidarCamposVacios('CARNET,NOMBRE1_DU,NOMBRE2_DU,APELLIDO1_DU,APELLIDO2_DU,CLAVE,CLAVE2')" value="Crear usuario">
                    </div>
                </div>



            </form>

        </div>

    </div>
    
    <br>
    <br>
    <br>

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
<script type="text/javascript" src="js/validaciones.js"></script> <!-- para hacer funcionar las validaciones javascript -->
</html>
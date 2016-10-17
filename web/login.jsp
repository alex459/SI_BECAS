<%-- 
    Document   : login
    Created on : 10-16-2016, 04:15:39 PM
    Author     : MauricioBC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sistema informático para la administración de becas de postgrado</title>
        <meta name="description" content="Source code generated using layoutit.com">
        <meta name="author" content="LayoutIt!">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">


    <div class="row">
        <div class="col-md-12">
            <div class="row"> 
                <img alt="Bootstrap Image Preview" src="img/logo.jpg" align="middle"  class="img-responsive center-block">
                <h3 class="text-center" >
                    <p class="text-danger">Universidad De El Salvador</p>
                </h3>
            </div>
            <div class="row">          
                <div class="col-xs-12" style="height:50px;"></div>
                <h1 class="text-center">
                    <p class="text-danger" style="text-shadow:3px 3px 3px #666;">Sistema informático para la administración de becas de postgrado</p>
                </h1>
                <div class="col-xs-12" style="height:50px;"></div>
            </div>

        </div>
    </div>  
</head>
<body>

    <div class="container-fluid">      
        <div class="container">
            <div class="modal-content">  
                <div class="panel-body">
                    <form class="form-signin">
                        <h2 class="form-signin-heading">Ingrese sus datos:</h2>
                        <fieldset>
                            <div class="form-group">
                                <input class="form-control" placeholder="Carnet de empleado" name="carnet" autofocus="">
                            </div>
                            <div class="form-group">
                                <input class="form-control" placeholder="Contraseña" name="password" type="password" value="">
                            </div>
                        </fieldset> 
                        <button class="btn btn-lg btn-danger btn-block" type="submit" >Ingresar</button> 
                        <a href="principal.jsp"> ENTRAR </a>
                    </form>
                </div>   
            </div>    
        </div> 	
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>

<%-- 
    Document   : login
    Created on : 10-16-2016, 04:15:39 PM
    Author     : MauricioBC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% session.invalidate();%>
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
<body ng-app="loginApp" ng-controller="loginCtrl">

    <div class="container-fluid">      
        <div class="container">
            <div class="modal-content">  
                <div class="panel-body">                    
                    <form name= "login" class="form-signin" action="loginServlet" method="post" novalidate>
                        <h2 class="form-signin-heading">Ingrese sus datos:</h2>
                        <fieldset>
                            <div class="form-group">
                                <input id="user" class="form-control" placeholder="Usuario" name="user" autofocus="" ng-model="datos.user" ng-required="true" ng-pattern="/^[A-Z0-9]*$/" minlength="7" maxlength="7">                                                                
                                <span class="text-danger" ng-show="!login.$pristine && login.user.$error.required">El usuario es requerido.</span>
                                <span class="text-danger" ng-show="login.user.$error.minlength">Minimo 7 caracteres.</span>
                                <span class="text-danger" ng-show="login.user.$error.pattern">Solo se permiten letras mayusculas y numeros. (A-Z, 0-9).</span>
                            </div>
                            <div class="form-group">
                                <input id="pass" class="form-control" placeholder="Contraseña" name="pass" type="password" value="" ng-model="datos.pass" ng-required="true" ng-pattern="/^[A-Z0-9]*$/" maxlength="10" minlength="6">
                                <span class="text-danger" ng-show="!login.$pristine && login.pass.$error.required">La Contraseña es requerida.</span>
                                <span class="text-danger" ng-show="login.pass.$error.minlength">Minimo 6 caracteres.</span>
                                <span class="text-danger" ng-show="login.pass.$error.pattern">Solo se permiten caracteres alfanumericos (A-Z y 0-9).</span>
                            </div>
                        </fieldset> 
                        <button class="btn btn-lg btn-success btn-block" type="submit" ng-disabled="!login.$valid">Ingresar</button>
                        <a class="btn btn-lg btn-danger btn-block" href="index.jsp" >Salir</a>
                    </form>
                </div>   
            </div>    
        </div> 	
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/angular.min.js"></script>
    <script src="js/login.js"></script>

</body>
</html>

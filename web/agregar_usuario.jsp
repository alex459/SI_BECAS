<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
--%>
<%@page import="POJO.TipoUsuario"%>
<%@page import="DAO.TipoUsuarioDao"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="POJO.Facultad"%>
<%@page import="java.util.ArrayList"%>

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




<%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
<jsp:include page="menu_corto.jsp"></jsp:include>

</head>
<body ng-app="AgregarUsuarioApp" ng-controller="AgregarUsuarioCtrl">

    <div class="container-fluid">
        <div class="row"><!-- TITULO DE LA PANTALLA -->
            <h2>
                <p class="text-center" style="color:#cf2a27">Agregar usuario</p>
            </h2>

            <br></br>

        </div><!-- TITULO DE LA PANTALLA -->  

        <div class="col-md-12">

            <form name= "agregarUsuario" class="form-horizontal" action="AgregarUsuarioServlet" method="post" novalidate>
                <fieldset class="custom-border">  
                    <legend class="custom-border">Datos personales</legend>
                    <div class="row"> 
                        <div class="col-md-3 text-right">                                   
                            <label for="textinput">Codigo de usuario : </label>                                
                        </div>
                        <div class="col-md-3">
                            <input id="CARNET" name="CARNET" type="text" placeholder="ingrese un codigo para el usuario" class="form-control input-md" ng-model="datos.codigo" ng-required="true" minlength="8" maxlength="10">
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.CARNET.$error.required">El codigo es requerido.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CARNET.$error.minlength">Minimo 8 caracteres</span>
                            <small id="help1"></small>
                        </div>
                        <div class="col-md-3 text-right">
                            
                        </div>                        
                    </div> 

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Primer nombre : </label>                             
                        </div>
                        <div class="col-md-3">
                            <input id="NOMBRE1_DU" name="NOMBRE1_DU" type="text" placeholder="ingrese el primer nombre" class="form-control input-md" ng-model="datos.nombre1" ng-required="true" ng-pattern="/^[a-zA-Z]*$/" maxlength="15" minlength="3"> 
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.NOMBRE1_DU.$error.required">El Primer Nombre es requerido.</span>
                            <span class="text-danger" ng-show="agregarUsuario.NOMBRE1_DU.$error.minlength">Minimo 3 caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.NOMBRE1_DU.$error.pattern">Solo se permiten caracteres alfabeticos (A-Z).</span>
                            <small id="help2"></small>
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="textinput">Segundo nombre :</label>                                
                        </div>
                        <div class="col-md-3">
                            <input id="NOMBRE2_DU" name="NOMBRE2_DU" type="text"  placeholder="ingrese el segundo nombre" class="form-control input-md" ng-model="datos.nombre2"  ng-pattern="/^[a-zA-Z]*$/" maxlength="15" minlength="3">    
                            <span class="text-danger" ng-show="agregarUsuario.NOMBRE2_DU.$error.minlength">Minimo 3 caracteres</span>
                            <span class="text-danger" ng-show="agregarUsuario.NOMBRE2_DU.$error.pattern">Solo se permiten caracteres alfabeticos (A-Z)</span>
                            <small id="help3"></small>
                        </div>  
                    </div>

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Primer apellido :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <input id="APELLIDO1_DU" name="APELLIDO1_DU" type="text" placeholder="ingrese el primer apellido" class="form-control input-md" ng-model="datos.apellido1" ng-required="true" ng-pattern="/^[a-zA-Z]*$/" maxlength="15" minlength="3"> 
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.APELLIDO1_DU.$error.required">El Primer Apellido es requerido.</span>
                            <span class="text-danger" ng-show="agregarUsuario.APELLIDO1_DU.$error.minlength">Minimo 3 caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.APELLIDO1_DU.$error.pattern">Solo se permiten caracteres alfabeticos (A-Z).</span>
                            <small id="help4"></small>
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="textinput">Segundo apellido :</label>                                                            
                        </div>
                        <div class="col-md-3">                                
                            <input id="APELLIDO2_DU" name="APELLIDO2_DU" type="text" placeholder="ingrese el segundo apellido" class="form-control input-md"ng-model="datos.apellido2" ng-pattern="/^[a-zA-Z]*$/" maxlength="15" minlength="3"> 
                            <span class="text-danger" ng-show="agregarUsuario.APELLIDO2_DU.$error.minlength">Minimo 3 caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.APELLIDO2_DU.$error.pattern">Solo se permiten caracteres alfabeticos (A-Z).</span>
                            <small id="help5"></small>
                        </div>              
                    </div>                      

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Contraseña :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <input id="CLAVE" name="CLAVE" type="password"  placeholder="ingrese una contraseña" class="form-control input-md" ng-model="datos.contrasena1" ng-required="true" ng-pattern="/^[a-zA-Z]*$/" maxlength="10" minlength="6">
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.CLAVE.$error.required">La Contraseña es requerida.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CLAVE.$error.minlength">Minimo 6 caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CLAVE.$error.pattern">Solo se permiten caracteres alfabeticos (A-Z).</span>
                            <small id="help6"></small>
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="textinput">Confirmar contraseña :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <input id="CLAVE2" name="CLAVE2" type="password" placeholder="ingrese nuevamente la contraseña" class="form-control input-md" ng-model="datos.contrasena2" ng-required="true" ng-pattern="/^[a-zA-Z]*$/" maxlength="10" minlength="6">
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.CLAVE2.$error.required">Debe Confirmar la Contraseña.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CLAVE2.$error.minlength">Minimo 6 caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CLAVE2.$error.pattern">Solo se permiten caracteres alfabeticos (A-Z).</span>
                            <small id="help7"></small>
                        </div>              
                    </div>

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Rol del usuario :</label>                                
                        </div>
                        <div class="col-md-3">                                

                            <select id="selectbasic" name="ID_TIPO_USUARIO" class="form-control" ng-model="datos.tipoUsuario" ng-required="true">
                            <%
                                TipoUsuarioDao tipoUsuarioDao = new TipoUsuarioDao();
                                ArrayList<TipoUsuario> listaTiposDeUsuarios = new ArrayList<TipoUsuario>();
                                listaTiposDeUsuarios = tipoUsuarioDao.consultarTodos();
                                for (int i = 0; i < listaTiposDeUsuarios.size(); i++) {
                                    out.write("<option value=" + listaTiposDeUsuarios.get(i).getIdTipoUsuario() + ">" + listaTiposDeUsuarios.get(i).getTipoUsuario() + "</option>");
                                }
                            %>    
                        </select> 
                        <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.ID_TIPO_USUARIO.$error.required">El Tipo de Usuario es requerido.</span>

                    </div>
                    <div class="col-md-3 text-right">
                        <label for="textinput">Facultad :</label>                                
                    </div>
                    <div class="col-md-3">                                

                        <select id="selectbasic" name="ID_FACULTAD" class="form-control" ng-model="datos.tipoUsuario" ng-required="true">
                            <%
                                FacultadDAO facultadDao = new FacultadDAO();
                                ArrayList<Facultad> listaFacultades = new ArrayList<Facultad>();
                                listaFacultades = facultadDao.consultarTodos();
                                for (int i = 0; i < listaFacultades.size(); i++) {
                                    out.write("<option value=" + listaFacultades.get(i).getIdFacultad() + ">" + listaFacultades.get(i).getFacultad() + "</option>");
                                }
                            %>                    
                        </select>
                        <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.ID_FACULTAD.$error.required">La Facultad es requerida.</span>
                    </div>              
                </div>

                <br>        

                <div class="row">
                    <div class="col-md-12 text-center">

                        <input type="submit" class="btn btn-primary" name="submit" value="Crear usuario" ng-disabled="!agregarUsuario.$valid">

                    </div>
                </div>

            </fieldset>
        </form>                    
    </div>
</div>







<br></br>







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
<script src="js/angular.min.js"></script>
<script src="js/agregarUsuario.js"></script>
</body>
</html>

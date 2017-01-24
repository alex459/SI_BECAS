<%-- 
    Document   : 116_registrar_usuario
    Created on : 01-24-2017, 01:55:22 PM
    Author     : jose
--%>

<%@page import="POJO.TipoUsuario"%>
<%@page import="DAO.TipoUsuarioDao"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="POJO.Facultad"%>

<!-- inicio proceso de seguridad de login -->
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String id_usuario_login = (String) actual.getAttribute("id_user_login");
    String rol = (String) actual.getAttribute("rol");
    String user = (String) actual.getAttribute("user");
    Integer tipo_usuario_logeado = (Integer) actual.getAttribute("id_tipo_usuario");
    ArrayList<String> tipo_usuarios_permitidos = new ArrayList<String>();
    //AGREGAR SOLO LOS ID DE LOS USUARIOS AUTORIZADOS PARA ESTA PANTALLA------
    tipo_usuarios_permitidos.add("1");
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!-- fin de proceso de seguridad de login -->

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



</head>
<body ng-app="RegistrarUsuarioApp" ng-controller="RegistrarUsuarioCtrl">

    <div class="container-fluid">
        <div class="row"><!-- TITULO DE LA PANTALLA -->
            <h2>
                <p class="text-center" style="color:#cf2a27">Registrando usuario nuevo</p>
            </h2>

            <br></br>

        </div><!-- TITULO DE LA PANTALLA -->  

        <div class="col-md-12">

            <form name= "registrarUsuario" class="form-horizontal" action="RegistrarUsuarioServlet" method="post" novalidate>
                <fieldset class="custom-border">  
                    <legend class="custom-border">Datos personales</legend>
                    <div class="row"> 
                        <div class="col-md-3 text-right">                                   
                            <label for="textinput">Codigo de usuario : </label>                                
                        </div>
                        <div class="col-md-3">
                            <input type="text" value="<%=user%>" placeholder="ingrese un codigo para el usuario." class="form-control input-md"  disabled="true">                            
                            <input hidden="" name="CARNET" value="<%=user%>">
                    </div>
                    <div class="col-md-3 text-right">                                   
                        <label for="textinput">Email : </label>                                
                    </div>
                    <div class="col-md-3">
                        <input id="EMAIL" name="EMAIL" type="email" ng-init="datos.correo = '<% out.write(user+"@UES.EDU.SV");  %>'" placeholder="ingrese el correo electronico" class="form-control input-md"  ng-model="datos.correo" ng-required="true"  minlength="3" maxlength="30" >
                        <span class="text-danger" ng-show="!registrarUsuario.$pristine && registrarUsuario.EMAIL.$error.required">El correo electronico requerido.</span>
                        <span class="text-danger" ng-show="registrarUsuario.EMAIL.$error.minlength">Minimo 3 caracteres</span>
                        <span class="text-danger" ng-show="registrarUsuario.EMAIL.$error.email">Solo permite formato: ejemplo usuario@ues.com).</span>
                    </div>                        
                </div> 

                <br>

                <div class="row">
                    <div class="col-md-3 text-right">
                        <label for="textinput">Primer nombre : </label>                             
                    </div>
                    <div class="col-md-3">
                        <input id="NOMBRE1_DU" name="NOMBRE1_DU" type="text" placeholder="ingrese el primer nombre" class="form-control input-md" ng-model="datos.nombre1" ng-required="true" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3"> 
                        <span class="text-danger" ng-show="!registrarUsuario.$pristine && registrarUsuario.NOMBRE1_DU.$error.required">El Primer Nombre es requerido.</span>
                        <span class="text-danger" ng-show="registrarUsuario.NOMBRE1_DU.$error.minlength">Minimo 3 caracteres.</span>
                        <span class="text-danger" ng-show="registrarUsuario.NOMBRE1_DU.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                        <small id="help2"></small>
                    </div>
                    <div class="col-md-3 text-right">
                        <label for="textinput">Segundo nombre :</label>                                
                    </div>
                    <div class="col-md-3">
                        <input id="NOMBRE2_DU" name="NOMBRE2_DU" type="text"  placeholder="ingrese el segundo nombre" class="form-control input-md" ng-model="datos.nombre2"  ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">    
                        <span class="text-danger" ng-show="registrarUsuario.NOMBRE2_DU.$error.minlength">Minimo 3 caracteres</span>
                        <span class="text-danger" ng-show="registrarUsuario.NOMBRE2_DU.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                        <small id="help3"></small>
                    </div>  
                </div>

                <br>

                <div class="row">
                    <div class="col-md-3 text-right">
                        <label for="textinput">Primer apellido :</label>                                
                    </div>
                    <div class="col-md-3">                                
                        <input id="APELLIDO1_DU" name="APELLIDO1_DU" type="text" placeholder="ingrese el primer apellido" class="form-control input-md" ng-model="datos.apellido1" ng-required="true" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3"> 
                        <span class="text-danger" ng-show="!registrarUsuario.$pristine && agregarUsuario.APELLIDO1_DU.$error.required">El Primer Apellido es requerido.</span>
                        <span class="text-danger" ng-show="registrarUsuario.APELLIDO1_DU.$error.minlength">Minimo 3 caracteres.</span>
                        <span class="text-danger" ng-show="registrarUsuario.APELLIDO1_DU.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                        <small id="help4"></small>
                    </div>
                    <div class="col-md-3 text-right">
                        <label for="textinput">Segundo apellido :</label>                                                            
                    </div>
                    <div class="col-md-3">                                
                        <input id="APELLIDO2_DU" name="APELLIDO2_DU" type="text" placeholder="ingrese el segundo apellido" class="form-control input-md"ng-model="datos.apellido2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3"> 
                        <span class="text-danger" ng-show="registrarUsuario.APELLIDO2_DU.$error.minlength">Minimo 3 caracteres.</span>
                        <span class="text-danger" ng-show="registrarUsuario.APELLIDO2_DU.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                        <small id="help5"></small>
                    </div>              
                </div>                      

                <br>

                <div class="row">                    
                    <div class="col-md-3 text-right">
                        <label for="textinput">Facultad :</label>                                
                    </div>
                    <div class="col-md-3">                                

                        <select id="selectbasic" name="ID_FACULTAD" class="form-control" ng-model="datos.facultad" ng-required="true">
                            <%
                                FacultadDAO facultadDao = new FacultadDAO();
                                ArrayList<Facultad> listaFacultades = new ArrayList<Facultad>();
                                listaFacultades = facultadDao.consultarTodosMenosAdmin();
                                for (int i = 0; i < listaFacultades.size(); i++) {
                                    out.write("<option value=" + listaFacultades.get(i).getIdFacultad() + ">" + listaFacultades.get(i).getFacultad() + "</option>");
                                }
                            %>                    
                        </select>
                        <span class="text-danger" ng-show="!registrarUsuario.$pristine && registrarUsuario.ID_FACULTAD.$error.required">La Facultad es requerida.</span>
                    </div>              
                </div>

                <br>

                <div class="row">
                    <div class="col-md-3 text-right">
                        <label for="textinput">Sexo :</label>                                
                    </div>
                    <div class="col-md-3">                                
                        <div class="radio">
                            <label><input type="radio" name="GENERO" value="M" checked>M</label>
                        </div>
                        <div class="radio">
                            <label><input type="radio" name="GENERO" value="F">F</label>
                        </div>
                    </div>
                    <div class="col-md-3 text-right">
                    </div>
                    <div class="col-md-3">                                
                    </div>              
                </div>

                <br>

                <div class="row">
                    <div class="col-md-12 text-center">

                        <input type="submit" class="btn btn-primary" name="submit" value="Registrarme" ng-disabled="!registrarUsuario.$valid">

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
<script src="js/registrarUsuario.js"></script>
</body>
</html>

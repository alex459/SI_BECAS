<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
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
    tipo_usuarios_permitidos.add("7");
    tipo_usuarios_permitidos.add("8");
    tipo_usuarios_permitidos.add("9");
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

<jsp:include page="cabecera.jsp"></jsp:include>


<p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
<p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>

<%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
<jsp:include page="menu_corto.jsp"></jsp:include>

</head>
<body ng-app="AgregarUsuarioApp" ng-controller="AgregarUsuarioCtrl">

    <div class="container-fluid">
        <div class="row"><!-- TITULO DE LA PANTALLA -->
            <h3>
                <p class="text-center" style="color:#cf2a27">Agregar Usuario</p>
            </h3>

            <br></br>

        </div><!-- TITULO DE LA PANTALLA -->  

        <div class="col-md-12">

            <form name= "agregarUsuario" class="form-horizontal" action="AgregarUsuarioServlet" method="post" novalidate>
                <fieldset class="custom-border">  
                    <legend class="custom-border">Datos Personales</legend>
                    <div class="row"> 
                        <div class="col-md-3 text-right">                                   
                            <label for="textinput">Código de Usuario : </label>                                
                        </div>
                        <div class="col-md-3">
                            <input id="CARNET" name="CARNET" type="text" placeholder="Ingrese un Código para el Usuario." class="form-control input-md" ng-model="datos.codigo" ng-required="true" ng-pattern="/^[a-zA-Z0-9.]*$/" minlength="3" maxlength="20">
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.CARNET.$error.required">El Usuario es Requerido.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CARNET.$error.minlength">Mínimo 3 Caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CARNET.$error.pattern">Solo se Permiten Letras, Números y Punto. (a-z, A-Z, 0-9 y punto).</span>
                            <small id="help1"></small>
                        </div>
                        <div class="col-md-3 text-right">                                   
                            <label for="textinput">Email : </label>                                
                        </div>
                        <div class="col-md-3">
                            <input id="EMAIL" name="EMAIL" type="email"  placeholder="Ingrese el Correo Electrónico" class="form-control input-md"  ng-model="datos.correo" ng-required="true"  minlength="3" maxlength="30" >
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.EMAIL.$error.required">El Correo Electrónico Requerido.</span>
                            <span class="text-danger" ng-show="agregarUsuario.EMAIL.$error.minlength">Mínimo 3 Caracteres</span>
                            <span class="text-danger" ng-show="agregarUsuario.EMAIL.$error.email">Solo Permite Rormato: ejemplo usuario@ues.com).</span>
                        </div>                        
                    </div> 

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Primer Nombre : </label>                             
                        </div>
                        <div class="col-md-3">
                            <input id="NOMBRE1_DU" name="NOMBRE1_DU" type="text" placeholder="Ingrese el Primer Nombre" class="form-control input-md" ng-model="datos.nombre1" ng-required="true" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3"> 
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.NOMBRE1_DU.$error.required">El Primer Nombre es Requerido.</span>
                            <span class="text-danger" ng-show="agregarUsuario.NOMBRE1_DU.$error.minlength">Mínimo 3 Caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.NOMBRE1_DU.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                            <small id="help2"></small>
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="textinput">Segundo Nombre :</label>                                
                        </div>
                        <div class="col-md-3">
                            <input id="NOMBRE2_DU" name="NOMBRE2_DU" type="text"  placeholder="Ingrese el Segundo Nombre" class="form-control input-md" ng-model="datos.nombre2"  ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">    
                            <span class="text-danger" ng-show="agregarUsuario.NOMBRE2_DU.$error.minlength">Mínimo 3 Caracteres</span>
                            <span class="text-danger" ng-show="agregarUsuario.NOMBRE2_DU.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                            <small id="help3"></small>
                        </div>  
                    </div>

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Primer Apellido :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <input id="APELLIDO1_DU" name="APELLIDO1_DU" type="text" placeholder="Ingrese el Primer Apellido" class="form-control input-md" ng-model="datos.apellido1" ng-required="true" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3"> 
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.APELLIDO1_DU.$error.required">El Primer Apellido es Requerido.</span>
                            <span class="text-danger" ng-show="agregarUsuario.APELLIDO1_DU.$error.minlength">Mínimo 3 Caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.APELLIDO1_DU.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                            <small id="help4"></small>
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="textinput">Segundo Apellido :</label>                                                            
                        </div>
                        <div class="col-md-3">                                
                            <input id="APELLIDO2_DU" name="APELLIDO2_DU" type="text" placeholder="Ingrese el Segundo Apellido" class="form-control input-md"ng-model="datos.apellido2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3"> 
                            <span class="text-danger" ng-show="agregarUsuario.APELLIDO2_DU.$error.minlength">Mínimo 3 Caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.APELLIDO2_DU.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                            <small id="help5"></small>
                        </div>              
                    </div>                      

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Contraseña :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <input id="CLAVE" name="CLAVE" type="password"  placeholder="Ingrese una Contraseña" class="form-control input-md" ng-model="datos.contrasena1" ng-required="true" ng-pattern="/^[A-Z0-9]*$/" maxlength="10" minlength="6">
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.CLAVE.$error.required">La Contraseña es Requerida.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CLAVE.$error.minlength">Mínimo 6 Caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CLAVE.$error.pattern">Solo se permiten Caracteres Alfanuméricos (A-Z y 0-9).</span>
                            <small id="help6"></small>
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="textinput">Confirmar Contraseña :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <input id="CLAVE2" name="CLAVE2" type="password" placeholder="Ingrese Nuevamente la Contraseña" class="form-control input-md" ng-model="datos.contrasena2" ng-required="true" ng-pattern="/^[A-Z0-9]*$/" maxlength="10" minlength="6">
                            <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.CLAVE2.$error.required">Debe Confirmar la Contraseña.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CLAVE2.$error.minlength">Mínimo 6 Caracteres.</span>
                            <span class="text-danger" ng-show="agregarUsuario.CLAVE2.$error.pattern">Solo se Permiten Caracteres Alfanuméricos (A-Z y 0-9).</span>
                            <small id="help7"></small>
                        </div>              
                    </div>

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Rol del Usuario :</label>                                
                        </div>
                        <div class="col-md-3">                                

                            <select id="selectbasic" name="ID_TIPO_USUARIO" class="form-control" ng-model="datos.tipoUsuario" ng-required="true" ng-change="mostrarfacultades()">
                            <%
                                TipoUsuarioDao tipoUsuarioDao = new TipoUsuarioDao();
                                ArrayList<TipoUsuario> listaTiposDeUsuarios = new ArrayList<TipoUsuario>();
                                listaTiposDeUsuarios = tipoUsuarioDao.consultarTodosMenosBecarios();
                                for (int i = 0; i < listaTiposDeUsuarios.size(); i++) {
                                    out.write("<option value=" + listaTiposDeUsuarios.get(i).getIdTipoUsuario() + ">" + listaTiposDeUsuarios.get(i).getTipoUsuario() + "</option>");
                                }
                            %>    
                        </select>                           
                        <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.ID_TIPO_USUARIO.$error.required">El Tipo de Usuario es Requerido.</span>

                    </div>
                    <div class="col-md-3 text-right">
                        <label for="textinput">Facultad :</label>                                
                    </div>
                    <div class="col-md-3">                                

                        <select id="selectbasic" name="ID_FACULTAD" class="form-control" ng-model="datos.facultad" ng-required="true">
                            <option ng-repeat="option in facultades" value="{{option.id}}">{{option.nombre}}</option>                   
                        </select>
                        <span class="text-danger" ng-show="!agregarUsuario.$pristine && agregarUsuario.ID_FACULTAD.$error.required">La Facultad es Requerida.</span>
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

                        <input type="submit" class="btn btn-primary" name="submit" value="Crear Usuario" ng-disabled="!agregarUsuario.$valid">

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

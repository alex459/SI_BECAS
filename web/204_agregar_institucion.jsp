<%-- 
    Document   : 204_agregar_institucion
    Created on : 11-07-2016, 04:42:46 AM
    Author     : Manuel Miranda
--%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="POJO.Pais"%>
<%@page import="DAO.PaisDAO"%>

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

    <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


    <%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>

    </head>
    <body ng-app="AgregarInstitucionApp" ng-controller="AgregarInstitucionCtrl">
        <div class="container-fluid">
            <div class="row"><!-- TITULO DE LA PANTALLA -->
                <h3>
                    <p class="text-center" style="color:#cf2a27">Agregar Institución</p>
                </h3>
                <br></br> 
            </div><!-- TITULO DE LA PANTALLA -->  

            <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->

                <form class="form-horizontal" name="agregarInst" action="AgregarInstitucionServlet" method="post" novalidate >
                    <fieldset class="custom-border">
                        <legend class="custom-border">Datos de Institución</legend>

                        <div class="row col-md-6 col-md-offset-3">
                            <div class="row">

                                <div class="col-md-4 text-right">
                                    <label for="textinput">Nombre de la institución : </label>
                                </div>
                                <div class="col-md-8">
                                    <input id="text_NomInstitucion" name="text_NomInstitucion" type="text"  placeholder="ingrese el nombre de institucion" class="form-control input-md" ng-model="datos.nombreInst" ng-required="true" ng-pattern="/^[A-ZÁÉÍÓÚÑ ]*$/" minlength="3" maxlength="100" >
                                    <span class="text-danger" ng-show="!agregarInst.$pristine && agregarInst.text_NomInstitucion.$error.required">El nombre de la Institucion es requerido.</span>
                                    <span class="text-danger" ng-show="agregarInst.text_NomInstitucion.$error.minlength">Minimo 3 caracteres</span>
                                    <span class="text-danger" ng-show="agregarInst.text_NomInstitucion.$error.pattern">Solo se permiten letras mayusculas (A-Z) .</span>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-4 text-right">
                                    <label for="textinput">País : </label>
                                </div>
                                <div class="col-md-6">
                                    <select id="tex_paisInstitucion" name="tex_paisInstitucion" class="form-control" ng-model="datos.pais" ng-required="true">
                                    <%
                                        PaisDAO paisDao = new PaisDAO();
                                        ArrayList<Pais> listaPais = new ArrayList<Pais>();
                                        listaPais = paisDao.consultarTodos();
                                        for (int i = 0; i < listaPais.size(); i++) {
                                            out.write("<option value=" + listaPais.get(i).getNombrePais() + ">" + listaPais.get(i).getNombrePais() + "</option>");
                                        }
                                    %>    
                                </select>
                                <span class="text-danger" ng-show="!agregarInst.$pristine && agregarInst.tex_paisInstitucion.$error.required">El País es requerido.</span>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Página web : </label>
                            </div>
                            <div class="col-md-6">
                                <input id="tex_webInstitucion" name="tex_webInstitucion" type="url" placeholder="ingrese la url"  class="form-control input-md" ng-model="datos.url" ng-required="true"  minlength="3" maxlength="100" >
                                <span class="text-danger" ng-show="!agregarInst.$pristine && agregarInst.tex_webInstitucion.$error.required">El nombre de la ULR es requerido.</span>
                                <span class="text-danger" ng-show="agregarInst.tex_webInstitucion.$error.minlength">Minimo 3 caracteres</span>
                                <span class="text-danger" ng-show="agregarInst.tex_webInstitucion.$error.url">Solo se permiten formato url: http://ejemplo.com</span> 
                                <small id="help3"></small>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Correo electrónico : </label>
                            </div>
                            <div class="col-md-6">
                                <input id="tex_correoInstitucion" name="tex_correoInstitucion" type="email"  placeholder="ingrese el correo electronico" class="form-control input-md"  ng-model="datos.correo" ng-required="true"  minlength="3" maxlength="30" >
                                <span class="text-danger" ng-show="!agregarInst.$pristine && agregarInst.tex_correoInstitucion.$error.required">El correo electronico requerido.</span>
                                <span class="text-danger" ng-show="agregarInst.tex_correoInstitucion.$error.minlength">Minimo 3 caracteres</span>
                                <span class="text-danger" ng-show="agregarInst.tex_correoInstitucion.$error.email">Solo permite formato: ejemplo institucion@ejemplo.com).</span>
                                <small id="help4"></small>
                            </div>
                        </div>
                        <br>


                        <div class="row">
                            <div class="col-md-4 text-right">
                                <label for="textinput">Tipo de institución : </label>
                            </div>
                            <div class="col-md-6">
                                <select id="select_tipoInstitucion" name="select_tipoInstitucion"  class="form-control" ng-model="datos.tipoInst" ng-required="true"> 
                                    <option value="">Seleccione tipo de institucion</option>
                                    <option value="OFERTANTE">OFERTANTE</option>
                                    <option value="ESTUDIO">ESTUDIO</option>
                                    <option value="OFERTANTE Y ESTUDIO">OFERTANTE Y ESTUDIO</option>
                                </select>
                                <span class="text-danger" ng-show="!agregarInst.$pristine && agregarInst.select_tipoInstitucion.$error.required">La Tipo es requerida.</span>

                            </div>
                        </div>
                        <br>
                        <div class="row text-center">
                            <input type="submit" class="btn btn-primary" name="submit"  value="Guardar" ng-disabled="!agregarInst.$valid">
                            <a href="principal.jsp"  <button class="btn btn-danger">Cancelar</button> </a>  <br>
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
    <script src="js/angular.min.js"></script>
    <script src="js/agregarInstitucion.js"></script>


</body>
</html>
<%-- 
    Document   : 119_Modificar_Becario
    Created on : 20/03/2017, 09:24:56 AM
    Author     : adminPC
--%>
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
        <link href="css/menuSolicitudBeca.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker3.min.css" />
        <link href="css/customfieldset.css" rel="stylesheet">

        <jsp:include page="cabecera.jsp"></jsp:include>



        <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>

</head>
<body>
    <!--TITULO DE PANTALLA-->
    <h3 class="text-center" style="color:#cf2a27">
        Modificar Becario
    </h3>
    <!--FIN TITULO DE PANTALLA-->
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <fieldset class="custom-border">
                <legend class="custom-border">Modificar Becario</legend>
                <div class="row">
                <!--Tabla-->
                <div class="col-md-12">
                    <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                    <td>Becario: </td>
                                    <td></td>
                                    <td>Expediente: </td>
                                    <td></td>
                                    </tr>
                                    
                                    <tr>
                                    <td>Título de Beca: </td>
                                    <td></td>
                                    <td>País: </td>
                                    <td></td>
                                    </tr>
                                    
                                    <tr>
                                        <td>Institución de Estudio:</td>
                                    <td></td>
                                    <td>Institución Oferente: </td>
                                    <td></td>
                                    </tr>
                                    
                                    <tr>
                                        <td>Fecha de Inicio:</td>
                                    <td></td>
                                    <td>Fecha de Fin:</td>
                                    <td></td>
                                    </tr>
                                    
                                </tbody>    
                            </table>
                </div>
                <!--Fin Tabla-->
            </div>
            </fieldset>
            
        </div>
        <div class="col-md-1"></div>
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
</body>
</html>

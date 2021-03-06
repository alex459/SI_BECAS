<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
--%>

<!-- inicio proceso de seguridad de login -->
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    String id_usuario_login = "";
    String rol = "";
    String user = "";
    Integer tipo_usuario_logeado = 0;
    try {
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Cache-Control", "must-revalidate");
        response.setHeader("Cache-Control", "no-cache");
        HttpSession actual = request.getSession();
        id_usuario_login = (String) actual.getAttribute("id_user_login");
        rol = (String) actual.getAttribute("rol");
        user = (String) actual.getAttribute("user");
        tipo_usuario_logeado = (Integer) actual.getAttribute("id_tipo_usuario");
        ArrayList<String> tipo_usuarios_permitidos = new ArrayList<String>();
        //AGREGAR SOLO LOS ID DE LOS USUARIOS AUTORIZADOS PARA ESTA PANTALLA------
        tipo_usuarios_permitidos.add("1");
        tipo_usuarios_permitidos.add("2");
        tipo_usuarios_permitidos.add("3");
        tipo_usuarios_permitidos.add("4");
        tipo_usuarios_permitidos.add("5");
        tipo_usuarios_permitidos.add("6");
        tipo_usuarios_permitidos.add("7");
        tipo_usuarios_permitidos.add("8");
        tipo_usuarios_permitidos.add("9");
        boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
        if (!autorizacion || user == null) {
            response.sendRedirect("logout.jsp");
        }
    } catch (Exception e) {
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
<jsp:include page="cabecera.jsp"></jsp:include>





<p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
<p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


<%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
<jsp:include page="menu.jsp"></jsp:include>

</head>
<body>
  
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                
                <div class="col-xs-12" style="height:50px;"></div>
                <div class="jumbotron">
                    <div class="row">
                        <div class="col-md-12">				
                            <img alt="Bootstrap Image Preview" src="img/portada1.jpg" align="middle"  class="img-responsive center-block">
                        </div>				                          	
                    </div>
                </div>
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
    <script src="js/scripts.js"></script>
</body>
</html>

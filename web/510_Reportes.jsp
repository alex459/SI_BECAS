<%-- 
    Document   : 510_Reportes
    Created on : 29/10/2016, 10:37:51 PM
    Author     : adminPC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<!-- inicio proceso de seguridad de login -->
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
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
    tipo_usuarios_permitidos.add("8"); //consejo de beca
    tipo_usuarios_permitidos.add("9"); //admin
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!-- fin de proceso de seguridad de login -->


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

    <jsp:include page="menu_corto.jsp"></jsp:include>
</head>



<body>
    <br> <br> <br> <br>
    <fieldset class="custom-border">
        <div class="container-fluid">
            <H3 class="text-center" style="color:#E42217;">Reportes</H3>
            <div class="row">
                <div class="col-md-2"></div>
                <div class="col-md-10">
                    <a href="511_Reporte_Institucion_Financiera.jsp">Reporte de Becarios por Institucion Financiera</a><br><br>
                    <a href="512_Reporte_Becarios_Incumplimiento_Contrato.jsp">Reporte de Becarios con Incumplimiento de Contrato</a><br><br>
                    <a href="513_Reporte_Candidatos.jsp">Reporte de Candidatos a Beca</a><br><br>
                    <a href="514_Reporte_Becarios_Documentos_Pendientes.jsp">Reporte de Becarios con Documentos Pendientes</a><br><br>
                    <a href="515_Reporte_Institucion_Becarios_Activos.jsp">Reporte de Instituciones con Becarios Activos</a><br><br>
                    <a href="516_Reporte_Tipos_Becarios.jsp">Reporte por Tipos de Becarios </a><br><br>
                    <a href="517_Reporte_Documentos_Unidad.jsp">Reporte de Documentos Emitidos por Unidad</a><br><br>
                </div>
            </div>

        </div> 
    </fieldset>
    <br><br><br><br><br><br>
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
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>

</body>
</html>

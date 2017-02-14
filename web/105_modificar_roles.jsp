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
    if (!autorizacion || user==null) {
        response.sendRedirect("logout.jsp");        
    }
%>
<!-- fin de proceso de seguridad de login -->

<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.TipoUsuario"%>
<%@page import="DAO.TipoUsuarioDao"%>
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



<p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
<p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


<%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
<jsp:include page="menu_corto.jsp"></jsp:include>

</head>
<body>

<%

    String id_usuario = request.getParameter("ID_USUARIO");
    String id_detalle_usuario = request.getParameter("ID_DETALLE_USUARIO");
    ConexionBD conexionBD = new ConexionBD();
    String consultaSql = "SELECT CARNET, CONCAT(DU.NOMBRE1_DU,' ', DU.NOMBRE2_DU, ' ', DU.APELLIDO1_DU, ' ', DU.APELLIDO2_DU) AS NOMBRES, F.FACULTAD, TU.TIPO_USUARIO, TU.ID_TIPO_USUARIO FROM DETALLE_USUARIO DU NATURAL JOIN USUARIO U NATURAL JOIN TIPO_USUARIO TU NATURAL JOIN FACULTAD F WHERE U.ID_USUARIO = " + id_usuario;
    ResultSet rs = null;
    //out.write(consultaSql);
    String carnet = new String();
    String nombres = new String();
    String facultad = new String();
    String tipo_usuario = new String();
    String id_tipo_usuario = new String();

    try {
        rs = conexionBD.consultaSql(consultaSql);
        while (rs.next()) {
            carnet = rs.getString(1);
            nombres = rs.getString(2);
            facultad = rs.getString(3);
            tipo_usuario = rs.getString(4);
            id_tipo_usuario = rs.getString(5);
        }
    } catch (Exception ex) {
        System.err.println("error: " + ex);
    }

%>


<div class="container-fluid">
    <div class="row"><!-- TITULO DE LA PANTALLA -->
        <h3>
            <p class="text-center" style="color:#cf2a27">Modificar Roles</p>
        </h3>

        <br></br>

    </div><!-- TITULO DE LA PANTALLA -->  

    <div class="col-md-12">

        <form class="form-horizontal" action="ModificarRolesServlet" method="post">
            <fieldset class="custom-border">  
                <legend class="custom-border">Paso 2: Seleccione el nuevo rol y de clic en Modificar rol</legend>


                <div class="row"> 
                    <div class="col-md-3">                                                                                                                
                    </div>
                    <div class="col-md-3 text-right">                                   
                        <label for="textinput">Codigo de empleado : </label>                            
                    </div>
                    <div class="col-md-3 text-center">                                                        
                        <input id="textinput" name="textinput" type="text" class="form-control input-md" value = "<%=carnet%>" disabled>                            
                        <input id="CARNET" name="CARNET" type="hidden" value = "<%=carnet%>">                            
                    </div>
                    <div class="col-md-3">                                                                                                                
                    </div>
                </div> 


                <br>


                <div class="row">   <!-- TABLA RESULTADOS -->
                    <div class="col-md-2">                                                                                                                
                    </div>
                    <div class="col-md-8">

                        <table class="table table-bordered"></br>                                                        
                            <tbody>
                                <tr>
                                    <td>Nombre de usuario </td>
                                    <td><%=nombres%> </td>
                                </tr>
                                
                                <tr>
                                    <td>Facultad </td>
                                    <td><%=facultad%> </td>
                                </tr>
                                
                                <tr>
                                    <td>Tipo Usuarios </td>
                                    <td><%=tipo_usuario%> <input type="hidden" name="TIP_USUARIO_ANTERIOR" value="<%=tipo_usuario%>"></td>
                                </tr>
                                
                            </tbody>
                        </table>
                    </div>

                    <div class="col-md-2">                                                                                                                
                    </div>

                </div>

                <br>

                <div class="row"> 
                    <div class="col-md-3">                                                                                                                
                    </div>
                    <div class="col-md-3 text-right">                                   
                        <label for="textinput">Tipo de usuario : </label>                            
                    </div>
                    <div class="col-md-3 text-center">                                                        

                        <select id="selectbasic" name="ID_TIPO_USUARIO" class="form-control">
                            <%
                                TipoUsuarioDao tipoUsuarioDao = new TipoUsuarioDao();
                                ArrayList<TipoUsuario> listaTiposDeUsuarios = new ArrayList<TipoUsuario>();
                                listaTiposDeUsuarios = tipoUsuarioDao.consultarTodos();
                                out.write("<option value=" + id_tipo_usuario + ">" + tipo_usuario + "</option>");
                                for (int i = 0; i < listaTiposDeUsuarios.size(); i++) {
                                    out.write("<option value=" + listaTiposDeUsuarios.get(i).getIdTipoUsuario() + ">" + listaTiposDeUsuarios.get(i).getTipoUsuario() + "</option>");
                                }
                            %>    
                        </select> 

                    </div>
                    <div class="col-md-3">                                                                                                                
                    </div>
                </div>

                <br>

                <div class="row">
                    <div class="col-md-12 text-center">
                        <input type="submit" class="btn btn-primary" name="submit" value="Modificar rol">
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
<script src="js/scripts.js"></script>
</body>
</html>

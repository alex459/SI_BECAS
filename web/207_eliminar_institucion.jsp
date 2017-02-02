<%-- 
    
    Created on : 12-08-2016, 09:39:54 AM
    Author     : jose
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.InstitucionDAO"%>

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

<%
    String ID_INSTITUCION = "";
    String NOMBRE_INSTITUCION = "";
    String PAIS = "";
    String URL = "";
    String EMAIL = "";
    String TIPO_INSTITUCION = "";
    String INSTITUCION_ACTIVA = "";

    ConexionBD conexionbd = null;
    ResultSet rs = null;

    try {
        ID_INSTITUCION = request.getParameter("ID_INSTITUCION");
        if (ID_INSTITUCION == null) {
            response.sendRedirect("213_consulta_para_modificar_institucion.jsp");
        }
        String consultaSql;
        consultaSql = "SELECT NOMBRE_INSTITUCION, PAIS, PAGINA_WEB, EMAIL, TIPO_INSTITUCION FROM INSTITUCION WHERE ID_INSTITUCION = " + ID_INSTITUCION;
        System.out.println(consultaSql);
        conexionbd = new ConexionBD();
        rs = conexionbd.consultaSql(consultaSql);

        while (rs.next()) {
            NOMBRE_INSTITUCION = rs.getString(1);
            PAIS = rs.getString(2);
            URL = rs.getString(3);
            EMAIL = rs.getString(4);
            TIPO_INSTITUCION = rs.getString(5);
        }

    } catch (Exception ex) {
        System.out.println("Error " + ex);
    }

%>

<%=ID_INSTITUCION%>

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
    <body>
        <div class="container-fluid">
            <div class="row"><!-- TITULO DE LA PANTALLA -->
                <h2>
                    <p class="text-center" style="color:#cf2a27">Eliminar institucion</p>
                </h2>
                <br></br> 
            </div><!-- TITULO DE LA PANTALLA -->  

            <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->

                <form class="form-horizontal" name="modificarInst" action="EliminarInstitucionServlet" method="post" >
                    <fieldset class="custom-border">
                        <legend class="custom-border">Paso 2: De clic al boton eliminar.</legend>

                        <div class="row col-md-6 col-md-offset-3">
                            <div class="row">

                                <div class="col-md-4 text-right">
                                    <label for="textinput">Nombre de la institucion : </label>
                                </div>
                                <div class="col-md-8">
                                    <input id="NOMBRE_INSTITUCION" name="NOMBRE_INSTITUCION" class="form-control input-md" type="text" value = "<%=NOMBRE_INSTITUCION%>" disabled>                                
                                <input type="hidden" id="NOMBRE_INSTITUCION" name="NOMBRE_INSTITUCION" value="<%=NOMBRE_INSTITUCION%>">
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
                                            <td>Pais : </td>
                                            <td><%=PAIS%> <input type="hidden" id="PAIS" name="PAIS" value="<%=PAIS%>"></td>

                                        </tr>
                                        <tr>
                                            <td>Pagina web : </td>
                                            <td><%=URL%> <input type="hidden" id="URL" name="URL" value="<%=URL%>"></td>

                                        </tr>
                                        <tr>
                                            <td>Correo electronico : </td>
                                            <td><%=EMAIL%> <input type="hidden" id="EMAIL" name="EMAIL" value="<%=EMAIL%>"></td>

                                        </tr>
                                        <tr>
                                            <td>Tipo de institucion : </td>
                                            <td><%=TIPO_INSTITUCION%> <input type="hidden" id="TIPO_INSTITUCION" name="TIPO_INSTITUCION" value="<%=TIPO_INSTITUCION%>"></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="col-md-2">                                                                                                                
                            </div>

                        </div>





                        <br>
                        <div class="row text-center">
                            <input type='hidden' name='ID_INSTITUCION' value='<%=ID_INSTITUCION%>'>
                            <input type="submit" class="btn btn-primary" name="submit"  value="Eliminar">
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



</body>
</html>
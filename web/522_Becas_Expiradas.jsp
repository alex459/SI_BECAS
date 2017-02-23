<%-- 
    Document   : 522_Becas_Expiradas
    Created on : 12/01/2017, 11:01:26 AM
    Author     : adminPC
--%>
<%@page import="DAO.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>

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
            <h3 class="text-center text-danger" >
                Universidad De El Salvador
            </h3>
        </div>
        <div class="col-md-8">
            <div class="col-xs-12" style="height:50px;"></div>
            <h2 class="text-center text-danger" style="text-shadow:3px 3px 3px #666;">
                Consejo de Becas y de Investigaciones Científicas <br> Universidad de El Salvador
            </h2>
            <h3 class="text-center text-danger" style="text-shadow:3px 3px 3px #666;">
                Sistema informático para la administración de becas de postgrado
            </h3>
        </div>
    </div>

    <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>
    </head>
    <body ng-app="">
        <div class="container-fluid"> 
            <h3 class="text-center" style="color:#E42217;">Becas Expiradas</h3>

            <div class="col-md-12">
                <fieldset class="custom-border">
                    <legend class="custom-border">Becas Expiradas</legend>

                    <div class="row">
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <table  id="tablaResultados" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Becario</th>
                                        <th>Titulo a Obtener</th>
                                        <th>Institucion</th>
                                        <th>Fecha Fin Beca</th>                                        
                                        <th>Accion</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%try {
                                        int numero = 0;
                                        String becario="";
                                        String titulo="";
                                        String institucion="";
                                        int idExpediente = 0;
                                        ConexionBD conexionbd = new ConexionBD();
                                        ResultSet rs = null;
                                        String consultaSql = "SELECT DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, OB.NOMBRE_OFERTA, I.NOMBRE_INSTITUCION, B.FECHA_FIN, E.ID_EXPEDIENTE FROM detalle_usuario DU JOIN solicitud_de_beca SB ON SB.ID_USUARIO = DU.ID_USUARIO JOIN beca B ON B.ID_EXPEDIENTE = SB.ID_EXPEDIENTE JOIN oferta_beca OB ON OB.ID_OFERTA_BECA = SB.ID_OFERTA_BECA JOIN institucion I ON I.ID_INSTITUCION = OB.ID_INSTITUCION_ESTUDIO JOIN expediente E ON E.ID_EXPEDIENTE = B.ID_EXPEDIENTE WHERE E.ID_PROGRESO IN (9,10,11,20,21,22) AND B.FECHA_FIN > (SELECT CURRENT_DATE FROM DUAL)";
                                        rs = conexionbd.consultaSql(consultaSql);
                                        while (rs.next()) {
                                            becario = rs.getString("NOMBRE1_DU")+" "+rs.getString("NOMBRE2_DU") +" " + rs.getString("APELLIDO1_DU") +" " + rs.getString("APELLIDO2_DU");
                                            titulo= rs.getString("NOMBRE_OFERTA");
                                            institucion = rs.getString("NOMBRE_INSTITUCION"); 
                                            idExpediente = rs.getInt("ID_EXPEDIENTE");
                                            numero++;
                                %>
                                <tr>
                                    <td><%=numero%></td>
                                    <td><%=becario%></td>
                                    <td><%=titulo%></td>
                                    <td><%=institucion%></td>
                                    <td><%=rs.getDate("FECHA_FIN")%></td>
                                    <td>
                                        <form action="523_Resolver_Beca_Expirada.jsp" method="post">
                                            <input type="hidden" name="idExpediente" value="<%=idExpediente%>">
                                            <input type="submit" value="Resolver" class="btn btn-success">
                                        </form>
                                    </td>
                                </tr>
                                <%}
                                    } catch (Exception ex) {
                                        System.out.println("error: " + ex);
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-1"></div>
                </div>
            </fieldset>
        </div>
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript">
   $(document).ready(function() {
    $('#tablaResultados').DataTable(
            {
                 "language": 
{
	"sProcessing":     "Procesando...",
	"sLengthMenu":     "Mostrar _MENU_ registros",
	"sZeroRecords":    "No se encontraron resultados",
	"sEmptyTable":     "Ningún dato disponible en esta tabla",
	"sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
	"sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
	"sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
	"sInfoPostFix":    "",
	"sSearch":         "Buscar:",
	"sUrl":            "",
	"sInfoThousands":  ",",
	"sLoadingRecords": "Cargando...",
	"oPaginate": {
		"sFirst":    "Primero",
		"sLast":     "Último",
		"sNext":     "Siguiente",
		"sPrevious": "Anterior"
	},
	"oAria": {
		"sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
		"sSortDescending": ": Activar para ordenar la columna de manera descendente"
            }
        }
            }
                );
        } );
    </script>
</body>
</html>

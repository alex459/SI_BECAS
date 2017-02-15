

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


<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="MODEL.variablesDeSesion"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <%response.setContentType("text/html;charset=UTF-8");
            request.setCharacterEncoding("UTF-8");
        %>
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
    <body ng-app="consultaParaModificarInstitucionApp" ng-controller="consultaParaModificarInstitucionCtrl">
        <div class="container-fluid" >
            <div class="row"><!-- TITULO DE LA PANTALLA -->
                <h3>
                    <p class="text-center" style="color:#cf2a27">Eliminar Institución</p>
                </h3>
                <br></br> 
            </div><!-- TITULO DE LA PANTALLA -->  

            <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->


                <form class="form-horizontal" name="consultaParaModificarInstitucion" action="214_consulta_para_eliminar_institucion.jsp" method="post" novalidate>
                    <fieldset class="custom-border">
                        <legend class="custom-border">Paso 1: Busque la institución que desea eliminar.</legend>
                        <div class="col-md-6 col-md-offset-3">
                            <fieldset class="custom-border">
                                <legend class="custom-border">filtros:</legend>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Nombre de la institución : </label>
                                    </div>
                                    <div class="col-md-8">
                                        <input id="text_NomInstitucion" name="text_NomInstitucion" type="text" placeholder="ingrese el nombre de instirucion" class="form-control input-md" ng-model="datos.nombreInst"  ng-pattern="/^[A-ZÁÉÍÓÚÑ ]*$/" minlength="3" maxlength="100" >

                                        <span class="text-danger" ng-show="consultaParaModificarInstitucion.text_NomInstitucion.$error.minlength">Minimo 3 letras</span>
                                        <span class="text-danger" ng-show="consultaParaModificarInstitucion.text_NomInstitucion.$error.pattern">Solo se permiten letras mayusculas (A-Z).</span>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">País : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <select id="tex_paisInstitucion" name="tex_paisInstitucion" class="form-control">
                                            <option value="%%">TODOS</option>
                                        <%
                                            PaisDAO paisDao = new PaisDAO();
                                            ArrayList<Pais> listaPais = new ArrayList<Pais>();
                                            listaPais = paisDao.consultarTodos();
                                            for (int i = 0; i < listaPais.size(); i++) {
                                                out.write("<option value=" + listaPais.get(i).getNombrePais() + ">" + listaPais.get(i).getNombrePais() + "</option>");
                                            }
                                        %>    
                                    </select>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-4 text-right">
                                    <label for="textinput">Tipo de institución : </label>
                                </div>
                                <div class="col-md-6">
                                    <select id="select_tipoInstitucion" name="select_tipoInstitucion"  class="form-control">                            
                                        <option value="">TODOS</option>
                                        <option value="OFERTANTE">OFERTANTE</option>
                                        <option value="ESTUDIO">ESTUDIO</option>
                                    </select>
                                </div>
                            </div>
                            <br>                                
                            <div class="row text-center">
                                <input type="submit" class="btn btn-primary" name="submit" value="Buscar" ng-disabled="!consultaParaModificarInstitucion.$valid"> 
                            </div>
                        </fieldset>
                    </div>
            </form>
            <%
                String nombre;
                String pais;
                String tipo;
                String activaOinactiva = "1";

                ConexionBD conexionbd = null;

                ResultSet rs = null;

                try {
                    nombre = request.getParameter("text_NomInstitucion");
                    pais = request.getParameter("tex_paisInstitucion");
                    tipo = request.getParameter("select_tipoInstitucion");

                    //formando la consulta
                    String consultaSql;
                    //out.write(consultaSql);
                    //realizando la consulta

                    if (nombre != null) {
                    } else {
                        nombre = "";
                    };
                    if (pais != null) {
                    } else {
                        pais = "";
                    };
                    if (tipo != null) {
                    } else {
                        tipo = "";
                    };

                    consultaSql = "SELECT NOMBRE_INSTITUCION, TIPO_INSTITUCION, PAIS, PAGINA_WEB, EMAIL,ID_INSTITUCION  FROM  INSTITUCION WHERE NOMBRE_INSTITUCION LIKE '%" + nombre + "%' AND PAIS LIKE '%" + pais + "%' AND TIPO_INSTITUCION LIKE '%" + tipo + "%' AND INSTITUCION_ACTIVA = 1";
                    System.out.println(consultaSql);

                    conexionbd = new ConexionBD();
                    rs = conexionbd.consultaSql(consultaSql);
                    //con el rs se llenara la tabla de resultados
                } catch (Exception ex) {
                    System.out.println("error: " + ex);
                }
            %>  






            <br>
            <div class="row">
                <table id="tablaUsuarios" class="table table-bordered">
                    <thead>
                    <th>No</th>
                    <th>Nombre de la institución</th>
                    <th>Tipo institución</th>
                    <th>País</th>
                    <th>Página web</th>
                    <th>Correo electrónico</th>
                    <th>Opción</th>
                    </thead>
                    <tbody>
                        <%
                            try {
                                Integer i = 0;
                                while (rs.next()) {

                                    i = i + 1;
                                    out.write("<tr>");
                                    out.write("<td>" + i + "</td>");
                                    out.write("<td>" + rs.getString(1) + "</td>");
                                    out.write("<td>" + rs.getString(2) + "</td>");
                                    out.write("<td>" + rs.getString(3) + "</td>");
                                    out.write("<td>" + rs.getString(4) + "</td>");
                                    out.write("<td>" + rs.getString(5) + "</td>");
                                    out.write("<td>");
                                    out.write("<center>");
                                    out.write("<form style='display:inline;' action='207_eliminar_institucion.jsp' method='post'><input type='hidden' name='ID_INSTITUCION' value='" + rs.getString(6) + "'><input type='submit' class='btn btn-success' name='submit' value='Mostrar institución'></form> ");
                                    out.write("</center>");
                                    out.write("</td>");
                                    out.write("</tr>");
                                }
                            } catch (Exception ex) {
                                System.out.println("error: " + ex);
                            }

                        %>  
                    </tbody>
                </table> 
            </div>
            </fieldset>


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
    <script src="js/consultaParaModificarInstitucion.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">
   $(document).ready(function() {
    $('#tablaUsuarios').DataTable(
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

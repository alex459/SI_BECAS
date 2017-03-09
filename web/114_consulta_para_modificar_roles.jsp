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

<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Facultad"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.TipoUsuario"%>
<%@page import="DAO.TipoUsuarioDao"%>
<%@page import="java.sql.ResultSet"%>
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
<body ng-app="consultarUsuarioApp" ng-controller="consultarUsuarioCtrl">

    <div class="container-fluid">
        <div class="row"><!-- TITULO DE LA PANTALLA -->
            <h3>
                <p class="text-center" style="color:#cf2a27">Modificar Roles</p>
            </h3>

            <br></br>

        </div><!-- TITULO DE LA PANTALLA -->  


        <div class="col-md-12">            
            <fieldset class="custom-border">  
                <legend class="custom-border">Paso 1: Busque el usuario que desea modificar su rol.</legend> 


                <div class="row">   <!-- FILTROS -->

                    <div class="col-md-12">
                        <form name= "consultarUsuario" class="form-horizontal" action="114_consulta_para_modificar_roles.jsp" method="post" novalidate>
                            <fieldset class="custom-border">  
                                <legend class="custom-border">Filtros</legend>  

                                <div class="row"> 
                                    <div class="col-md-1 text-right">
                                        <label for="textinput">Código de Usuario : </label>                                
                                    </div>
                                    <div class="col-md-7">
                                        <input id="CARNET" name="CARNET" type="text" placeholder="Ingrese el Usuario a Buscar" class="form-control input-md" ng-model="datos.codigo" ng-pattern="/^[a-zA-Z0-9.]*$/" minlength="3" maxlength="30">
                                        <span class="text-danger" ng-show="consultarUsuario.CARNET.$error.minlength">Mínimo 3 Caracteres.</span>
                                        <span class="text-danger" ng-show="consultarUsuario.CARNET.$error.pattern">Solo se Permiten Letras, Números y Punto(.)</span>
                                    </div>
                                    <div class="col-md-1 text-right">
                                        <label for="textinput">Facultad :</label>                                
                                    </div>
                                    <div class="col-md-3">                                

                                        <select id="selectbasic" name="ID_FACULTAD" class="form-control">
                                            <option value="0">TODOS</option>    
                                        <%
                                            FacultadDAO facultadDao = new FacultadDAO();
                                            ArrayList<Facultad> listaFacultades = new ArrayList<Facultad>();
                                            listaFacultades = facultadDao.consultarTodos();
                                            for (int i = 0; i < listaFacultades.size(); i++) {
                                                out.write("<option value=" + listaFacultades.get(i).getIdFacultad() + ">" + listaFacultades.get(i).getFacultad() + "</option>");
                                            }
                                        %>                    
                                    </select>
                                </div>        
                            </div> 

                            <br>

                            <div class="row">
                                <div class="col-md-1 text-right">
                                    <label for="textinput">Nombre de Usuario : </label>                                
                                </div>

                                <div class="col-md-7">    
                                    <div class="row">

                                        <div class="col-md-3">                                                                                    
                                            <input id="NOMBRE1" name="NOMBRE1" type="text" placeholder="Primer Nombre" class="form-control input-md" ng-model="datos.nombre1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="20" minlength="3">                                            
                                            <span class="text-danger" ng-show="consultarUsuario.NOMBRE1.$error.minlength">Mínimo 3 Caracteres.</span>
                                            <span class="text-danger" ng-show="consultarUsuario.NOMBRE1.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                                        </div>
                                        <div class="col-md-3">    
                                            <input id="NOMBRE2" name="NOMBRE2" type="text" placeholder="Segundo Nombre" class="form-control input-md" ng-model="datos.nombre2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="20" minlength="3">                                            
                                            <span class="text-danger" ng-show="consultarUsuario.NOMBRE2.$error.minlength">Mínimo 3 Caracteres.</span>
                                            <span class="text-danger" ng-show="consultarUsuario.NOMBRE2.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                                        </div> 
                                        <div class="col-md-3">
                                            <input id="APELLIDO1" name="APELLIDO1" type="text" placeholder="Primer Apellido" class="form-control input-md" ng-model="datos.apellido1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="20" minlength="3">                                            
                                            <span class="text-danger" ng-show="consultarUsuario.APELLIDO1.$error.minlength">Mínimo 3 Caracteres.</span>
                                            <span class="text-danger" ng-show="consultarUsuario.APELLIDO1.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                                        </div> 
                                        <div class="col-md-3">
                                            <input id="APELLIDO2" name="APELLIDO2" type="text" placeholder="Segundo Apellido" class="form-control input-md" ng-model="datos.apellido2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="20" minlength="3">
                                            <span class="text-danger" ng-show="consultarUsuario.APELLIDO2.$error.minlength">Mínimo 3 Caracteres.</span>
                                            <span class="text-danger" ng-show="consultarUsuario.APELLIDO2.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                                        </div>

                                    </div>
                                </div>

                                <div class="col-md-1 text-right">
                                    <label for="textinput">Tipo de Usuario :</label>                                
                                </div>
                                <div class="col-md-3">                                
                                    <select id="selectbasic" name="ID_TIPO_USUARIO" class="form-control">
                                        <option value="0">TODOS</option>
                                        <%
                                            TipoUsuarioDao tipoUsuarioDao = new TipoUsuarioDao();
                                            ArrayList<TipoUsuario> listaTiposDeUsuarios = new ArrayList<TipoUsuario>();
                                            listaTiposDeUsuarios = tipoUsuarioDao.consultarTodos();
                                            for (int i = 0; i < listaTiposDeUsuarios.size(); i++) {
                                                out.write("<option value=" + listaTiposDeUsuarios.get(i).getIdTipoUsuario() + ">" + listaTiposDeUsuarios.get(i).getTipoUsuario() + "</option>");
                                            }
                                        %>    
                                    </select> 
                                </div> 
                            </div>

                            <br>        

                            <div class="row">
                                <div class="col-md-12 text-center">
                                    <input type="submit" class="btn btn-primary" name="submit" value="Buscar" ng-disabled="!consultarUsuario.$valid">                       
                                </div>
                            </div>

                        </fieldset>
                    </form>                         
                </div>

            </div>


            <%
                response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
                request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
                String nombre1;
                String nombre2;
                String apellido1;
                String apellido2;
                String carnet;
                Integer id_facultad;
                Integer id_tipo_de_usuario;
                ConexionBD conexionbd = null;
                ResultSet rs = null;

                try {
                    nombre1 = request.getParameter("NOMBRE1");
                    nombre2 = request.getParameter("NOMBRE2");
                    apellido1 = request.getParameter("APELLIDO1");
                    apellido2 = request.getParameter("APELLIDO2");
                    carnet = request.getParameter("CARNET");
                    id_facultad = Integer.parseInt(request.getParameter("ID_FACULTAD"));
                    id_tipo_de_usuario = Integer.parseInt(request.getParameter("ID_TIPO_USUARIO"));

                    //formando la consulta
                    String consultaSql;

                    consultaSql = "SELECT DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, DU.CARNET, F.FACULTAD, TU.TIPO_USUARIO, U.ID_USUARIO, DU.ID_DETALLE_USUARIO FROM DETALLE_USUARIO DU NATURAL JOIN USUARIO U NATURAL JOIN FACULTAD F NATURAL JOIN TIPO_USUARIO TU WHERE DU.NOMBRE1_DU LIKE '%" + nombre1 + "%' AND DU.NOMBRE2_DU LIKE '%" + nombre2 + "%' AND DU.APELLIDO1_DU LIKE '%" + apellido1 + "%' AND DU.APELLIDO2_DU LIKE '%" + apellido2 + "%' AND DU.CARNET LIKE '%" + carnet + "%'";

                    if (id_tipo_de_usuario == 0) {

                    } else {
                        consultaSql = consultaSql.concat(" AND U.ID_TIPO_USUARIO = " + id_tipo_de_usuario + " ");
                    }
                    if (id_facultad == 0) {

                    } else {
                        consultaSql = consultaSql.concat(" AND DU.ID_FACULTAD = " + id_facultad);
                    }

                    //out.write(consultaSql);
                    //realizando la consulta
                    conexionbd = new ConexionBD();
                    rs = conexionbd.consultaSql(consultaSql);

                    //con el rs se llenara la tabla de resultados
                } catch (Exception ex) {

                }
            %>                            

            <div class="row">   <!-- TABLA RESULTADOS -->

                <div class="col-md-12">

                    <table id="tablaUsuarios" class="table table-bordered"></br>                        
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Nombre de Empleado</th>
                                <th>Codigo de Usuario</th>
                                <th>Facultad</th>
                                <th>Tipo de Empleado</th>
                                <th>Acción</th>
                            </tr>
                        </thead>
                        <tbody>                            
                            <%
                                try {
                                    Integer i = 0;
                                    while (rs.next()) {
                                        i = i + 1;
                                        out.write("<tr>");
                                        out.write("<td>" + i + "</td>");
                                        out.write("<td>" + rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4) + "</td>");
                                        out.write("<td>" + rs.getString(5) + "</td>");
                                        out.write("<td>" + rs.getString(6) + "</td>");
                                        out.write("<td>" + rs.getString(7) + "</td>");
                                        out.write("<td>");
                                        out.write("<center>");
                                        out.write("<form style='display:inline;' action='105_modificar_roles.jsp' method='post'><input type='hidden' name='ID_USUARIO' value='" + rs.getString(8) + "'><input type='hidden' name='ID_DETALLE_USUARIO' value='" + rs.getString(9) + "'><input type='submit' class='btn btn-success' name='submit' value='Mostrar usuario'></form> ");
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

            </div>

        </fieldset>                       
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
<script src="js/consultarUsuario.js"></script>
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

<%-- 
    Document   : 407_Comision_Becas_Solicitud_Acuerdos_Pendientes
    Created on : 11-08-2016, 09:49:28 PM
    Author     : aquel
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="MODEL.AgregarOfertaBecaServlet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="DAO.DetalleUsuarioDAO"%>

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
    tipo_usuarios_permitidos.add("3"); //comision de beca
    tipo_usuarios_permitidos.add("9"); //admin
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!-- fin de proceso de seguridad de login -->

<% 
    Integer idFacultad = 0;
    AgregarOfertaBecaServlet OfertaServlet = new AgregarOfertaBecaServlet();
     try{
        DetalleUsuarioDAO DetUsDao = new DetalleUsuarioDAO();
        // Obtener la facultad a la que pertenece el usuario
        idFacultad = DetUsDao.obtenerFacultad(user);
    } catch (Exception e){
        e.printStackTrace();
    }
%>


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
        <link href="css/menuSolicitudBeca.css" rel="stylesheet">    
        <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker3.min.css" />
        <link href="css/customfieldset.css" rel="stylesheet">
        
        <jsp:include page="cabecera.jsp"></jsp:include>

        <p class="text-right" style="font-weight:bold;">Rol: <%= rol %></p>
        <p class="text-right" style="font-weight:bold;">Usuario: <%= user %></p>

        <%-- todo el menu esta contenido en la siguiente linea
        el menu puede ser cambiado en la pagina menu.jsp --%>
        <jsp:include page="menu_corto.jsp"></jsp:include>    
</head>
    <body ng-app="solicitudAcuerdosPendientesComisionBecasApp" ng-controller="solicitudAcuerdosPendientesComisionBecasCtrl">
        <div class="container-fluid" >
            <div class="row"><!-- TITULO DE LA PANTALLA -->
                <h2>
                    <p class="text-center" style="color:#cf2a27">Solicitudes de Dictámenes Pendientes</p>
                </h2>
                <br></br> 
            </div><!-- TITULO DE LA PANTALLA -->  

            <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->
                
                
                
                <fieldset class="custom-border">
                    <legend class="custom-border">Solicitudes de Dictámenes Pendientes</legend>
                    <form name="solicitudAcuerdosPendientesComisionBecas" class="form-horizontal" action="407_Comision_Becas_Solicitud_Acuerdos_Pendientes.jsp" method="post" novalidate>
    
                    <div class="row">      <!-- FILTROS -->
                        <div class="col-md-2"></div>
                        <div class="col-md-8"> 
                        
                       
                            <fieldset class="custom-border">
                                <legend class="custom-border">Filtros</legend>
                                
                                    <div class="row"> 
                                        <div class="col-md-12">   
                                            <label for="textinput">Solicitante: </label>                                                                                      
                                        </div>
                                        
                                        <div class="col-md-12">    
                                            
                                            <div class="row">
                                            
                                            <div class="col-md-3">                                                                                    
                                                <input id="NOMBRE1" name="NOMBRE1" type="text" placeholder="Primer Nombre" class="form-control input-md" ng-model="datos.nombre1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                <span class="text-danger" ng-show="solicitudAcuerdosPendientesComisionBecas.NOMBRE1.$error.minlength">Mínimo 3 Caracteres.</span>
                                                <span class="text-danger" ng-show="solicitudAcuerdosPendientesComisionBecas.NOMBRE1.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                                    
                                            </div>
                                            
                                            <div class="col-md-3">    
                                                <input id="NOMBRE2" name="NOMBRE2" type="text" placeholder="Segundo Nombre" class="form-control input-md" ng-model="datos.nombre2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                <span class="text-danger" ng-show="solicitudAcuerdosPendientesComisionBecas.NOMBRE2.$error.minlength">Mínimo 3 Caracteres.</span>
                                                <span class="text-danger" ng-show="solicitudAcuerdosPendientesComisionBecas.NOMBRE2.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                                            </div> 
                                            <div class="col-md-3">
                                                <input id="APELLIDO1" name="APELLIDO1" type="text" placeholder="Primer Apellido" class="form-control input-md" ng-model="datos.apellido1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                <span class="text-danger" ng-show="solicitudAcuerdosPendientesComisionBecas.APELLIDO1.$error.minlength">Mínimo 3 Caracteres.</span>
                                                <span class="text-danger" ng-show="solicitudAcuerdosPendientesComisionBecas.APELLIDO1.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                                            </div> 
                                            <div class="col-md-3">
                                                <input id="APELLIDO2" name="APELLIDO2" type="text" placeholder="Segundo Apellido" class="form-control input-md" ng-model="datos.apellido2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">
                                                <span class="text-danger" ng-show="solicitudAcuerdosPendientesComisionBecas.APELLIDO2.$error.minlength">Mínimo 3 Caracteres.</span>
                                                <span class="text-danger" ng-show="solicitudAcuerdosPendientesComisionBecas.APELLIDO2.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                                            </div>

                                            </div> 
                                            <div class="col-md-3 text-right">
                            
                                            </div> 
                                        </div>
                                        </div>
                                        <br>
                                       <div class="row">
                                       <div class="col-md-6">   
                                            <label for="textinput">Código de Usuario: </label>  
                                            <input id="CARNET" name="CARNET" type="text" placeholder="Ingrese el Usuario a Buscar" class="form-control input-md" ng-model="datos.codigo" ng-pattern="/^[A-Z0-9]*$/" minlength="7" maxlength="7">
                                            <span class="text-danger" ng-show="solicitudAcuerdosPendientesComisionBecas.CARNET.$error.minlength">Mínimo 7 Caracteres.</span>
                                            <span class="text-danger" ng-show="solicitudAcuerdosPendientesComisionBecas.CARNET.$error.pattern">Solo se Permiten Letras Mayúsculas y Números. (A-Z, 0-9).</span>
                                            <small id="help5"></small>
                                        </div>
                                        <div class="col-md-6 ">
                                       <div class="col-md-6">          
                                            <label for="fIngresoIni">Fecha Solicitud (Inicio) :</label> 
                                            <div class="input-group date">
                                                <input type="text" name="fIngresoIni" id="fIngresoIni" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">      
                                            <label for="fIngresoFin">Fecha de Solicitud (Fin) :</label>
                                            <div class="input-group date">
                                                <input type="text" name="fIngresoFin" id="fIngresoFin" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                    </div>
                                        <br>
                                    
                                   
                                        
                                    </div>
                                    <br>
                                    <div class="row text-center"> 
                                    <input type="submit" class="btn btn-primary" name="submit" value="Buscar" ng-disabled="!solicitudAcuerdosPendientesComisionBecas.$valid">
                                    </div>
                        </fieldset>
                                
                    </div>
                    
                </div>
                </form>     
           <%
                response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
                request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
                String nombre1;
                String nombre2;
                String apellido1;
                String apellido2;
                String carnet;
               // String fecha1;
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                ConexionBD conexionbd = null;
               
                ResultSet rs = null;

                    //formando la consulta
                    
                    //out.write(consultaSql);
                    //realizando la consulta
            try {     
                
            nombre1 = request.getParameter("NOMBRE1");
            nombre2 = request.getParameter("NOMBRE2");
            apellido1 = request.getParameter("APELLIDO1");
            apellido2 = request.getParameter("APELLIDO2");
            carnet = request.getParameter("CARNET");    
            //fecha1 = request.getParameter("FECHA1");
            String consultaSql="";
            String pendiente = "PENDIENTE";
            String comisionB= "COMISION DE BECAS";
            
            
             String fIngresoIni = request.getParameter("fIngresoIni");
            String fIngresoFin = request.getParameter("fIngresoFin");
            if(nombre1!=null) {} else {nombre1="";};
            if(nombre2!=null) {} else {nombre2="";};
            if(apellido1!=null) {} else {apellido1="";};
            if(apellido2!=null) {} else {apellido2="";};
            if(carnet!=null) {} else {carnet="";};
            //if(fecha1!=null) {} else {fecha1="";};
            consultaSql = "SELECT DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, IFNULL(DU.DEPARTAMENTO, ''), F.FACULTAD, D.FECHA_SOLICITUD, TD.TIPO_DOCUMENTO, D.ID_DOCUMENTO, E.ID_EXPEDIENTE, D.ESTADO_DOCUMENTO FROM DETALLE_USUARIO DU JOIN FACULTAD  F ON DU.ID_FACULTAD=F.ID_FACULTAD JOIN USUARIO U ON DU.ID_USUARIO=U.ID_USUARIO JOIN SOLICITUD_DE_BECA SB ON U.ID_USUARIO=SB.ID_USUARIO JOIN EXPEDIENTE  E ON SB.ID_EXPEDIENTE=E.ID_EXPEDIENTE JOIN DOCUMENTO  D ON D.ID_EXPEDIENTE=E.ID_EXPEDIENTE JOIN TIPO_DOCUMENTO  TD ON D.ID_TIPO_DOCUMENTO=TD.ID_TIPO_DOCUMENTO WHERE D.ESTADO_DOCUMENTO IN('"+pendiente+"','REVISION') AND TD.DEPARTAMENTO='"+comisionB+"' AND F.ID_FACULTAD='"+idFacultad+"' AND DU.NOMBRE1_DU LIKE '%" + nombre1 + "%' AND DU.NOMBRE2_DU LIKE '%" + nombre2 + "%' AND DU.APELLIDO1_DU LIKE '%" + apellido1 + "%' AND DU.APELLIDO2_DU LIKE '%" + apellido2 + "%' AND DU.CARNET LIKE '%" + carnet + "%'    ";
            
              if (!fIngresoIni.isEmpty() && !fIngresoFin.isEmpty()) {
                            java.sql.Date sqlFIngresoIni = new java.sql.Date(OfertaServlet.StringAFecha(fIngresoIni).getTime());
                            java.sql.Date sqlFIngresoFin = new java.sql.Date(OfertaServlet.StringAFecha(fIngresoFin).getTime());
                            consultaSql = consultaSql.concat(" AND D.FECHA_SOLICITUD BETWEEN '" + sqlFIngresoIni + "' AND '" + sqlFIngresoFin + "' ");
                        }
            
                   
            
            
            
            conexionbd = new ConexionBD();
            rs = conexionbd.consultaSql(consultaSql);
                    //con el rs se llenara la tabla de resultados
           
            }
            catch (Exception ex){
            }
            
            %>    
                    
                    
                    
                    
                    
                    
                    <br>
                    <div class="col-md-2"></div> 
                   
                    <div class="row">
                        <h5>Resultados</h5>
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <table  id="tablaResultados" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Solicitante</th>
                                        <th>Unidad</th>
                                        <th>Fecha Solicitud</th>
                                        <th>Documento Solicitado</th>
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
                                        out.write("<td>" + rs.getString(5) + " " + rs.getString(6) + "</td>");
                                        out.write("<td>" + rs.getString(7) + "</td>");
                                        out.write("<td>" + rs.getString(8) + "</td>");
                                        out.write("<td>");
                                        out.write("<center>");
                                        if(rs.getString(11).equals("PENDIENTE")){
                                            out.write("<form style='display:inline;' action='408_Comision_Becas_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(9) + "'><input type='hidden' name='ID_EXPEDIENTE' value='" + rs.getString(10) + "' ><input type='hidden' name='ACCION' value='insertar'><input type='submit' class='btn btn-success' name='submit' value='Resolver'></form> ");
                                        }else{
                                            out.write("<form style='display:inline;' action='408_Comision_Becas_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(9) + "'><input type='hidden' name='ID_EXPEDIENTE' value='" + rs.getString(10) + "' ><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-success' name='submit' value='Resolver'></form> ");
                                        }                                         
                                        out.write("</center>");
                                        out.write("</td>");
                                        out.write("</tr>");
                                    }
                                }catch (Exception ex) {
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
        <script src="js/scripts.js"></script>
        <script src="js/solicitudAcuerdosPendientesComisionBecas.js"></script>
        <script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
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
    
                                           $(function () {
        $('#fIngresoIni').datepicker({
            format: 'yyyy-mm-dd',
            calendarWeeks: true,
            todayHighlight: true,
            autoclose: true,
            endDate: '-0y'
        }).on('change.dp', function (e) {
            $('#fIngresoFin').datepicker('setStartDate', new Date($(this).val()));
        });
        $('#fIngresoFin').datepicker({
            format: 'yyyy-mm-dd',
            calendarWeeks: true,
            todayHighlight: true,
            autoclose: true,
            endDate: '-0y'
        }).on('change.dp', function (e) {
            $('#fIngresoIni').datepicker('setEndDate', new Date($(this).val()));
        });
        $('#fCierreIni').datepicker({
            format: 'yyyy-mm-dd',
            calendarWeeks: true,
            todayHighlight: true,
            autoclose: true
        }).on('change.dp', function (e) {
            $('#fCierreFin').datepicker('setStartDate', new Date($(this).val()));
        });
        $('#fCierreFin').datepicker({
            format: 'yyyy-mm-dd',
            calendarWeeks: true,
            todayHighlight: true,
            autoclose: true,
            startDate: new Date()
        }).on('change.dp', function (e) {
            $('#fCierreIni').datepicker('setEndDate', new Date($(this).val()));
        });
    });
    
</script>
</body>
</html>

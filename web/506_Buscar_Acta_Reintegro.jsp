<%-- 
    Document   : 506_Buscar_Acta_Reintegro
    Created on : 28/10/2016, 03:46:00 PM
    Author     : adminPC
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Facultad"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    //lineas para tildes
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
        
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String rol = (String) actual.getAttribute("rol");
    String user = (String) actual.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
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
        <link href="css/menuSolicitudBeca.css" rel="stylesheet">    
        <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker3.min.css" />
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

        <p class="text-right" style="font-weight:bold;">Rol: <%= rol %></p>
        <p class="text-right" style="font-weight:bold;">Usuario: <%= user %></p>

        <%-- todo el menu esta contenido en la siguiente linea
        el menu puede ser cambiado en la pagina menu.jsp --%>
        <jsp:include page="menu_corto.jsp"></jsp:include>    
</head>
<body ng-app="solicitudReintegroBecaApp" ng-controller="solicitudReintegroBecaCtrl">

    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Buscar Acta de Reintegro de Beca</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Actas</legend>
                     <form name="solicitudReintegroBeca" class="form-horizontal" action="506_Buscar_Acta_Reintegro.jsp" method="post" novalidate>
   
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
                                                            <input id="NOMBRE1" name="NOMBRE1" type="text" placeholder="Primer nombre" class="form-control input-md" ng-model="datos.nombre1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                            <span class="text-danger" ng-show="solicitudReintegroBeca.NOMBRE1.$error.minlength">Minimo 3 caracteres.</span>
                                                            <span class="text-danger" ng-show="solicitudReintegroBeca.NOMBRE1.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>

                                                        </div>
                                            
                                                        <div class="col-md-3">    
                                                            <input id="NOMBRE2" name="NOMBRE2" type="text" placeholder="Segundo nombre" class="form-control input-md" ng-model="datos.nombre2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                            <span class="text-danger" ng-show="solicitudReintegroBeca.NOMBRE2.$error.minlength">Minimo 3 caracteres.</span>
                                                            <span class="text-danger" ng-show="solicitudReintegroBeca.NOMBRE2.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                                                        </div> 
                                                        <div class="col-md-3">
                                                            <input id="APELLIDO1" name="APELLIDO1" type="text" placeholder="Primer apellido" class="form-control input-md" ng-model="datos.apellido1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                            <span class="text-danger" ng-show="solicitudReintegroBeca.APELLIDO1.$error.minlength">Minimo 3 caracteres.</span>
                                                            <span class="text-danger" ng-show="solicitudReintegroBeca.APELLIDO1.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                                                        </div> 
                                                        <div class="col-md-3">
                                                            <input id="APELLIDO2" name="APELLIDO2" type="text" placeholder="Segundo apellido" class="form-control input-md" ng-model="datos.apellido2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">
                                                            <span class="text-danger" ng-show="solicitudReintegroBeca.APELLIDO2.$error.minlength">Minimo 3 caracteres.</span>
                                                            <span class="text-danger" ng-show="solicitudReintegroBeca.APELLIDO2.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                                                        </div>

                                                    </div> 
                                                    <div class="col-md-3 text-right"></div> 
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-md-6">   
                                                    <label for="textinput">Codigo de Usuario: </label>  
                                                    <input id="CARNET" name="CARNET" type="text" placeholder="Ingrese el usuario a buscar" class="form-control input-md" ng-model="datos.codigo" ng-pattern="/^[A-Z0-9]*$/" minlength="7" maxlength="7">
                                                    <span class="text-danger" ng-show="solicitudReintegroBeca.CARNET.$error.minlength">Minimo 7 caracteres.</span>
                                                    <span class="text-danger" ng-show="solicitudReintegroBeca.CARNET.$error.pattern">Solo se permiten letras mayusculas y numeros. (A-Z, 0-9).</span>
                                                    <small id="help5"></small>
                                                </div>
                                        
                                                <div class="col-md-6">   
                                                    <label for="textinput">Expediente :</label>  
                                                         <input id="ID_EXPEDIENTE" name="ID_EXPEDIENTE" type="text" placeholder="Ingrese número de expediente a buscar" class="form-control input-md" ng-model="datos.idexpediente" ng-pattern="/^[0-9]*$/" minlength="1" maxlength="4">
                                                            <span class="text-danger" ng-show="solicitudReintegroBeca.ID_EXPEDIENTE.$error.minlength">Minimo 1 caracteres.</span>
                                                            <span class="text-danger" ng-show="solicitudReintegroBeca.ID_EXPEDIENTE.$error.pattern">Solo se permiten numeros. (0-9).</span>
                                
                                                </div>
                                                                         
                                            </div>
                                            <br>
                                            <div class="row">
                                                 <div class="col-md-6 ">
                                       <div class="col-md-6">          
                                            <label for="fIngresoIni">Fecha Solicitud (inicio) :</label> 
                                            <div class="input-group date">
                                                <input type="text" name="fIngresoIni" id="fIngresoIni" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">      
                                            <label for="fIngresoFin">Fecha de Solicitud  (fin) :</label>
                                            <div class="input-group date">
                                                <input type="text" name="fIngresoFin" id="fIngresoFin" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                    </div>
                                                <div class="col-md-6">
                                                    <label for="textinput">Facultad: </label>
                                                        <select id="selectbasic" name="ID_FACULTAD" class="form-control">
                                                            <option value="0">SELECCIONE FACULTAD</option>    
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
                                            <div class="row text-center"> 
                                                <input type="submit" class="btn btn-primary" name="submit" value="Buscar" ng-disabled="!solicitudReintegroBeca.$valid">
                                            </div>
                                        </fieldset>
                                
                                    </div>
                    
                                </div>
                            </form>                                    
                     <%
              //  response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
              //  request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
                String nombre1;
                String nombre2;
                String apellido1;
                String apellido2;
                String carnet;
                String expediente;
                Integer id_facultad;
                String fecha1;
                
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
            expediente = request.getParameter("ID_EXPEDIENTE");
            id_facultad = Integer.parseInt(request.getParameter("ID_FACULTAD"));
            fecha1 = request.getParameter("FECHA1");
            
            String documento= "159";
            String consultaSql="";
            
            if(nombre1!=null) {} else {nombre1="";};
            if(nombre2!=null) {} else {nombre2="";};
            if(apellido1!=null) {} else {apellido1="";};
            if(apellido2!=null) {} else {apellido2="";};
            if(carnet!=null) {} else {carnet="";};
            if(fecha1!=null) {} else {fecha1="";};
            if(expediente!=null) {} else {expediente="";};
            
          consultaSql ="SELECT DU.CARNET, DU.NOMBRE1_DU, DU.NOMBRE2_DU,  DU.APELLIDO1_DU,  DU.APELLIDO2_DU, DU.DEPARTAMENTO, F.FACULTAD ,D.FECHA_INGRESO, E.ID_EXPEDIENTE, D.ID_DOCUMENTO, E.ID_PROGRESO, E.ESTADO_PROGRESO FROM EXPEDIENTE E JOIN SOLICITUD_DE_BECA SB ON E.ID_EXPEDIENTE = SB.ID_EXPEDIENTE JOIN USUARIO U ON SB.ID_USUARIO = U.ID_USUARIO JOIN DETALLE_USUARIO DU ON U.ID_USUARIO = DU.ID_USUARIO JOIN FACULTAD F ON DU.ID_FACULTAD = F.ID_FACULTAD JOIN DOCUMENTO  D ON D.ID_EXPEDIENTE=E.ID_EXPEDIENTE JOIN TIPO_DOCUMENTO  TD ON D.ID_TIPO_DOCUMENTO=TD.ID_TIPO_DOCUMENTO WHERE TD.ID_TIPO_DOCUMENTO = '"+documento+"' AND DU.NOMBRE1_DU LIKE '%"+nombre1+"%' AND DU.NOMBRE2_DU LIKE '%"+nombre2+"%' AND DU.APELLIDO1_DU LIKE '%" + apellido1 + "%' AND DU.APELLIDO2_DU LIKE '%" + apellido2 + "%' AND DU.CARNET LIKE '%" + carnet + "%' AND E.ID_EXPEDIENTE LIKE '%" + expediente + "%' AND SB.FECHA_SOLICITUD LIKE '%" + fecha1 + "%'  ";
            //PRUEBA   out.write(consultaSql);
          
          if (id_facultad == 0) 
          {

          } else {
                        consultaSql = consultaSql.concat(" AND DU.ID_FACULTAD = " + id_facultad);
                 }   
            
           
           
            
            conexionbd = new ConexionBD();
            rs = conexionbd.consultaSql(consultaSql);
                    //con el rs se llenara la tabla de resultados
           
            }
            catch (Exception ex){
            }
            
            %>                                        
                                                        
                    <div class="row">
                        <h5>Resultados</h5>
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <table  id="tablaResultados" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Código Empleado</th>
                                        <th>Becario</th>
                                        <th>Unidad</th>
                                        <th>Expediente</th>
                                        <th>Fecha de Firma</th>
                                        <th>Acción</th>
                                    </tr>  
                                </thead>
                                <tbody>
                                   <%
                                try {
                                    Integer i = 0;
                                    int idProgreso =0;
                                    String estadoProgreso = "";
                                    while (rs.next()) {
                                        i = i + 1;
                                        out.write("<tr>");
                                        out.write("<td>" + i + "</td>");
                                        out.write("<td>" + rs.getString(1) + "</td>");
                                        out.write("<td>" + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4) + " " + rs.getString(5) + "</td>");
                                        out.write("<td>" + rs.getString(6) + " " + rs.getString(7) + "</td>");
                                        out.write("<td>" + rs.getString(9) + "</td>");
                                        out.write("<td>" + rs.getString(8) + "</td>");
                                        
                                        out.write("<td>");
                                        out.write("<center>");
                                        idProgreso = rs.getInt(11);
                                            estadoProgreso = rs.getString(12);
                                            if (idProgreso == 4) {
                                                if (estadoProgreso.equals("PENDIENTE") || estadoProgreso.equals("CORRECCION")) {
                                                    //EDITAR                                                                
                                                    out.write("<form style='display:inline;' action='504_Resolver_Solicitudes_Reintegro_Beca.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(10) + "' ><input type='hidden' name='ID_EXPEDIENTE' value='" + rs.getString(9) + "' ><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                    //VER DOCUMENTO
                                                    out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(10) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");
                                                } else {
                                                    out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(10) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");
                                                }
                                            } else {
                                                // no se puede editar
                                                //VER DOCUMENTO
                                                out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(11) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");
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
                        <div class="col-md-1"></div>
                    </div>
        </fieldset>
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
        <script src="js/solicitudReintegroBeca.js"></script>
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
            autoclose: true
        }).on('change.dp', function (e) {
            $('#fIngresoFin').datepicker('setStartDate', new Date($(this).val()));
        });
        $('#fIngresoFin').datepicker({
            format: 'yyyy-mm-dd',
            calendarWeeks: true,
            todayHighlight: true,
            autoclose: true
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

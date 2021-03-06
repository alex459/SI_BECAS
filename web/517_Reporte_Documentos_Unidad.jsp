<%-- 
    Document   : 517_Reporte_Documentos_Unidad
    Created on : 30/10/2016, 04:08:21 PM
    Author     : adminPC
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="MODEL.AgregarOfertaBecaServlet"%>
<%@page import="POJO.Facultad"%>
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");

    HttpSession actual = request.getSession();
    String rol = (String) actual.getAttribute("rol");
    String user = (String) actual.getAttribute("user");
    Integer tipo_usuario_logeado = (Integer) actual.getAttribute("id_tipo_usuario");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ArrayList<String> tipo_usuarios_permitidos = new ArrayList<String>();
    //AGREGAR SOLO LOS ID DE LOS USUARIOS AUTORIZADOS PARA ESTA PANTALLA------
    tipo_usuarios_permitidos.add("7");
    tipo_usuarios_permitidos.add("8");
    tipo_usuarios_permitidos.add("9");
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    Facultad facultad1 = new Facultad();
    AgregarOfertaBecaServlet OfertaServlet = new AgregarOfertaBecaServlet();
%>

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
    

<p class="text-right">Rol: <%= rol%></p>
    <p class="text-right">Usuario: <%= user%></p>

    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>   
</head>



<body>

    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Reporte de Documentos Emitidos por Unidad</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Reporte de Documentos Emitidos por Unidad</legend>
                    
                    <div class="row">            
                        <div class="col-md-9">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Filtros</legend>
                                <h5 style="color:#E42217">Ingrese los Fitros de Busqueda del Reporte</h5>
                                <form class="form-horizontal" action="517_Reporte_Documentos_Unidad.jsp" method="post">
                                   <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Unidad:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select name="unidad" id="unidad" class="form-control">
                                                    <option value="">Seleccione la Unidad</option>
                                                    <option value="COMISION DE BECAS">Comisión de Becas</option>
                                                    <option value="JUNTA DIRECTIVA">Junta Directiva</option>
                                                    <option value="CONSEJO SUPERIOR UNIVERSITARIO">Consejo Superior Universitario</option>
                                                    <option value="FISCALIA">Fiscalía</option>
                                                    <option value="CONSEJO DE BECAS">Consejo de Becas</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6 ">
                                        <div class="col-md-6">          
                                            <label for="fIngresoIni">Fecha de Emisión (inicio) :</label> 
                                            <div class="input-group date">
                                                <input type="text" name="fIngresoIni" id="fIngresoIni" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">      
                                            <label for="fIngresoFin">Fecha de Emisión (fin) :</label>
                                            <div class="input-group date">
                                                <input type="text" name="fIngresoFin" id="fIngresoFin" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Facultad:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select id="facultad" name="facultad" class="form-control">
                                            <%
                                                FacultadDAO facDao = new FacultadDAO();
                                                ArrayList<Facultad> lista = facDao.consultarTodos();
                                            %><option value="" selected>Seleccione una facultad</option><%
                                                for (int i = 0; i < lista.size(); i++) {%>
                                            <option value="<%=lista.get(i).getFacultad() %>"> <%=lista.get(i).getFacultad() %></option>
                                            <%   }
                                            %>    
                                        </select>   
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Tipo de Beca:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                 <select name="tipoBeca" id="tipoBeca"  class="form-control">
                                                    <option value="">Seleccione Tipo de Beca</option>
                                                    <option value="EXTERNA">Externa</option>
                                                    <option value="INTERNA">Interna</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Tipo de Solicitante:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select name="tipoBecario" id="tipoBecario" class="form-control">
                                                    <option value="">Seleccione Tipo de Solicitante</option>
                                                    <option value="CANDIDATO">Candidato</option>
                                                    <option value="ACTIVO"> Becario Activo</option>
                                                    <option value="CONTRACTUAL">Becario Contractual</option>
                                                    <option value="INACTIVO"> Becario Inactivo</option>
                                                    <option value="LIBERADO">Becario Liberado</option>
                                                    <option value="INCUMPLIMIENTO DE CONTRATO">Becario en Incumplimiento de Contrato</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="row">
                                       
                                            <div class="col-md-12 text-center">
                                                <br>
                                                <input type="submit" class="btn btn-primary" name="submit" value="Buscar"> 
                                            </div>
                                        </div>
                                    </div>

                                </form>
                            </fieldset>
                        </div>
            <%
                String unidad;
                String facultad;
                String tipoBeca;
                String tipoBecario;
                            
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                ConexionBD conexionbd = null;
               
                ResultSet rs = null;   
                String consultaSql2 = ""; 
                try{
                    
                    String queryParam=""; 
                     
                    String consultaSql="";
                    String fIngresoIni = request.getParameter("fIngresoIni");
                    String fIngresoFin = request.getParameter("fIngresoFin");
                
                    consultaSql = "SELECT 	TD.DEPARTAMENTO AS Unidad, TD.TIPO_DOCUMENTO AS 'Tipo de documento', D.FECHA_INGRESO AS 'fecha de emisión', "
                                + "CONCAT(DU.NOMBRE1_DU,' ', DU.NOMBRE2_DU,' ', DU.APELLIDO1_DU,' ', DU.APELLIDO2_DU) AS Solicitante, "
                                + "F.FACULTAD AS Facultad,  P.ESTADO_BECARIO AS 'Tipo de Becario', D.OBSERVACION_O AS Obserbaciones, D.ID_DOCUMENTO "
                                + "FROM DOCUMENTO D "
                                + "JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO "
                                + "JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE "
                                + "JOIN SOLICITUD_DE_BECA SB ON SB.ID_EXPEDIENTE = E.ID_EXPEDIENTE "
                                + "JOIN USUARIO U ON SB.ID_USUARIO = U.ID_USUARIO "
                                + "JOIN DETALLE_USUARIO DU ON DU.ID_USUARIO = U.ID_USUARIO "
                                + "JOIN FACULTAD F ON DU.ID_FACULTAD = F.ID_FACULTAD "
                                + "JOIN PROGRESO P ON E.ID_PROGRESO = P.ID_PROGRESO "
                                + "JOIN OFERTA_BECA OB ON SB.ID_OFERTA_BECA = OB.ID_OFERTA_BECA "
                                + "WHERE D.ESTADO_DOCUMENTO = 'APROBADO' AND TD.DEPARTAMENTO IN('COMISION DE BECAS','JUNTA DIRECTIVA', "
                                + "'CONSEJO DE BECAS','CONSEJO SUPERIOR UNIVERSITARIO','FISCALIA') ";
                             
                              
                    if (request.getParameter("unidad").toString().length()>0) {
                            unidad = request.getParameter("unidad");
                            consultaSql2 = consultaSql2.concat(" AND TD.DEPARTAMENTO='" + unidad + "' ");
                        }           
                               
                    if (request.getParameter("facultad").toString().length()>0) {
                           
                            facultad = request.getParameter("facultad");
                            consultaSql2 = consultaSql2.concat(" AND F.FACULTAD='" + facultad + "' ");
                        }           
                               
                               
                     if (!request.getParameter("tipoBeca").isEmpty()) {
                            tipoBeca = request.getParameter("tipoBeca");
                            consultaSql2 = consultaSql2.concat(" AND OB.TIPO_OFERTA_BECA='" + tipoBeca + "' ");
                        }           
                               
                    if (!request.getParameter("tipoBecario").isEmpty()) {
                            tipoBecario = request.getParameter("tipoBecario");
                            consultaSql2 = consultaSql2.concat(" AND P.ESTADO_BECARIO='" + tipoBecario + "' ");
                        }          
                    if (!fIngresoIni.isEmpty() && !fIngresoFin.isEmpty()) {
                        java.sql.Date sqlFIngresoIni = new java.sql.Date(OfertaServlet.StringAFecha(fIngresoIni).getTime());
                        java.sql.Date sqlFIngresoFin = new java.sql.Date(OfertaServlet.StringAFecha(fIngresoFin).getTime());
                        consultaSql2 = consultaSql2.concat(" AND D.FECHA_INGRESO BETWEEN '" + sqlFIngresoIni + "' AND '" + sqlFIngresoFin + "' ");
                    }           
                               
                    
                    
                consultaSql = consultaSql.concat(consultaSql2);
                consultaSql = consultaSql.concat(";");
                   
                conexionbd = new ConexionBD();
                rs = conexionbd.consultaSql(consultaSql);
                
                }
                catch(Exception ex){
                    System.out.println(ex);
                }       
                            
                            %>
                        <div class="col-md-3 text-center">
                    <fieldset class="custom-border">
                        <legend class="custom-border">Acciones</legend>
                            <br>
                            <div class="col-md-6 text-center">
                                <label>PDF</label>
                                    <form class="form-horizontal" action="ReporteDocumentosUnidadServlet" method="post">
                                        <input type="hidden" name="OPCION_DE_SALIDA" value="1">
                                    <input type="hidden" name="CONDICION" value="<%=consultaSql2 %>">                                    
                                     <input type="submit" class="btn btn-primary" name="submit" value=" " style="background-image: url(img/106_icono_de_pdf.png); background-repeat: no-repeat; background-size: 100%; background-size: 25px 25px;">
                               
                                </form>
                                 <br>       
                           
                        </div>
                        <div class="col-md-6">
                            <label>Hoja de Cálculo</label>
                            <div style="border:1px solid; background-color: #32B232; padding:6px; color:white; " id="buttons"></div>
                            <br>
                        </div>           
                    </fieldset>
                        </div>
                    </div>


                   <div class="row">
                       <fieldset class="custom-border">
                        <h5>Resultados de la busqueda</h5>
                        <div class="col-md-12">
                            <table id="tablaInstituciones" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Unidad</th>
                                        <th>Tipo de Documento</th>
                                        <th>Fecha de Emisión</th>
                                        <th>Solicitante</th>
                                        <th>Facultad</th>
                                        <th>Tipo de Solicitante</th>
                                        <th>Observaciones</th>
                                        <th>Ver Documento</th>
                                        
                                    </tr>  
                                </thead>
                                <tbody>
                                    <%
                                        try {
                                            Integer i = 0;
                                            String progreso = "";
                                            while (rs.next()) {
                                                i = i + 1;
                                                out.write("<tr>");
                                                out.write("<td>" + i + "</td>");
                                                out.write("<td>" + rs.getString(1) + "</td>");
                                                out.write("<td>" + rs.getString(2) + "</td>");
                                                out.write("<td>" + rs.getString(3) + "</td>");
                                                out.write("<td>" + rs.getString(4) + "</td>");
                                                out.write("<td>" + rs.getString(5) + "</td>");
                                                out.write("<td>" + rs.getString(6) + "</td>");
                                                out.write("<td>" + rs.getString(7) + "</td>");
                                                out.write("<td>");
                                                out.write("<center>");
                                                
                                                    out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(8) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");                                                            
                                                    
                                                out.write("</center>");
                                                out.write("</td>");
                                                
                                                
                                            }
                                        }
                                        catch (Exception ex){
                                            System.out.println("error: " + ex);
                                        }
                                        
                                        %>
                                </tbody>
                            </table>
                        </div>
                                </fieldset>
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
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/dataTables.bootstrap.min.js.js"></script>
<script type="text/javascript" src="js/buttons.html5.min.js"></script>
<script type="text/javascript" src="js/buttons.print.min.js"></script>
<script type="text/javascript" src="js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
    var tabla=$('#tablaInstituciones').DataTable(
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
        var buttons = new $.fn.dataTable.Buttons(tabla, {
     buttons: [      
        'csv', 'excel'
    ]
}).container().appendTo($('#buttons'));
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

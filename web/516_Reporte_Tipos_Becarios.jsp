<%-- 
    Document   : 516_Reporte_Tipos_Becarios
    Created on : 30/10/2016, 04:07:16 PM
    Author     : adminPC
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="POJO.Progreso"%>
<%@page import="POJO.DetalleUsuario"%>
<%@page import="POJO.OfertaBeca"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.InstitucionDAO"%>
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
<p class="text-right">Rol: <%= rol%></p>
    <p class="text-right">Usuario: <%= user%></p>

    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>   
</head>



<body>

    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Reporte por Tipo de Becarios</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Reporte por Tipo de Becarios</legend>
                    
                    <div class="row">            
                        <div class="col-md-9">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Filtros</legend>
                                <h5 style="color:#E42217">Ingrese los Fitros de Busqueda del Reporte</h5>
                                <form class="form-horizontal" action="516_Reporte_Tipos_Becarios.jsp" method="post">
                                     <div class="row">
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
                                        <div class="col-md-6 ">
                                        <div class="col-md-6">          
                                            <label for="fIngresoIni">Fecha de ingreso (inicio) :</label> 
                                            <div class="input-group date">
                                                <input type="text" name="fIngresoIni" id="fIngresoIni" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">      
                                            <label for="fIngresoFin">Fecha de ingreso (fin) :</label>
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
                                        <div class="col-md-6 ">
                                        <div class="col-md-6">          
                                            <label for="fCierreIni">Fecha de cierre (inicio) :</label> 
                                            <div class="input-group date">
                                                <input type="text" name="fCierreIni" id="fCierreIni" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">      
                                            <label for="fCierreFin">Fecha de cierre (fin) :</label>
                                            <div class="input-group date">
                                                <input type="text" name="fCierreFin" id="fCierreFin" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Tipo de Becario:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select name="tipoBecario" id="tipoBecario" class="form-control">
                                                    <option value="">Seleccione Tipo de Becario</option>
                                                    <option value="ACTIVO">Activo</option>
                                                    <option value="CONTRACTUAL">Contractual</option>
                                                    <option value="INACTIVO">Inactivo</option>
                                                    <option value="LIBERADO">Liberado</option>
                                                    <option value="INCUMPLIMIENTO">Incumplimiento de Contrato</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Institucion Financiera:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                 <select id="institucionOferente" name="institucionOferente" class="form-control">
                                            <%
                                                InstitucionDAO institucionDAO = new InstitucionDAO();
                                                ArrayList<Institucion> listaInstitucion = new ArrayList();
                                                listaInstitucion = institucionDAO.consultarActivosPorTipo("OFERTANTE");
                                            %><option value="" selected>Seleccione una institución</option><%
                                                for (int i = 0; i < listaInstitucion.size(); i++) {%>
                                            <option value="<%=listaInstitucion.get(i).getNombreInstitucion()%>"> <%=listaInstitucion.get(i).getNombreInstitucion()%></option>
                                            <%   }
                                            %>    
                                        </select>     
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Tipo de Estudio Realizado:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select  name="tipoEstudio" id="tipoEstudio" class="form-control">
                                                    <option value="">Seleccione Tipo de Estudio</option>
                                                    <option value="MAESTRIA">Maestria</option>
                                                    <option value="DOCTORADO">Doctorado</option>
                                                    <option value="ESPECIALIZACION">Especializacion</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-center">
                                            <br>
                                             <input type="submit" class="btn btn-primary" name="submit" value="Buscar"> 
                                        </div>
                                    </div>

                                </form>
                            </fieldset>
                        </div>

                    <%
                          String tipoBeca; 
                          String facultad; 
                          String institucionOferente;
                          String tipoEstudio;
                          String tipoBecario;
                          
                          ConexionBD conexionbd = null;
               
                          ResultSet rs = null;  
                           String queryParam=""; 
                    
                        ArrayList<OfertaBeca> lista2 = new ArrayList();
                    ArrayList<Institucion> listaIns = new ArrayList();
                    ArrayList<DetalleUsuario> listaUser = new ArrayList();
                    ArrayList<Progreso> listaProg = new ArrayList();
                    ArrayList<Facultad> listaFacultades = new ArrayList();
                    ArrayList<String> SegBeca = new ArrayList();
                    ArrayList<String> TomaPos = new ArrayList();
                    OfertaBeca temp = new OfertaBeca();
                    Institucion temp2 = new Institucion();
                    DetalleUsuario temp3 = new DetalleUsuario();
                    Progreso temp4 = new Progreso();
                    Facultad temp6 = new Facultad();
                    String tempSegBec="";
                    String temptomaPos="";
                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                           
                            String consultaSql2 = "";    

                          try {
                              
                                String fIngresoIni = request.getParameter("fIngresoIni");
                                String fIngresoFin = request.getParameter("fIngresoFin");
                                String fCierreIni = request.getParameter("fCierreIni");
                                String fCierreFin = request.getParameter("fCierreFin");  
                                
                                
                                
                              String consultaSql="";
                               
        consultaSql = "SELECT DISTINCT "
                + " SB.ID_EXPEDIENTE,CONCAT(DU.NOMBRE1_DU,' ', DU.NOMBRE2_DU,' ', DU.APELLIDO1_DU,' ', DU.APELLIDO2_DU) AS NOMBRE, "
                + " OF.FECHA_CIERRE, OF.TIPO_ESTUDIO,"
                + " OF.TIPO_OFERTA_BECA, OF.FECHA_INICIO, OF.NOMBRE_OFERTA,I.NOMBRE_INSTITUCION, I.PAIS,F.FACULTAD, P.ESTADO_BECARIO "
                + " ,P.ID_PROGRESO, "
                + "  (CASE WHEN (SELECT COUNT(EX.ID_EXPEDIENTE) FROM EXPEDIENTE EX,USUARIO USU, SOLICITUD_DE_BECA SDB "
							+ "WHERE EX.ID_EXPEDIENTE=SDB.ID_EXPEDIENTE "
							+ "AND USU.ID_USUARIO=SDB.ID_USUARIO "
							+ "AND USU.ID_USUARIO=U.ID_USUARIO "
							+ ")>= 2 THEN 'SI' "
							+ "ELSE 'NO' "
							+ "END) AS 'SegundaBeca', "
	+ "( CASE WHEN P.ID_PROGRESO IN ( SELECT P.ID_PROGRESO FROM PROGRESO P "
							+ "WHERE P.ID_PROGRESO >= 9 ) THEN "
							+ "'SI' "
							+ "ELSE 'NO' "
							+ "END) AS 'ContratoFirmado', "
	+ "( CASE WHEN P.ID_PROGRESO IN ( SELECT P.ID_PROGRESO FROM PROGRESO P "
							+ "WHERE P.ID_PROGRESO >=12  ) THEN "
							+ "'SI' "
							+ "ELSE 'NO' "
							+ "END) AS 'TomaPosesion' "
                + " FROM FACULTAD F,DETALLE_USUARIO DU , USUARIO U, TIPO_USUARIO TU , SOLICITUD_DE_BECA SB, OFERTA_BECA OF,"
                + " INSTITUCION I ,EXPEDIENTE E, PROGRESO P WHERE DU.ID_FACULTAD=F.ID_FACULTAD AND DU.ID_USUARIO=U.ID_USUARIO"
                + " AND U.ID_USUARIO=SB.ID_USUARIO AND SB.ID_OFERTA_BECA=OF.ID_OFERTA_BECA AND SB.ID_EXPEDIENTE=E.ID_EXPEDIENTE"
                + " AND P.ID_PROGRESO=E.ID_PROGRESO AND OF.ID_INSTITUCION_FINANCIERA=I.ID_INSTITUCION AND U.ID_TIPO_USUARIO = 2 "
                + " AND E.ESTADO_EXPEDIENTE='ABIERTO' ";
                              
                        if (request.getParameter("tipoBeca").toString().length()>0) {
                            tipoBeca = request.getParameter("tipoBeca");
                            consultaSql2 = consultaSql2.concat(" AND OF.TIPO_OFERTA_BECA='" + tipoBeca + "' ");
                        }           
                               
                        if (request.getParameter("tipoEstudio").toString().length()>0) {
                           
                            tipoEstudio = request.getParameter("tipoEstudio");
                            consultaSql2 = consultaSql2.concat(" AND OF.TIPO_ESTUDIO='" + tipoEstudio + "' ");
                        }           
                               
                               
                        if (!request.getParameter("tipoBecario").isEmpty()) {
                            tipoBecario = request.getParameter("tipoBecario");
                            consultaSql2 = consultaSql2.concat(" AND P.ESTADO_BECARIO='" + tipoBecario + "' ");
                        }                 
                              
                        if (!request.getParameter("facultad").isEmpty()) {
                            facultad = request.getParameter("facultad");
                            consultaSql2 = consultaSql2.concat(" AND F.FACULDAD='" + facultad + "' ");
                        }  
                              
                       if (!request.getParameter("institucionOferente").isEmpty()) {
                            institucionOferente = request.getParameter("institucionOferente");
                            consultaSql2 = consultaSql2.concat(" AND I.NOMBRE_INSTITUCION='" + institucionOferente + "' ");
                        }  
                              
                              
                              consultaSql = consultaSql.concat(consultaSql2);
                                consultaSql = consultaSql.concat(";");
                              
                              conexionbd = new ConexionBD();
                               rs = conexionbd.consultaSql(consultaSql);
                           while (rs.next()) {
                            temp = new OfertaBeca();
                            temp2 = new Institucion();
                            temp3 = new DetalleUsuario();
                            temp4 = new Progreso();
                            temp6 = new Facultad();

                            temp.setTipoOfertaBeca(rs.getString("TIPO_OFERTA_BECA"));
                            temp.setFechaInicio(rs.getDate("FECHA_INICIO"));
                            temp.setNombreOferta(rs.getString("NOMBRE_OFERTA"));
                            temp.setFechaCierre(rs.getDate("FECHA_CIERRE"));
                            temp.setTipoEstudio(rs.getString("TIPO_ESTUDIO"));
                            temp2.setPais(rs.getString("PAIS"));
                            temp2.setNombreInstitucion(rs.getString("NOMBRE_INSTITUCION"));
                            temp3.setNombre1Du(rs.getString("NOMBRE"));
                            temp4.setIdProgreso(rs.getInt("ID_PROGRESO"));
                            temp4.setEstadoBecario(rs.getString("ESTADO_BECARIO"));
                            temp6.setFacultad(rs.getString("FACULTAD"));   
                            //segunda beca y toma de posesion
                            tempSegBec=rs.getString("SegundaBeca");
                            temptomaPos=rs.getString("TomaPosesion");

                            lista2.add(temp);
                            listaIns.add(temp2);
                            listaUser.add(temp3);
                            listaProg.add(temp4);
                            listaFacultades.add(temp6);
                            SegBeca.add(tempSegBec);
                            TomaPos.add(temptomaPos);
                        }
                          
                          }
                         catch(Exception ex){
                    
                         }



                        %>

                        <div class="col-md-3 text-center">
                           <fieldset class="custom-border">
                        <legend class="custom-border">Acciones</legend>
                            <br>
                            <div class="col-md-6 text-center">
                                <label>PDF</label>
                                <form class="form-horizontal" action="ReporteTipoBecariosServlet" method="post">
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
                            <table  id="tablaResultados" class="table text-center">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Nombre</th>
                                        <th>2a. Beca</th> 
                                        <th>Tipo de Beca</th>
                                        <th>Fecha de Inicio de Beca</th>
                                        <th>Fecha de Finalizacion de Beca</th>
                                        <th>Pais</th>
                                        <th>Estudio Realizado</th>
                                        <th>Institucion que Financia</th>
                                        <th>Toma de Posesión</th> 
                                        <th>Facultad</th>
                                        <th>Tipo Becario</th>
                                    </tr>  
                                </thead>
                                <tbody>
                                     <%
                                            if (lista2.size() >= 0) {
                                    int i = 0;
                                    while (i < lista2.size()) {
                                                out.write("<tr>");
                                                out.write("<td>" + i+1 + "</td>");
                                                out.write("<td>" + listaUser.get(i).getNombre1Du() + "</td>");
                                                out.write("<td>" + SegBeca.get(i) + "</td>");
                                                out.write("<td>" + lista2.get(i).getTipoOfertaBeca() + "</td>");
                                                out.write("<td>" + df.format(lista2.get(i).getFechaInicio()) + "</td>");
                                                out.write("<td>" + df.format(lista2.get(i).getFechaCierre()) + "</td>");
                                                out.write("<td>" + listaIns.get(i).getPais() + "</td>");
                                                out.write("<td>" + lista2.get(i).getTipoEstudio() + "</td>");
                                                out.write("<td>" + listaIns.get(i).getNombreInstitucion() + "</td>");
                                                out.write("<td>" + TomaPos.get(i) + "</td>");
                                                out.write("<td>" + listaFacultades.get(i).getFacultad() + "</td>");
                                                out.write("<td>" + listaProg.get(i).getEstadoBecario() + "</td>");
                                                 i++;
                                            }
                                        }
                                        %>
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                                        </fieldset>
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
<script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="js/buttons.html5.min.js"></script>
<script type="text/javascript" src="js/buttons.print.min.js"></script>
<script type="text/javascript" src="js/dataTables.buttons.min.js"></script>
<script type="text/javascript">
     $(document).ready(function() {
    var tabla= $('#tablaResultados').DataTable(
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

<%-- 
    Document   : 513_Reporte_Candidatos
    Created on : 30/10/2016, 04:04:46 PM
    Author     : adminPC
--%>

<%@page import="MODEL.AgregarOfertaBecaServlet"%>
<%@page import="POJO.SolicitudDeBeca"%>
<%@page import="POJO.Progreso"%>
<%@page import="POJO.DetalleUsuario"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="POJO.OfertaBeca"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="DAO.FacultadDAO"%>
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
            <H3 class="text-center" style="color:#E42217;">Reporte de Candidatos a Beca</H3>
            <fieldset class="custom-border">
                <legend class="custom-border">Reporte de Candidatos a Beca</legend>

                <div class="row">            
                    <div class="col-md-9">
                        <fieldset class="custom-border">
                            <legend class="custom-border">Filtros</legend>
                            <h5 style="color:#E42217">Ingrese los Fitros de Busqueda del Reporte</h5>
                            <form class="form-horizontal" action="513_Reporte_Candidatos.jsp" method="post">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="col-md-4">
                                            <br>
                                            <label>Tipo de Beca:</label>
                                        </div>
                                        <div class="col-md-8">
                                            <br>
                                            <select name="tipoBeca" id="tipoBeca" class="form-control">
                                                <option value="">Seleccione Tipo de Beca</option>
                                                <option value="EXTERNA">Externa</option>
                                                <option value="INTERNA">Interna</option>
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
                                        <label>Tipo de Estudio al que Aplica:</label>
                                    </div>
                                    <div class="col-md-8">
                                        <br>
                                        <select name="tipoEstudio" id="tipoEstudio"  class="form-control">
                                            <option value="">Seleccione una opción</option>
                                            <option value="ESPECIALIZACION">Especializacion</option>
                                            <option value="MAESTRIA">Maestria</option>
                                            <option value="DOCTORADO">Doctorado</option>
                                            <option value="POSTDOCTORADO">PostDoctorado</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6 text-center">
                                    <br>
                                    <div class="col-md-12 text-center">
                                        <input type="submit" class="btn btn-primary" name="submit" value="Buscar">                       
                                    </div>
                                </div>
                            </div>

                        </form>
                    </fieldset>
                </div>
                <%
                    InstitucionDAO institucionDAO3 = new InstitucionDAO();
                    Integer id_ofertaa_beca;
                    ConexionBD conexionbd = null;
                    ResultSet rs = null;
                    ArrayList<OfertaBeca> lista2 = new ArrayList();
                    ArrayList<Institucion> listaIns = new ArrayList();
                    ArrayList<DetalleUsuario> listaUser = new ArrayList();
                    ArrayList<Progreso> listaProg = new ArrayList();
                    ArrayList<SolicitudDeBeca> listaSol = new ArrayList();
                    ArrayList<Facultad> listaFacultades = new ArrayList();
                    OfertaBeca temp = new OfertaBeca();
                    Institucion temp2 = new Institucion();
                    DetalleUsuario temp3 = new DetalleUsuario();
                    Progreso temp4 = new Progreso();
                    SolicitudDeBeca temp5 = new SolicitudDeBeca();
                    Facultad temp6 = new Facultad();
                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                     String tipoBeca = "", facultad = "", institucionOferente = "", tipoEstudio="";
                    String queryParam=""; 

                     String consultaSql2 = "";   
                    try {
                       
                         if (!request.getParameter("tipoEstudio").isEmpty()) {
                            tipoEstudio = request.getParameter("tipoEstudio");
                        }
                        
                        if (!request.getParameter("tipoBeca").isEmpty()) {
                            tipoBeca = request.getParameter("tipoBeca");
                        }
                       
                        if (!request.getParameter("facultad").isEmpty()) {
                            facultad = request.getParameter("facultad");
                        }
                        
                        if (!request.getParameter("institucionOferente").isEmpty()) {
                            institucionOferente = request.getParameter("institucionOferente");
                        }
                        String fCierreIni = request.getParameter("fCierreIni");
                        String fCierreFin = request.getParameter("fCierreFin");
                        //formando la consulta
                        String consultaSql = "";
                       
                        consultaSql = " SELECT CONCAT(DU.NOMBRE1_DU, ' ', IFNULL(DU.NOMBRE2_DU,''),' ', DU.APELLIDO1_DU, ' ', IFNULL(DU.APELLIDO2_DU,'')) AS NOMBRE, "
                                            + " OB.TIPO_OFERTA_BECA AS TIPO_OFERTA_BECA, SB.FECHA_SOLICITUD AS FECHA_SOLICITUD, "
                                            + " OB.TIPO_ESTUDIO AS TIPO_ESTUDIO, INS.NOMBRE_INSTITUCION AS NOMBRE_INSTITUCION, "
                                            + " FACULTAD AS FACULTAD, NOMBRE_PROGRESO AS NOMBRE_PROGRESO "
                                            + " FROM DETALLE_USUARIO DU "
                                            + " JOIN SOLICITUD_DE_BECA SB ON SB.ID_USUARIO = DU.ID_USUARIO "
                                            + " JOIN OFERTA_BECA OB ON OB.ID_OFERTA_BECA = SB.ID_OFERTA_BECA " 
                                            + " JOIN EXPEDIENTE EX ON EX.ID_EXPEDIENTE = SB.ID_EXPEDIENTE "
                                            + " JOIN INSTITUCION INS ON INS.ID_INSTITUCION = OB.ID_INSTITUCION_FINANCIERA " 
                                            + " JOIN FACULTAD F ON F.ID_FACULTAD = DU.ID_FACULTAD "
                                            + " JOIN PROGRESO P ON P.ID_PROGRESO = EX.ID_PROGRESO "
                                            + " WHERE EX.ID_PROGRESO <9 ";
                                
                                
                                
                        
                        if (!request.getParameter("tipoBeca").isEmpty()) {
                            consultaSql2 = consultaSql2.concat(" AND OB.TIPO_OFERTA_BECA='" + tipoBeca + "' ");
                        }
                        
                        if (!request.getParameter("facultad").isEmpty()) {
                            consultaSql2 = consultaSql2.concat(" AND F.FACULTAD='" + facultad + "' ");
                        }
                        
                        if (!request.getParameter("institucionOferente").isEmpty()) {
                            consultaSql2 = consultaSql2.concat(" AND INS.NOMBRE_INSTITUCION='" + institucionOferente + "' ");
                        }
                        
                        if (!request.getParameter("tipoEstudio").isEmpty()) {
                            consultaSql2 = consultaSql2.concat(" AND OB.TIPO_ESTUDIO='" + tipoEstudio + "' ");
                        }
                        
                        if (!fCierreIni.isEmpty() && !fCierreFin.isEmpty()) {
                            java.sql.Date sqlFCierreIni = new java.sql.Date(OfertaServlet.StringAFecha(fCierreIni).getTime());
                            java.sql.Date sqlFCierreFin = new java.sql.Date(OfertaServlet.StringAFecha(fCierreFin).getTime());
                            consultaSql2 = consultaSql2.concat(" AND OB.FECHA_CIERRE BETWEEN '" + sqlFCierreIni + "' AND '" + sqlFCierreFin + "' ");
                        }
                        consultaSql2 = consultaSql2.concat(" ORDER BY NOMBRE ");
                        consultaSql = consultaSql.concat(consultaSql2);
                        consultaSql = consultaSql.concat(";");
                        queryParam=consultaSql;
                        System.out.println(consultaSql);
                        //realizando la consulta
                        conexionbd = new ConexionBD();
                        rs = conexionbd.consultaSql(consultaSql);
                        while (rs.next()) {
                            temp = new OfertaBeca();
                            temp2 = new Institucion();
                            temp3 = new DetalleUsuario();
                            temp4 = new Progreso();
                            temp5 = new SolicitudDeBeca();
                            temp6 = new Facultad();

                            temp.setTipoOfertaBeca(rs.getString("TIPO_OFERTA_BECA"));
                            temp.setTipoEstudio(rs.getString("TIPO_ESTUDIO"));
                            temp2.setNombreInstitucion(rs.getString("NOMBRE_INSTITUCION"));
                            temp3.setNombre1Du(rs.getString("NOMBRE"));
                            temp4.setNombreProgreso(rs.getString("NOMBRE_PROGRESO"));
                            temp5.setFechaSolicitud(rs.getDate("FECHA_SOLICITUD"));
                            temp6.setFacultad(rs.getString("FACULTAD"));

                            lista2.add(temp);
                            listaIns.add(temp2);
                            listaUser.add(temp3);
                            listaProg.add(temp4);
                            listaSol.add(temp5);
                            listaFacultades.add(temp6);

                        }
                        //con el rs se llenara la tabla de resultados
                    } catch (Exception ex) {
                        System.out.println(ex);
                    }
                %>                                               
                <div class="col-md-3 texct-center">
                    <fieldset class="custom-border">
                        <legend class="custom-border">Acciones</legend>
                            <br>
                            <div class="col-md-6 text-center">
                                <label>PDF</label>
                                <form class="form-horizontal" action="ReporteCandidatoServlet" method="post">
                                    <input type="hidden" name="REPORTE_TIPOBECA" value="<%=tipoBeca%>">
                                    <input type="hidden" name="REPORTE_FACULTAD" value="<%=facultad%>">
                                    <input type="hidden" name="REPORTE_TIPOESTUDIO" value="<%=tipoEstudio%>">
                                    <input type="hidden" name="REPORTE_INSTITUCION" value="<%=institucionOferente%>">
                                    <input type="hidden" name="QUERY" value="<%=queryParam %>">
                                    <input type="hidden" name="REPORTE_NOMBRE_USUARIO" value="RENÉ MAURICIO BOLAÑOS CANJURA">
                                    <input type="hidden" name="REPORTE_ROL_USUARIO" value="ADMINISTRADOR">
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
                    <table id="tablaResultados" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Nombre</th>
                                <th>Tipo de Beca Solicitada</th>
                                <th>Fecha de Ingreso Solicitud</th>
                                <th>TIpo de Estudio Solicitado</th>
                                <th>Institucion Financiera</th>
                                <th>Facultad</th>
                                <th>Estado del Proceso</th>
                            </tr>  
                        </thead>
                        <tbody>
                            <%
                                if (lista2.size() >= 0) {
                                    int i = 0;
                                    int j=1;
                                    while (i < lista2.size()) {
                                        out.write("<tr>");
                                        out.write("<td>" + j  + "</td>");
                                        out.write("<td>" + listaUser.get(i).getNombre1Du() + "</td>");
                                        out.write("<td>" + lista2.get(i).getTipoOfertaBeca() + "</td>");                                        
                                        out.write("<td>" + df.format(listaSol.get(i).getFechaSolicitud()) + "</td>");
                                        out.write("<td>" + lista2.get(i).getTipoEstudio() + "</td>");
                                        out.write("<td>" + listaIns.get(i).getNombreInstitucion() + "</td>");
                                        out.write("<td>" + listaFacultades.get(i).getFacultad() + "</td>");
                                        out.write("<td>" + listaProg.get(i).getNombreProgreso() + "</td>");
                                        out.write("</tr>");
                                        j++;
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

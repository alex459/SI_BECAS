<%-- 
    Document   : 511_Reporte_Institucion_Financiera
    Created on : 30/10/2016, 03:54:19 PM
    Author     : adminPC
--%>
<%@page import="MODEL.Utilidades"%>
<%@page import="POJO.Documento"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="POJO.OfertaBeca"%>
<%@page import="DAO.BecaDAO"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="DAO.OfertaBecaDAO"%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.IdiomaDAO"%>
<%@page import="POJO.Idioma"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Facultad"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.TipoUsuario"%>
<%@page import="DAO.TipoUsuarioDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.AgregarOfertaBecaServlet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String rol = (String) actual.getAttribute("rol");
    String user = (String) actual.getAttribute("user");
    Integer tipo_usuario_logeado = (Integer) actual.getAttribute("id_tipo_usuario");
    ArrayList<String> tipo_usuarios_permitidos = new ArrayList<String>();
    //AGREGAR SOLO LOS ID DE LOS USUARIOS AUTORIZADOS PARA ESTA PANTALLA------
    tipo_usuarios_permitidos.add("7");
    tipo_usuarios_permitidos.add("8");
    tipo_usuarios_permitidos.add("9");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    
    if (!autorizacion || user==null) {
        response.sendRedirect("logout.jsp");        
    }
    
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    OfertaBecaDAO ofertaBecaDAO = new OfertaBecaDAO();
    ArrayList<OfertaBeca> lista = ofertaBecaDAO.consultarTodos();
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
    <link href="css/customfieldset.css" rel="stylesheet">    
    <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker3.min.css" />
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
        <H3 class="text-center" style="color:#E42217;">Reporte de Ofertas de Beca</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Reporte de Ofertas de Beca</legend>
                    
                    <div class="row">            
                        <div class="col-md-9">
                               
                                <div class="row">   <!-- FILTROS -->

                    <div class="col-md-12">
                        <form class="form-horizontal" action="111_reporte_de_beca.jsp" method="post">
                            <fieldset class="custom-border">  
                                <legend class="custom-border">Filtros</legend>          
                                 <h5 style="color:#E42217">Ingrese los Fitros de Busqueda del Reporte</h5>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="col-md-6 text-right">                                   
                                            <label for="nombreOferta">Nombre de la Oferta : </label>                                
                                        </div>
                                        <div class="col-md-6">
                                            <input id="nombreOferta" name="nombreOferta" type="text" placeholder="Ingrese el Nombre de la Oferta" class="form-control input-md">                                                                
                                        </div>

                                    </div>    
                                    <div class="col-md-6">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="col-md-6 text-right">
                                                    <label for="fIngresoIni">Fecha de Ingreso (Inicio) :</label>                                
                                                </div>
                                                <div class="col-md-6">                                
                                                    <div class="input-group date">
                                                        <input type="text" name="fIngresoIni" id="fIngresoIni" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                                    </div>
                                                </div> 
                                            </div>
                                            <div class="col-md-6">
                                                <div class="col-md-6 text-right">
                                                    <label for="fIngresoFin">Fecha de Ingreso (Fin):</label>                                
                                                </div>
                                                <div class="col-md-6">                                
                                                    <div class="input-group date">
                                                        <input type="text" name="fIngresoFin" id="fIngresoFin" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                                    </div>
                                                </div> 
                                            </div>
                                        </div>   
                                    </div>
                                </div>    
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="col-md-6 text-right">
                                            <label for="institucionOfertante">Institucion Ofertante : </label>                                
                                        </div>
                                        <div class="col-md-6">
                                            <select id="institucionOferente" name="institucionOferente" class="form-control">
                                            <%
                                                InstitucionDAO institucionDAO = new InstitucionDAO();
                                                ArrayList<Institucion> listaInstitucion = new ArrayList();
                                                listaInstitucion = institucionDAO.consultarActivosPorTipo("OFERTANTE");
                                            %><option value="" disabled selected>Seleccione una Institución</option><%
                                                for (int i = 0; i < listaInstitucion.size(); i++) {%>
                                            <option value="<%=listaInstitucion.get(i).getNombreInstitucion()%>"> <%=listaInstitucion.get(i).getNombreInstitucion()%></option>
                                            <%   }
                                            %>    
                                        </select>     
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-6 text-right">
                                                <label for="fCierreIni">Fecha de Cierre (Inicio) :</label>                                
                                            </div>
                                            <div class="col-md-6">                                
                                                <div class="input-group date">
                                                    <input type="text" name="fCierreIni" id="fCierreIni" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                                </div>
                                            </div> 
                                        </div>
                                        <div class="col-md-6">
                                            <div class="col-md-6 text-right">
                                                <label for="fCierreFin">Fecha de Cierre (Fin) :</label>                                
                                            </div>
                                            <div class="col-md-6">                                
                                                <div class="input-group date">
                                                    <input type="text" name="fCierreFin" id="fCierreFin" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                                </div>
                                            </div> 
                                        </div>
                                    </div>   
                                </div>
                            </div>      
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="col-md-6 text-right">
                                        <label for="institucionEstudio">Institucion de Estudio :</label>                                
                                    </div>
                                    <div class="col-md-6">                                
                                        <select id="institucionEstudio" name="institucionEstudio" class="form-control">
                                            <%
                                                InstitucionDAO institucionDAO2 = new InstitucionDAO();
                                                ArrayList<Institucion> listaInstitucion2 = new ArrayList();
                                                listaInstitucion2 = institucionDAO2.consultarActivosPorTipo("ESTUDIO");
                                            %><option value="" disabled selected>Seleccione una Institución</option><%
                                                for (int i = 0; i < listaInstitucion2.size(); i++) {%>
                                            <option value="<%=listaInstitucion2.get(i).getNombreInstitucion()%>"> <%= listaInstitucion2.get(i).getNombreInstitucion()%> </option>
                                            <% }
                                            %>    
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="col-md-6 text-right">
                                        <label for="tipoEstudio">Tipo de Estudio :</label>                                
                                    </div>
                                    <div class="col-md-6"> 
                                        <select id="tipoEstudio" name="tipoEstudio" class="form-control">
                                            <option value="">Seleccione una Opción</option>
                                            <option value="MAESTRIA">MAESTRIA</option>
                                            <option value="DOCTORADO">DOCTORADO</option>
                                            <option value="ESPECIALIZACIÓN">ESPECIALIZACIÓN</option>
                                        </select>
                                    </div>
                                </div>
                            </div></br>
                            <div class="row">
                                <div class="col-md-12 text-center">
                                    <input type="submit" class="btn btn-primary" name="submit" value="Buscar">                       
                                </div>
                            </div>
                        </fieldset>
                    </form>                         
                </div>
            </div>    
            <%
                InstitucionDAO institucionDAO3 = new InstitucionDAO();
                Integer id_ofertaa_beca;
                ConexionBD conexionbd = null;
                ResultSet rs = null;
                ArrayList<OfertaBeca> lista2 = new ArrayList();
                ArrayList<Institucion> listaPais = new ArrayList();
                ArrayList<Documento> listaDocs = new ArrayList();
                OfertaBeca temp = new OfertaBeca();
                Institucion temp2 = new Institucion();
                Documento temp3 = new Documento();
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                String consultaSql = "", consultaSql2="";
                try {
                    String nombre = "", tipoEstudio = "", instOfertante = "", instEstudio = "";
                    if (!request.getParameter("nombreOferta").isEmpty()) {
                        nombre = request.getParameter("nombreOferta");
                    }
                    instOfertante = request.getParameter("institucionOferente");
                    instEstudio = request.getParameter("institucionEstudio");
                    if (!request.getParameter("tipoEstudio").isEmpty()) {
                        tipoEstudio = request.getParameter("tipoEstudio");
                    }
                    String fIngresoIni = request.getParameter("fIngresoIni");
                    String fIngresoFin = request.getParameter("fIngresoFin");
                    String fCierreIni = request.getParameter("fCierreIni");
                    String fCierreFin = request.getParameter("fCierreFin");
                    //formando la consulta
                    
                    consultaSql = "SELECT ID_OFERTA_BECA, NOMBRE_OFERTA,IDIOMA,TIPO_OFERTA_BECA,TIPO_ESTUDIO,FECHA_CIERRE, "
                            + " ID_INSTITUCION_ESTUDIO, ID_INSTITUCION_FINANCIERA, "
                            + " NOMBRE_INSTITUCION, OFERTA_BECA.ID_DOCUMENTO AS ID_DOCUMENTO, PAIS FROM "
                            + " OFERTA_BECA, INSTITUCION, DOCUMENTO WHERE OFERTA_BECA.ID_DOCUMENTO=DOCUMENTO.ID_DOCUMENTO "
                            + " AND OFERTA_BECA.ID_INSTITUCION_ESTUDIO=INSTITUCION.ID_INSTITUCION "
                            + " AND OFERTA_BECA_ACTIVA=1 ";
                    consultaSql2 = consultaSql2.concat(" AND TIPO_ESTUDIO LIKE '%" + tipoEstudio + "%' AND nombre_oferta like '%" + nombre + "%' ");       
                    if (instEstudio != null) {
                        int idEst = institucionDAO.consultarIdPorNombre(instEstudio);
                        consultaSql2 = consultaSql2.concat(" AND OFERTA_BECA.ID_INSTITUCION_ESTUDIO=" + idEst + " ");
                    }
                    if (instOfertante != null) {
                        int idFin = institucionDAO.consultarIdPorNombre(instOfertante);
                        consultaSql2 = consultaSql2.concat(" AND OFERTA_BECA.ID_INSTITUCION_FINANCIERA=" + idFin + " ");
                    }
                    if (!fIngresoIni.isEmpty() && !fIngresoFin.isEmpty()) {
                        java.sql.Date sqlFIngresoIni = new java.sql.Date(OfertaServlet.StringAFecha(fIngresoIni).getTime());
                        java.sql.Date sqlFIngresoFin = new java.sql.Date(OfertaServlet.StringAFecha(fIngresoFin).getTime());
                        consultaSql2 = consultaSql2.concat(" AND FECHA_INGRESO BETWEEN '" + sqlFIngresoIni + "' AND '" + sqlFIngresoFin + "' ");
                    }
                    if (!fCierreIni.isEmpty() && !fCierreFin.isEmpty()) {
                        java.sql.Date sqlFCierreIni = new java.sql.Date(OfertaServlet.StringAFecha(fCierreIni).getTime());
                        java.sql.Date sqlFCierreFin = new java.sql.Date(OfertaServlet.StringAFecha(fCierreFin).getTime());
                        consultaSql2 = consultaSql2.concat(" AND FECHA_CIERRE BETWEEN '" + sqlFCierreIni + "' AND '" + sqlFCierreFin + "' ;");
                    }
                    consultaSql = consultaSql.concat(consultaSql2);
                    System.out.println(consultaSql);
                    //realizando la consulta
                    conexionbd = new ConexionBD();
                    rs = conexionbd.consultaSql(consultaSql);
                    while (rs.next()) {
                        temp = new OfertaBeca();
                        temp2 = new Institucion();
                        temp3 = new Documento();
                        temp2.setPais(rs.getString("PAIS"));
                        temp3.setIdDocumento(rs.getInt("ID_DOCUMENTO"));
                        temp.setIdOfertaBeca(rs.getInt("ID_OFERTA_BECA"));
                        temp.setNombreOferta(rs.getString("NOMBRE_OFERTA"));
                        temp.setTipoOfertaBeca(rs.getString("TIPO_OFERTA_BECA"));
                        temp.setTipoEstudio(rs.getString("TIPO_ESTUDIO"));
                        temp.setFechaCierre(rs.getDate("FECHA_CIERRE"));
                        temp.setIdInstitucionEstudio(rs.getInt("ID_INSTITUCION_ESTUDIO"));
                        temp.setIdInstitucionFinanciera(rs.getInt("ID_INSTITUCION_FINANCIERA"));
                        temp.setIdioma(rs.getString("IDIOMA"));
                        temp.setTipoEstudio(rs.getString("TIPO_ESTUDIO"));
                        System.out.println(temp.getNombreOferta());
                        lista2.add(temp);
                        listaPais.add(temp2);
                        listaDocs.add(temp3);
                        System.out.println("GGGGGGGGTTTTTTTTT");
                    }
                    //con el rs se llenara la tabla de resultados
                } catch (Exception ex) {
                    System.out.println(ex);
                }
            %>     
                        </div>

                        <div class="col-md-3 text-center">
                           <fieldset class="custom-border">
                        <legend class="custom-border">Acciones</legend>
                            <br>
                            <div class="col-md-6 text-center">
                                <label>PDF</label>
                                <form class="form-horizontal" action="ReporteOfertasBecaServlet" method="post">
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
                        <h5>Resultados de la busqueda</h5>
                        <div class="row">    
                <fieldset class="custom-border">
                    <legend class="custom-border">Ofertas de Beca en el Sistema</legend>
                    <div class="row">
                        <div class="col-md-12">
                            <table id="tablaResultados" class="table table-bordered">

                                <thead>
                                    <tr class="success">
                                        <th>Nombre de la Oferta</th>
                                        <th>Tipo de Beca</th>
                                        <th>Fecha Límite</th>
                                        <th>País</th>
                                        <th>Tipo Estudio</th>
                                        <th>Institución de Estudio</th>
                                        <th>Institución Financiera</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        if (lista2.size() >= 0) {
                                            int i = 0;
                                            while (i < lista2.size()) {
                                                System.out.println(lista2.get(i).getIdOfertaBeca() + "ELLLLLLL ID");
                                                out.write("<tr>");
                                                out.write("<td>" + lista2.get(i).getNombreOferta() + "</td>");
                                                out.write("<td>" + lista2.get(i).getTipoOfertaBeca() + "</td>");
                                                out.write("<td>" + df.format(lista2.get(i).getFechaCierre()) + "</td>");
                                                out.write("<td>" + listaPais.get(i).getPais() + "</td>");
                                                out.write("<td>" + lista2.get(i).getTipoEstudio() + "</td>");
                                                out.write("<td>" + institucionDAO3.consultarPorId(lista2.get(i).getIdInstitucionEstudio()).getNombreInstitucion() + "</td>");
                                                out.write("<td>" + institucionDAO3.consultarPorId(lista2.get(i).getIdInstitucionFinanciera()).getNombreInstitucion() + "</td>");                                                
                                                out.write("</tr>");
                                                i++;
                                            }
                                        }
                                    %>   

                                </tbody>
                            </table>
                        </div> 
                    </div>
                </fieldset>
            </div> 
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

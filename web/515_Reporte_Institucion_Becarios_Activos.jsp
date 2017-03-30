<%-- 
    Document   : 515_Reporte_Institucion_Becarios_Activos
    Created on : 30/10/2016, 04:06:20 PM
    Author     : adminPC
--%>

<%@page import="POJO.Pais"%>
<%@page import="DAO.PaisDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="MODEL.AgregarOfertaBecaServlet"%>
<%@page import="POJO.Facultad"%>
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.AgregarOfertaBecaServlet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
    request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
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
        <H3 class="text-center" style="color:#E42217;">Reporte de Instituciones con Becarios Activos</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Reporte de Instituciones con Becarios Activos</legend>
                    
                    <div class="row">            
                        <div class="col-md-9">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Filtros</legend>
                                <h5 style="color:#E42217">Ingrese los Fitros de Busqueda del Reporte</h5>
                                <form class="form-horizontal" action="515_Reporte_Institucion_Becarios_Activos.jsp" method="post">
                                
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Institucion de Estudio:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select id="selectbasic" name="INSTITUCION_ESTUDIO" class="form-control">
                                                    <option value="0" selected>Seleccione una Institución</option>
                                                    <%
                                                            InstitucionDAO institucionDAO = new InstitucionDAO();
                                                            ArrayList<Institucion> listaInstitucion = new ArrayList();
                                                            listaInstitucion = institucionDAO.consultarActivosPorTipo("ESTUDIO");
                                                            for (int i = 0; i < listaInstitucion.size(); i++) {
                                                                out.write("<option value=" + listaInstitucion.get(i).getIdInstitucion() + ">" + listaInstitucion.get(i).getNombreInstitucion() + "</option>");
                                                                    
                                                            }
                                                    %>
                                                    
                                                    
                                                </select>      
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Pais:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select id="selectbasic" name="PAIS" class="form-control">
                                                    <option value="">Seleccione País</option>
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
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Facultad:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select id="selectbasic" name="ID_FACULTAD" class="form-control">
                                                            <option value="0">Seleccione Facultad</option>    
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
                                        <div class="col-md-6">
                                            <div class="col-md-4">
                                                <br>
                                                <label>Tipo de Estudio Realizado:</label>
                                            </div>
                                            <div class="col-md-8">
                                                <br>
                                                <select  name="TIPO_ESTUDIO" id="TIPO_ESTUDIO" class="form-control">
                                                    <option value="">Seleccione Tipo de Estudio</option>
                                                    <option value="MAESTRIA">Maestria</option>
                                                    <option value="DOCTORADO">Doctorado</option>
                                                    <option value="ESPECIALIZACION">Especializacion</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    

                                    <div class="row text-center">
                                        <br>
                                       <input type="submit" class="btn btn-primary" name="submit" value="Buscar"> 
                                        </div>

                                </form>
                            </fieldset>
                        </div>
 <%
                
                String tipoEstudio;
                String pais;
                Integer id_institucion_estudio;
                Integer id_facultad;
                // DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                ConexionBD conexionbd = null;
               
                ResultSet rs = null;   
                 String queryParam=""; 
                    
                String consultaSql2 = ""; 
                try{
                    tipoEstudio = request.getParameter("TIPO_ESTUDIO");
                    id_institucion_estudio = Integer.parseInt(request.getParameter("INSTITUCION_ESTUDIO"));
                    id_facultad = Integer.parseInt(request.getParameter("ID_FACULTAD"));
                   // pais = request.getParameter("PAIS");
                    String consultaSql="";
                    
                   // if(tipoEstudio!=null) {} else {tipoEstudio="";};
                    //if(tipoEstudio!=null) {} else {tipoEstudio="";};
                    //if(tipoBecario!=null) {} else {tipoBecario="";};
                    //if(documento!=null) {} else {documento="";};
                    
                    //consultaSql = "SELECT CONCAT(DU.NOMBRE1_DU,' ', DU.NOMBRE2_DU,' ', DU.APELLIDO1_DU,' ', DU.APELLIDO2_DU) AS NOMBRE, OF.TIPO_OFERTA_BECA, OF.FECHA_INICIO, I.PAIS, OF.NOMBRE_OFERTA, TD.TIPO_DOCUMENTO, OBS.OBSERVACION_O, F.FACULTAD FROM DETALLE_USUARIO DU JOIN FACULTAD  F ON DU.ID_FACULTAD=F.ID_FACULTAD JOIN USUARIO U ON DU.ID_USUARIO=U.ID_USUARIO JOIN TIPO_USUARIO TU ON U.ID_TIPO_USUARIO=TU.ID_TIPO_USUARIO JOIN SOLICITUD_DE_BECA SB ON U.ID_USUARIO=SB.ID_USUARIO JOIN EXPEDIENTE  E ON SB.ID_EXPEDIENTE=E.ID_EXPEDIENTE JOIN PROGRESO P ON E.ID_PROGRESO=P.ID_PROGRESO JOIN OFERTA_BECA OF ON SB.ID_OFERTA_BECA=OF.ID_OFERTA_BECA JOIN DOCUMENTO  D ON D.ID_EXPEDIENTE=E.ID_EXPEDIENTE JOIN TIPO_DOCUMENTO  TD ON D.ID_TIPO_DOCUMENTO=TD.ID_TIPO_DOCUMENTO JOIN INSTITUCION I ON OF.ID_INSTITUCION_ESTUDIO=I.ID_INSTITUCION JOIN OBSERVACIONES OBS ON OBS.ID_EXPEDIENTE=E.ID_EXPEDIENTE WHERE U.ID_TIPO_USUARIO = 2 AND E.ESTADO_EXPEDIENTE='ABIERTO' AND D.ESTADO_DOCUMENTO='PENDIENTE' AND OF.TIPO_OFERTA_BECA LIKE '%" + tipoBeca + "%' AND P.ESTADO_BECARIO LIKE '%" + tipoBecario + "%' " ;

                               
                              //  + "AND OF.TIPO_OFERTA_BECA LIKE '%" + tipoBeca + "%' AND P.ESTADO_BECARIO LIKE '%" + tipoBecario + "%'";
                    
                  consultaSql = "SELECT I.NOMBRE_INSTITUCION, I.PAIS, I.EMAIL, COUNT(E.ID_EXPEDIENTE) AS NUMERO_DE_BECARIOS "                      

                                + "FROM SOLICITUD_DE_BECA SB "

                                + "JOIN OFERTA_BECA OB ON SB.ID_OFERTA_BECA = OB.ID_OFERTA_BECA "
                                + "JOIN INSTITUCION I ON OB.ID_INSTITUCION_ESTUDIO = I.ID_INSTITUCION "
                                + "JOIN EXPEDIENTE E ON SB.ID_EXPEDIENTE = E.ID_EXPEDIENTE "
                                + "JOIN USUARIO U ON SB.ID_USUARIO = U.ID_USUARIO "
                                + "JOIN DETALLE_USUARIO DU ON DU.ID_USUARIO = U.ID_USUARIO "
                                + "WHERE E.ESTADO_EXPEDIENTE='ABIERTO' AND E.ID_PROGRESO IN (9,10,11,20,21,22,25,26) ";

// + "AND OF.TIPO_OFERTA_BECA LIKE '%" + tipoBeca + "%' AND P.ESTADO_BECARIO LIKE '%" + tipoBecario + "%'";
                    
                               
                               
                               
                    if (request.getParameter("TIPO_ESTUDIO").toString().length()>0) {
                           
                            tipoEstudio = request.getParameter("TIPO_ESTUDIO");
                            consultaSql2 = consultaSql2.concat(" AND OB.TIPO_ESTUDIO = '" + tipoEstudio + "' ");
                   
                        }
                     if (request.getParameter("PAIS").toString().length()>0) {
                           
                            pais = request.getParameter("PAIS");
                            consultaSql2 = consultaSql2.concat(" AND I.PAIS = '" + pais + "' ");
                   
                        }
                    
                    if (id_institucion_estudio == 0) {

                    } else {
                        consultaSql2 = consultaSql2.concat(" AND I.ID_INSTITUCION = " + id_institucion_estudio + " ");
                    }
                               
                               
                    if (id_facultad == 0) {

                    } else {
                        consultaSql2 = consultaSql2.concat(" AND DU.ID_FACULTAD = " + id_facultad);
                    }   
                consultaSql2 = consultaSql2.concat(" GROUP BY I.NOMBRE_INSTITUCION ");
                consultaSql = consultaSql.concat(consultaSql2);
                    consultaSql = consultaSql.concat(";");
                conexionbd = new ConexionBD();
                rs = conexionbd.consultaSql(consultaSql);
                
                }
                catch(Exception ex){
                    System.out.println("error: " + ex);
                }






                    %>

                        <div class="col-md-3 text-center">
                    <fieldset class="custom-border">
                        <legend class="custom-border">Acciones</legend>
                            <br>
                            <div class="col-md-6 text-center">
                                <label>PDF</label>
                                     <form class="form-horizontal" action="ReporteInstitucionBecariosActivosServlet" method="post">
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
                                        <th>INSTITUCIÓN</th>
                                        <th>PAÍS</th>
                                        <th>PÁGINA WEB</th>
                                        <th>CANTIDAD DE BECARIOS</th>
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
                                                out.write("<td>" + rs.getString(1) + "</td>");
                                                out.write("<td>" + rs.getString(2) + "</td>");
                                                out.write("<td>" + rs.getString(3) + "</td>");
                                                out.write("<td>" + rs.getString(4) + "</td>");
                                                
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
   
</script>
</body>
</html>
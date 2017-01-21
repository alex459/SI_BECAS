<%-- 
    Document   : 516_Reporte_Tipos_Becarios
    Created on : 30/10/2016, 04:07:16 PM
    Author     : adminPC
--%>

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
                                                    <option value="INCUMPLIMIENTO DE CONTRATO">Incumplimiento de Contrato</option>
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
                    
                            String consultaSql2 = "";    

                          try {
                              
                                String fIngresoIni = request.getParameter("fIngresoIni");
                                String fIngresoFin = request.getParameter("fIngresoFin");
                                String fCierreIni = request.getParameter("fCierreIni");
                                String fCierreFin = request.getParameter("fCierreFin");  
                                
                                
                                
                              String consultaSql="";
                               
                              consultaSql = "SELECT DISTINCT SB.ID_EXPEDIENTE,CONCAT(DU.NOMBRE1_DU,' ', DU.NOMBRE2_DU,' ', DU.APELLIDO1_DU,' ', DU.APELLIDO2_DU) AS NOMBRE, "
                                + "OF.TIPO_OFERTA_BECA, OF.FECHA_INICIO, I.PAIS, OF.NOMBRE_OFERTA,I.NOMBRE_INSTITUCION , OBS.OBSERVACION_O, F.FACULTAD "
                                + "FROM DETALLE_USUARIO DU "
                                + "JOIN FACULTAD  F ON DU.ID_FACULTAD=F.ID_FACULTAD "
                                + "JOIN USUARIO U ON DU.ID_USUARIO=U.ID_USUARIO "
                                + "JOIN TIPO_USUARIO TU ON U.ID_TIPO_USUARIO=TU.ID_TIPO_USUARIO "
                                + "JOIN SOLICITUD_DE_BECA SB ON U.ID_USUARIO=SB.ID_USUARIO "
                                + "JOIN EXPEDIENTE  E ON SB.ID_EXPEDIENTE=E.ID_EXPEDIENTE "
                                + "JOIN PROGRESO P ON E.ID_PROGRESO=P.ID_PROGRESO "
                                + "JOIN OFERTA_BECA OF ON SB.ID_OFERTA_BECA=OF.ID_OFERTA_BECA "
                                + "JOIN DOCUMENTO  D ON D.ID_EXPEDIENTE=E.ID_EXPEDIENTE "
                                + "JOIN TIPO_DOCUMENTO  TD ON D.ID_TIPO_DOCUMENTO=TD.ID_TIPO_DOCUMENTO "
                                + "JOIN INSTITUCION I ON OF.ID_INSTITUCION_FINANCIERA=I.ID_INSTITUCION "
                                + "JOIN OBSERVACIONES OBS ON OBS.ID_EXPEDIENTE=E.ID_EXPEDIENTE "
                                + "WHERE U.ID_TIPO_USUARIO = 2 AND E.ESTADO_EXPEDIENTE='ABIERTO' ";
                              
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
                          }
                         catch(Exception ex){
                    
                         }



                        %>

                        <div class="col-md-3 text-center">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Acciones</legend>
                                <div class="col-md-6">
                                    <br>
                                    <label class="">PDF</label>
                                    <button type="submit" class="btn btn-success form-control">
                                       <span class="glyphicon glyphicon-file"></span> 
                                       PDF
                                    </button><br><br>
                                    <label>Enviar Por Correo</label>
                                    <button type="submit" class="btn btn-success form-control">
                                       <span class="glyphicon glyphicon-file"></span> 
                                       E-mail
                                    </button>
                                </div>
                                <div class="col-md-6">
                                    <label>Hoja de Cálculo</label>
                                    <button type="submit" class="btn btn-success form-control">
                                       <span class="glyphicon glyphicon-file"></span> 
                                       Excel
                                    </button><br><br>
                                    <br>
                                    <label>Imprimir</label>
                                    <button type="submit" class="btn btn-success form-control">
                                       <span class="glyphicon glyphicon-print"></span> 
                                       Imprimir
                                    </button>
                                    
                                </div>                                                                
                            </fieldset>
                        </div>
                    </div>
                    
                    <div class="row">
                        <h5>Resultados de la busqueda</h5>
                        <div class="col-md-12">
                            <table class="table text-center">
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
                                        <th>Toma de Posecion</th>
                                        <th>Facultad</th>
                                        <th>Observaciones</th>
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
                                                out.write("<td>" + rs.getString(2) + "</td>");
                                                out.write("<td> </td>");
                                                out.write("<td>" + rs.getString(3) + "</td>");
                                                out.write("<td>" + rs.getString(4) + "</td>");
                                                out.write("<td> </td>");
                                                out.write("<td>" + rs.getString(5) + "</td>");
                                                out.write("<td>" + rs.getString(6) + "</td>");
                                                out.write("<td>" + rs.getString(7) + "</td>");
                                                 out.write("<td> </td>");
                                                out.write("<td>" + rs.getString(9) + "</td>");
                                                out.write("<td>" + rs.getString(8) + "</td>");
                                            }
                                        }
                                        catch (Exception ex){
                                            System.out.println("error: " + ex);
                                        }
                                        
                                        %>
                                    
                                </tbody>
                            </table>
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
<script type="text/javascript">
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

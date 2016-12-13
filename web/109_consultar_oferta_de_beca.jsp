<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
--%>
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
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    OfertaBecaDAO ofertaBecaDAO = new OfertaBecaDAO();
    ArrayList<OfertaBeca> lista = ofertaBecaDAO.consultarTodos();
    AgregarOfertaBecaServlet OfertaServlet = new AgregarOfertaBecaServlet();
%>
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

        <div class="row"><!-- TITULO DE LA PANTALLA -->

            <h2>
                <p class="text-center" style="color:#cf2a27">Consultar ofertas de beca</p>
            </h2>

            <br></br> 
        </div><!-- TITULO DE LA PANTALLA -->  

        <div class="row"><!-- CONTENIDO DE LA PANTALLA -->  
            <fieldset class="custom-border"> 
                <legend class="custom-border">Consultar oferta de beca</legend>   
                <div class="row">   <!-- FILTROS -->

                    <div class="col-md-12">
                        <form class="form-horizontal" action="109_consultar_oferta_de_beca.jsp" method="post">
                            <fieldset class="custom-border">  
                                <legend class="custom-border">Filtros</legend>                    
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="col-md-6 text-right">                                   
                                            <label for="nombreOferta">Nombre de la oferta : </label>                                
                                        </div>
                                        <div class="col-md-6">
                                            <input id="nombreOferta" name="nombreOferta" type="text" placeholder="ingrese el nombre de la oferta" class="form-control input-md">                                                                
                                        </div>

                                    </div>    
                                    <div class="col-md-6">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="col-md-6 text-right">
                                                    <label for="fIngresoIni">Fecha de ingreso (inicio) :</label>                                
                                                </div>
                                                <div class="col-md-6">                                
                                                    <div class="input-group date">
                                                        <input type="text" name="fIngresoIni" id="fIngresoIni" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="data.fecha_nacimiento"></i></span>
                                                    </div>
                                                </div> 
                                            </div>
                                            <div class="col-md-6">
                                                <div class="col-md-6 text-right">
                                                    <label for="fIngresoFin">Fecha de ingreso (fin):</label>                                
                                                </div>
                                                <div class="col-md-6">                                
                                                    <div class="input-group date">
                                                        <input type="text" name="fIngresoFin" id="fIngresoFin" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="data.fecha_nacimiento"></i></span>
                                                    </div>
                                                </div> 
                                            </div>
                                        </div>   
                                    </div>
                                </div>    
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="col-md-6 text-right">
                                            <label for="institucionOfertante">Institucion ofertante : </label>                                
                                        </div>
                                        <div class="col-md-6">
                                            <select id="institucionOferente" name="institucionOferente" class="form-control">
                                            <%
                                                InstitucionDAO institucionDAO = new InstitucionDAO();
                                                ArrayList<Institucion> listaInstitucion = new ArrayList();
                                                listaInstitucion = institucionDAO.consultarPorTipo("OFERTANTE");
                                            %><option value="" disabled selected>Seleccione una institución</option><%
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
                                                <label for="fCierreIni">Fecha de cierre (inicio) :</label>                                
                                            </div>
                                            <div class="col-md-6">                                
                                                <div class="input-group date">
                                                    <input type="text" name="fCierreIni" id="fCierreIni" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="data.fecha_nacimiento"></i></span>
                                                </div>
                                            </div> 
                                        </div>
                                        <div class="col-md-6">
                                            <div class="col-md-6 text-right">
                                                <label for="fCierreFin">Fecha de cierre (fin) :</label>                                
                                            </div>
                                            <div class="col-md-6">                                
                                                <div class="input-group date">
                                                    <input type="text" name="fCierreFin" id="fCierreFin" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="data.fecha_nacimiento"></i></span>
                                                </div>
                                            </div> 
                                        </div>
                                    </div>   
                                </div>
                            </div>      
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="col-md-6 text-right">
                                        <label for="institucionEstudio">Institucion de estudio :</label>                                
                                    </div>
                                    <div class="col-md-6">                                
                                        <select id="institucionEstudio" name="institucionEstudio" class="form-control">
                                            <%
                                                InstitucionDAO institucionDAO2 = new InstitucionDAO();
                                                ArrayList<Institucion> listaInstitucion2 = new ArrayList();
                                                listaInstitucion2 = institucionDAO2.consultarPorTipo("ESTUDIO");
                                            %><option value="" disabled selected>Seleccione una institución</option><%
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
                                        <label for="tipoEstudio">Tipo de estudio :</label>                                
                                    </div>
                                    <div class="col-md-6"> 
                                        <select id="tipoEstudio" name="tipoEstudio" class="form-control">
                                            <option value="">Seleccione una opción</option>
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
                    String consultaSql = "";
                    consultaSql = "SELECT ID_OFERTA_BECA, NOMBRE_OFERTA,IDIOMA,TIPO_OFERTA_BECA,TIPO_ESTUDIO,FECHA_CIERRE, "
                            + " ID_INSTITUCION_ESTUDIO, ID_INSTITUCION_FINANCIERA, "
                            + " NOMBRE_INSTITUCION, OFERTA_BECA.ID_DOCUMENTO AS ID_DOCUMENTO, PAIS FROM "
                            + " OFERTA_BECA, INSTITUCION, DOCUMENTO WHERE OFERTA_BECA.ID_DOCUMENTO=DOCUMENTO.ID_DOCUMENTO "
                            + " AND OFERTA_BECA.ID_INSTITUCION_ESTUDIO=INSTITUCION.ID_INSTITUCION "
                            + " AND OFERTA_BECA_ACTIVA=1 "
                            + "AND TIPO_ESTUDIO LIKE '%" + tipoEstudio + "%' AND nombre_oferta like '%" + nombre + "%'";
                    if (instEstudio != null) {
                        int idEst = institucionDAO.consultarIdPorNombre(instEstudio);
                        consultaSql = consultaSql.concat(" AND OFERTA_BECA.ID_INSTITUCION_ESTUDIO=" + idEst + " ");
                    }
                    if (instOfertante != null) {
                        int idFin = institucionDAO.consultarIdPorNombre(instOfertante);
                        consultaSql = consultaSql.concat(" AND OFERTA_BECA.ID_INSTITUCION_FINANCIERA=" + idFin + " ");
                    }
                    if (!fIngresoIni.isEmpty() && !fIngresoFin.isEmpty()) {
                        java.sql.Date sqlFIngresoIni = new java.sql.Date(OfertaServlet.StringAFecha(fIngresoIni).getTime());
                        java.sql.Date sqlFIngresoFin = new java.sql.Date(OfertaServlet.StringAFecha(fIngresoFin).getTime());
                        consultaSql = consultaSql.concat(" AND FECHA_INGRESO BETWEEN '" + sqlFIngresoIni + "' AND '" + sqlFIngresoFin + "' ");
                    }
                    if (!fCierreIni.isEmpty() && !fCierreFin.isEmpty()) {
                        java.sql.Date sqlFCierreIni = new java.sql.Date(OfertaServlet.StringAFecha(fCierreIni).getTime());
                        java.sql.Date sqlFCierreFin = new java.sql.Date(OfertaServlet.StringAFecha(fCierreFin).getTime());
                        consultaSql = consultaSql.concat(" AND FECHA_CIERRE BETWEEN '" + sqlFCierreIni + "' AND '" + sqlFCierreFin + "' ");
                    }
                    consultaSql = consultaSql.concat(";");
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

            <div class="row">    
                <fieldset class="custom-border">
                    <legend class="custom-border">Ofertas de beca en el sistema</legend>
                    <div class="row">
                        <div class="col-md-12">
                            <table class="table">

                                <thead>
                                    <tr class="success">
                                        <th>Nombre de la oferta</th>
                                        <th>Tipo de beca</th>
                                        <th>Fecha limite</th>
                                        <th>País</th>
                                        <th>Tipo estudio</th>
                                        <th>Institución de estudio</th>
                                        <th>Institución financiera</th>
                                        <th>Documento</th>
                                        <th>Acción</th>
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
                                                out.write("<td><center><form action='DocumentoOferta' method='post'  target='_blank'><input type='hidden' name='id' value='" + listaDocs.get(i).getIdDocumento() + "'><input type='submit' class='btn btn-primary' value='Ver Documento'></form></center></td>");
                                                out.write("<td><center><form style='display:inline;' action='108_modificar_oferta_de_beca.jsp' method='post'><input type='hidden' name='ID_DOC' value='" + listaDocs.get(i).getIdDocumento() + "'><input type='hidden' name='ID_OFERTA_BECA' value='" + lista2.get(i).getIdOfertaBeca() + "'><input type='submit' class='btn btn-success' name='submit' value='Modificar oferta'></center></form></td>");
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
        </fieldset>                                        
    </div><!-- CONTENIDO DE LA PANTALLA -->









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
                                                            $('.input-group.date').datepicker({
                                                                format: 'yyyy-mm-dd',
                                                                calendarWeeks: true,
                                                                todayHighlight: true,
                                                                autoclose: true,
                                                                startDate: new Date()
                                                            });
                                                        });
</script>
</body>
</html>

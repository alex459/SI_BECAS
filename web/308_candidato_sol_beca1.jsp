<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="POJO.Expediente"%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page import="POJO.Facultad"%>
<%@page import="DAO.DetalleUsuarioDAO"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="POJO.Municipio"%>
<%@page import="DAO.MunicipioDAO"%>
<%@page import="POJO.Departamento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.DepartamentoDAO"%>
<%@page import="POJO.Usuario"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="MODEL.variablesDeSesion"%>
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

    boolean expedienteAbierto = false;
    try {
        // Comprobando si tiene un proceso de beca abierto
        ExpedienteDAO expDao = new ExpedienteDAO();
        expedienteAbierto = expDao.expedienteAbierto(user);
    } catch (Exception e) {
        e.printStackTrace();
    }
    //Si no ha iniciado un proceso de beca lo reenvia a la pagina de las ofertas
    if (expedienteAbierto == false) {
        response.sendRedirect("301_inf_publica_ofertas_beca.jsp");
        return;
    }
    //obtener el expediente
    ExpedienteDAO expDao = new ExpedienteDAO();
    Expediente expediente = expDao.obtenerExpedienteAbierto(user);

    //Obtener usuario completo
    String nombreOferta = "";
    String nombreInstitucion = "";
    int duracion = 0;
    int idFacultad = 0;
    Facultad facultad = new Facultad();
    String pais = "";
    String tipoBeca = "";
    ArrayList<Departamento> departamentos = new ArrayList<Departamento>();
    ArrayList<Municipio> municipios = new ArrayList<Municipio>();
    String departamentosJSON = "";
    String municipiosJSON = "";
    try {
        UsuarioDAO usDao = new UsuarioDAO();
        Usuario usuario = usDao.consultarPorNombreUsuario(user);
        //Obteniendo su facultad
        DetalleUsuarioDAO detDao = new DetalleUsuarioDAO();
        idFacultad = detDao.obtenerFacultad(user);
        FacultadDAO facDao = new FacultadDAO();
        facultad = facDao.consultarPorId(idFacultad);

        //Obteniendo oferta solicitada
        ConexionBD conexionBD = new ConexionBD();
        String consultaSql = "SELECT NOMBRE_OFERTA,NOMBRE_INSTITUCION,DURACION,PAIS,TIPO_OFERTA_BECA FROM EXPEDIENTE EX JOIN SOLICITUD_DE_BECA SB ON EX.ID_EXPEDIENTE = SB.ID_EXPEDIENTE JOIN OFERTA_BECA OF ON OF.ID_OFERTA_BECA = SB.ID_OFERTA_BECA JOIN INSTITUCION I ON I.ID_INSTITUCION = OF.ID_INSTITUCION_ESTUDIO JOIN USUARIO US ON US.ID_USUARIO = SB.ID_USUARIO WHERE US.NOMBRE_USUARIO = '" + user + "'";
        ResultSet rs = conexionBD.consultaSql(consultaSql);
        while (rs.next()) {
            nombreOferta = rs.getString("NOMBRE_OFERTA");
            nombreInstitucion = rs.getString("NOMBRE_INSTITUCION");
            duracion = rs.getInt("DURACION");
            pais = rs.getString("PAIS");
            tipoBeca = rs.getString("TIPO_OFERTA_BECA");
        }
        conexionBD.cerrarConexion();

        DepartamentoDAO depDao = new DepartamentoDAO();
        departamentos = depDao.consultarTodos();
        MunicipioDAO munDao = new MunicipioDAO();
        municipios = munDao.consultarTodos();
        Gson gson = new Gson();
        String departamentosJSON1 = gson.toJson(departamentos);
        departamentosJSON = departamentosJSON1.replace("\"", "'");
        String municipiosJSON1 = gson.toJson(municipios);
        municipiosJSON = municipiosJSON1.replace("\"", "'");
    } catch (Exception e) {
        e.printStackTrace();
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
            <h3 class="text-center text-danger" >
                Universidad De El Salvador
            </h3>
        </div>
        <div class="col-md-8">
            <div class="col-xs-12" style="height:50px;"></div>
            <h2 class="text-center text-danger" style="text-shadow:3px 3px 3px #666;">
                Consejo de Becas y de Investigaciones Científicas <br> Universidad de El Salvador
            </h2>
            <h3 class="text-center text-danger" style="text-shadow:3px 3px 3px #666;">
                Sistema informático para la administración de becas de postgrado
            </h3>
        </div>
    </div>

    <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>
    </head>


    <body ng-app = "solicitudbecaApp" ng-controller="solicitudCtrl" ng-init="departamentos =<%=departamentosJSON%>; municipios =<%=municipiosJSON%>; facultad = '<%=facultad.getFacultad()%>'; user = '<%=user%>'; nombreOferta = '<%=nombreOferta%>'; nombreInstitucion = '<%=nombreInstitucion%>'; duracion = '<%=duracion%>'; pais = '<%=pais%>'; tipoBeca = '<%=tipoBeca%>';">

    <div class="container-fluid" ng-init="oferta={nombre:'<%=nombreOferta%>',institucion: '<%=nombreInstitucion%>'}" >
        <H3 class="text-center" style="color:#E42217;">Solicitud de beca</H3>
        <fieldset class="custom-border">
            <legend class="custom-border">Solicitud de beca de postgrado</legend>
            <%if (expediente.getIdProgreso() == 5) {%>
                <% if (expediente.getEstadoProgreso().equals("EN PROCESO")) {%>
                    <div class="text-center">
                        <h3 class="text-danger"> Ya ha realizado una Solicitud de Beca ante el Consejo de Becas</h3>
                        <a href="303_candidato_estado_solicitudes.jsp" class="btn btn-primary">Ver Estado de Solicitud</a>
                    </div>
                <%} else {%>
                <form class="form-horizontal" name="solicitud" action="{{url}}" method="POST" enctype="multipart/form-data" target="{{pestana}}" novalidate>            
                        <div class="row" ng-view>            

                        </div>
                    </form>
                <%}%>
            <%} else {%>
                <div class="text-center">
                    <h3 class="text-danger">No corresponde solicitar este documento </h3>
                    <a href="305_candidato_estado_proceso.jsp" class="btn btn-primary">Ver Estado del Proceso de Beca</a>
                </div>
            <%}%>
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
    <script src="js/scripts.js"></script>
    <script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
    <script src="js/angular.min.js"></script>
    <script src="js/angular-route.min.js"></script>
    <script src="js/solicitudbeca.js"></script>
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

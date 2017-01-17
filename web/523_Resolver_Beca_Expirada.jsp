<%-- 
    Document   : 523_Resolver_Beca_Expirada
    Created on : 12/01/2017, 08:07:17 PM
    Author     : adminPC
--%>

<%@page import="DAO.DocumentoDAO"%>
<%@page import="POJO.Documento"%>
<%@page import="POJO.Documento"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
    tipo_usuarios_permitidos.add("8"); //consejo de beca
    tipo_usuarios_permitidos.add("9"); //admin
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!-- fin de proceso de seguridad de login -->

<%
    
    String idExpediente = request.getParameter("idExpediente");
    DocumentoDAO docDao = new DocumentoDAO();
    ArrayList<Documento> publicos = new ArrayList<Documento>();
    publicos =  docDao.consultarFiscaliaReintegroBeca(Integer.parseInt(idExpediente));

    ConexionBD conexionBD = new ConexionBD();

    String consultaSql = "SELECT DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, U.NOMBRE_USUARIO,DU.DEPARTAMENTO,F.FACULTAD, OB.NOMBRE_OFERTA, I.NOMBRE_INSTITUCION, B.FECHA_FIN FROM DETALLE_USUARIO DU JOIN FACULTAD F ON DU.ID_FACULTAD=F.ID_FACULTAD JOIN USUARIO U ON U.ID_USUARIO = DU.ID_USUARIO JOIN SOLICITUD_DE_BECA SB ON DU.ID_USUARIO=SB.ID_USUARIO JOIN OFERTA_BECA OB ON OB.ID_OFERTA_BECA = SB.ID_OFERTA_BECA JOIN INSTITUCION I ON I.ID_INSTITUCION = OB.ID_INSTITUCION_ESTUDIO JOIN beca B ON B.ID_EXPEDIENTE = SB.ID_EXPEDIENTE WHERE SB.ID_EXPEDIENTE = " + idExpediente;
    ResultSet rs = null;
    String becario = "";
    String titulo = "";
    String institucion = "";
    String codigo = "";
    String unidad = "";
    String oferta = "";
    String fechaFin = "";
    try {
        rs = conexionBD.consultaSql(consultaSql);
        while (rs.next()) {
            becario = rs.getString("NOMBRE1_DU") + " " + rs.getString("NOMBRE2_DU") + " " + rs.getString("APELLIDO1_DU") + " " + rs.getString("APELLIDO2_DU");
            titulo = rs.getString("NOMBRE_OFERTA");
            institucion = rs.getString("NOMBRE_INSTITUCION");
            codigo = rs.getString("NOMBRE_USUARIO");
            unidad = rs.getString("DEPARTAMENTO") + " " + rs.getString("FACULTAD");
            oferta = rs.getString("NOMBRE_OFERTA");
            fechaFin = rs.getString("FECHA_FIN");
        }
    } catch (Exception ex) {
        System.err.println("error: " + ex);
    }
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
    <body ng-app="">
        <div class="container-fluid">
            <div class="row"><!-- TITULO DE LA PANTALLA -->
                <h3 class="text-center" style="color:#cf2a27">
                    Resolver Beca Expirada
                </h3>

                <br></br>

            </div><!-- TITULO DE LA PANTALLA --> 
            <div class="col-md-12">

                <fieldset class="custom-border">
                    <legend class="custom-border">Solicitud</legend>

                    <div class="row">    <!-- TABLA RESULTADOS --> 
                        <div class="col-md-1"></div> 
                        <div class="col-md-10">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td>Becario: </td>
                                        <td><%=becario%> </td>
                                    <td>Codigo de Empleado: </td>
                                    <td><%=codigo%> </td>
                                </tr>

                                <tr>
                                    <td>Unidad: </td>
                                    <td><%=unidad%> </td>
                                    <td>Expediente: </td>
                                    <td><%=idExpediente%> </td>
                                </tr>

                                <tr>
                                    <td>Titulo a Obtener: </td>
                                    <td><%=oferta%> </td>
                                    <td>Fecha Fin Beca: </td>
                                    <td><%=fechaFin%> </td>
                                </tr>

                            </tbody>    
                        </table>
                    </div>
                </div>




                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                        <fieldset class="custom-border">
                            <legend class="custom-border"> Documentos del Expediente</legend>

                            <div class="row">
                                <div class="col-md-12">
                                    <table class="table table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th>No.</th><th>Tipo de Documento</th><th>Estado</th><th>Documento Digital</th>
                                                            </tr>   
                                                        </thead>
                                                        <tbody >
                                                        <%
                                                            for (int i = 0; i < publicos.size(); i++) {%>
                                                            <tr>
                                                                <td><%=i+1%></td>
                                                                <td><% out.write(publicos.get(i).getIdTipoDocumento().getTipoDocumento());%></td>
                                                                <td><% out.write(publicos.get(i).getEstadoDocumento());%></td>
                                                                <td>
                                                                    <form action="verDocumentoConsejo" method="post" target="_blank">
                                                                        <input type = "hidden" name="id" value="<%= publicos.get(i).getIdDocumento()%>">
                                                                        <input type="submit" class="btn btn-success" value="Ver Documento ">
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                            <% }%>
                                                        </tbody>
                                                    </table>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-10">
                                    <fieldset class="custom-border">
                                        <legend class="custom-border"> Resolucion</legend>
                                        <form  name="solicitarReintegro" action="SolicitarReintegro" method="POST" novalidate>                                                       
                                            
                                            <div class="row text-center">
                                                <input type="hidden" name="idExpediente" value="<%=idExpediente%>">
                                                <input type="submit" value="Solicitar Reintegro" class="btn btn-success">
                                                <a href="principal.jsp" class="btn btn-danger">Cancelar</a>
                                            </div>  
                                        </form>    
                                    </fieldset>
                                </div>
                                <div class="col-md-1"></div>
                            </div>


                        </fieldset>      
                    </div>
                </div>
                <div class="col-md-1"></div>
            </fieldset>
        </div>  

    </div>
</body>
</html>

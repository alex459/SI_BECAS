<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="POJO.Expediente"%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.DocumentoDAO"%>
<%@page import="POJO.Documento"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>

<!-- inicio proceso de seguridad de login -->
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
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
    tipo_usuarios_permitidos.add("1"); //candidato
    tipo_usuarios_permitidos.add("9"); //admin
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!-- fin de proceso de seguridad de login -->

<%
    response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
    request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
    ExpedienteDAO expDao = new ExpedienteDAO();
    Expediente expediente = expDao.obtenerExpedienteAbierto(user);
    DocumentoDAO documentoDAO = new DocumentoDAO();
    ArrayList<Documento> lista = new ArrayList<Documento>();
    if (expediente.getIdExpediente() != null) {
        int idExpediente = expediente.getIdExpediente();
        lista = documentoDAO.consultarSolicitudesCandidato(idExpediente);
    }
    ConexionBD conexionBD = new ConexionBD();

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
    <body>
        <div class="container-fluid">
            <h3 class="text-center" style="color:#E42217;">Estado de Solicitudes</h3>
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-10">
                    <fieldset class="custom-border">
                        <legend class="custom-border">Solicitudes Realizadas</legend>

                        <div class="col-md-12">
                            <table class="table table-bordered">
                                <%if (lista.isEmpty()) {}else{%>
                                <thead>
                                    <tr class="success">
                                        <th>No</th>
                                        <th>Solicitud</th>
                                        <th>Unidad</th>
                                        <th>Estado</th>
                                        <th>Acción</th>
                                    </tr>                                   
                                </thead>
                                <%}%>
                                <tbody class="text-center">                                
                                <%if (lista.isEmpty()) {
                                        out.write("<tr><h3 class='text-primary'>No ha realizado ninguna solicitud</h3></tr>");
                                    } else {
                                        Documento acuerdo = new Documento();
                                        int numero = 1;
                                        int idAcuerdo = 0;
                                        int idDoc = 0;
                                        String tipo = "";
                                        String unidad = "";
                                        String url = "";
                                        for (int i = 0; i < lista.size(); i++) {
                                            try {
                                                idDoc = lista.get(i).getIdTipoDocumento().getIdTipoDocumento();
                                                switch (idDoc) {
                                                    case 103:
                                                        tipo = "ACUERDO DE PERMISO INICIAL";
                                                        unidad = "JUNTA DIRECTIVA";
                                                        url = "318_modificar_sol_permiso_inicial.jsp";
                                                        break;
                                                    case 105:
                                                        tipo = "ACUERDO DE AUTORIZACION INICIAL";
                                                        unidad = "CONSEJO DE BECAS";
                                                        url = "319_actualizar_sol_autorizacion_inicial.jsp";
                                                        break;
                                                    case 112:
                                                        tipo = "DICTAMEN DE PROPUESTA ANTE JUNTA DIRECTIVA";
                                                        unidad = "COMISION DE BECAS";
                                                        url = "320_actualizar_sol_dictamen_propuesta.jsp";
                                                        break;
                                                    case 131:
                                                        tipo = "SOLICITUD DE BECA";
                                                        unidad = "CONSEJO DE BECAS";
                                                        url = "321_Modificar_Solicitud_Beca.jsp";
                                                        break;
                                                }%>
                                <tr>
                                    <td><%=numero%></td>
                                    <td><%=tipo%></td>
                                    <td><%=unidad%></td>
                                    <td><%=lista.get(i).getEstadoDocumento()%></td>
                                    <td>
                                        <%if (lista.get(i).getEstadoDocumento().equals("APROBADO") || lista.get(i).getEstadoDocumento().equals("DENEGADO") || lista.get(i).getEstadoDocumento().equals("REVISION")) {%>                                                
                                        <form action="verDocumentoConsejo" method="post" target="_blank">
                                            <input type = "hidden" name="id" value="<%= lista.get(i).getIdDocumento()%>">
                                            <input type="submit" class="btn btn-success" value="Ver Documento ">
                                        </form>
                                        <%} else if (lista.get(i).getEstadoDocumento().equals("EN ESPERA")) {%>                                                 
                                        <div class="row">                                                    
                                            <form action="CancelarSolicitudServlet" method="post">
                                                <input type='hidden' name='ACCION' value='cancelar'>
                                                <input type = "hidden" name="idDocumento" value="<%= lista.get(i).getIdDocumento()%>">
                                                <input type="submit" class="btn btn-danger" value="Cancelar">
                                            </form>                                                          
                                        </div>
                                         <%} else if (lista.get(i).getEstadoDocumento().equals("CANCELADO")) {%>
                                        <%} else {%>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <form action="<%=url%>" method="post">
                                                    <input type='hidden' name='ACCION' value='actualizar'>
                                                    <input type = "hidden" name="idDocumento" value="<%= lista.get(i).getIdDocumento()%>">
                                                    <input type="submit" class="btn btn-success form-control" value="Editar ">
                                                </form>
                                            </div>
                                            <div class="col-md-6">
                                                <form action="CancelarSolicitudServlet" method="post">
                                                    <input type='hidden' name='ACCION' value='cancelar'>
                                                    <input type = "hidden" name="idDocumento" value="<%= lista.get(i).getIdDocumento()%>">
                                                    <input type="submit" class="btn btn-danger form-control" value="Cancelar">
                                                </form>      
                                            </div>
                                        </div>
                                        <%}%>
                                    </td>
                                </tr>
                                <%
                                                numero++;
                                            } catch (Exception e) {
                                            }
                                        }

                                    }%>                                
                            </tbody>
                        </table>
                    </div>

                </fieldset>
            </div>
            <div class="col-md-1"></div>
        </div>            
    </div>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>

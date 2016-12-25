<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="POJO.Usuario"%>
<%@page import="DAO.SolocitudBecaDAO"%>
<%@page import="POJO.SolicitudDeBeca"%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page import="POJO.Expediente"%>
<%@page import="DAO.ProgresoDAO"%>
<%@page import="POJO.Progreso"%>
<%@page import="MODEL.variablesDeSesion"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% 
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String rol=(String)actual.getAttribute("rol");
    String user=(String)actual.getAttribute("user");
    Integer tipo_usuario_logeado = (Integer) actual.getAttribute("id_tipo_usuario");
    ArrayList<String> tipo_usuarios_permitidos = new ArrayList<String>();
    //AGREGAR SOLO LOS ID DE LOS USUARIOS AUTORIZADOS PARA ESTA PANTALLA------
    tipo_usuarios_permitidos.add("1");
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
   
    boolean expedienteAbierto = false; 
    Expediente expediente = new Expediente();
    //Obtener Expediente Abierto
    try{
        // Comprobando si tiene un proceso de beca abierto
        ExpedienteDAO expDao = new ExpedienteDAO();
        expedienteAbierto = expDao.expedienteAbierto(user);
        if(expedienteAbierto == true){
            //obtener el expediente
            expDao = new ExpedienteDAO();
            expediente = expDao.obtenerExpedienteAbierto(user);
        }else{
        expediente.setIdProgreso(0);
        }
    } catch (Exception e){
        e.printStackTrace();
    }
    
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

    <p class="text-right" style="font-weight:bold;">Rol: <%= rol %></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user %></p>


    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>
</head>

<body>
    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Estado del proceso de beca</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Becas</legend>
        <div class="row">            
            <div class="col-md-6">
                <div class = "panel panel-default">
                   <table class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <th>Proceso</th>
                            <th>Estado</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>                            
                            <td style="background-color:#728FCE; color:white">Sin iniciar</td>
                            <%
                                System.out.println(expediente.getIdExpediente()+" SSSS "+expediente.getEstadoExpediente());
                            if(expedienteAbierto == false)    
                            out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                            else                                
                            out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                            %>        
                            <td class="text-center" style="background-color:white; color:black;">
                                <center>                                    
                                <form style='display:inline;' >
                                    <%
                                    if(expedienteAbierto == false)    
                                    out.write("<a href='301_inf_publica_ofertas_beca.jsp'>Ver ofertas de beca</a>");
                                    else
                                    out.write("<input type='submit' class='btn btn-success' name='submit' value='Finalizado' disabled>");
                                                                %>
                                </form>
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Permiso inicial de junta directiva</td>
                            <%
                             if(expediente.getIdProgreso()<1)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(expediente.getIdProgreso()==1)
                             { 
                               if(expediente.getEstadoProgreso().equals("REVISION"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Revisión </td>");
                               else if(expediente.getEstadoProgreso().equals("DENEGADO"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Denegado</td>");
                               else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>En proceso</td>"); 
                             }
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(expediente.getIdProgreso()<1){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(expediente.getIdProgreso()==1)
                             { 
                               if(expediente.getEstadoProgreso().equals("REVISION")){
                                out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-exclamation-sign'></span>"); 
                               }
                               else if(expediente.getEstadoProgreso().equals("DENEGADO")){
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-alert'></span>");
                               }
                               else {
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                               }
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>  
                                                                   
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Autorización inicial del consejo de becas</td>
                            <%
                             if(expediente.getIdProgreso()<2)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(expediente.getIdProgreso() ==2)
                                 { 
                               if(expediente.getEstadoProgreso().equals("REVISION"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Revisión </td>");
                               else if(expediente.getEstadoProgreso().equals("DENEGADO"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Denegado</td>");
                               else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>En proceso</td>"); 
                             }
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(expediente.getIdProgreso()<2){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(expediente.getIdProgreso()==2){ 
                               if(expediente.getEstadoProgreso().equals("REVISION")){
                                out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-exclamation-sign'></span>"); 
                               }
                               else if(expediente.getEstadoProgreso().equals("DENEGADO")){
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-alert'></span>");
                               }
                               else {
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                               }
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                                    
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Dictamen de la comisión de beca</td>
                            <%
                             if(expediente.getIdProgreso()<3)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(expediente.getIdProgreso()==3)
                                 { 
                               if(expediente.getEstadoProgreso().equals("REVISION"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Revisión </td>");
                               else if(expediente.getEstadoProgreso().equals("DENEGADO"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Denegado</td>");
                               else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>En proceso</td>"); 
                             }
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(expediente.getIdProgreso()<3){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(expediente.getIdProgreso()==3){ 
                               if(expediente.getEstadoProgreso().equals("REVISION")){
                                out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-exclamation-sign'></span>"); 
                               }
                               else if(expediente.getEstadoProgreso().equals("DENEGADO")){
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-alert'></span>");
                               }
                               else {
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                               }
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Acuerdos de permisos de beca de junta directiva</td>
                            <%
                             if(expediente.getIdProgreso()<4)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(expediente.getIdProgreso()==4)
                                { 
                               if(expediente.getEstadoProgreso().equals("REVISION"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Revisión </td>");
                               else if(expediente.getEstadoProgreso().equals("DENEGADO"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Denegado</td>");
                               else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>En proceso</td>"); 
                             }
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(expediente.getIdProgreso()<4){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(expediente.getIdProgreso()==4){ 
                               if(expediente.getEstadoProgreso().equals("REVISION")){
                                out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-exclamation-sign'></span>"); 
                               }
                               else if(expediente.getEstadoProgreso().equals("DENEGADO")){
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-alert'></span>");
                               }
                               else {
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                               }
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Solicitud de beca</td>
                            <%
                             if(expediente.getIdProgreso()<5)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(expediente.getIdProgreso()==5)
                                 { 
                               if(expediente.getEstadoProgreso().equals("REVISION"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Revisión </td>");
                               else if(expediente.getEstadoProgreso().equals("DENEGADO"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Denegado</td>");
                               else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>En proceso</td>"); 
                             }
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(expediente.getIdProgreso()<5){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(expediente.getIdProgreso()==5){ 
                               if(expediente.getEstadoProgreso().equals("REVISION")){
                                out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-exclamation-sign'></span>"); 
                               }
                               else if(expediente.getEstadoProgreso().equals("DENEGADO")){
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-alert'></span>");
                               }
                               else {
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                               }
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                                    
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Resolución del expediente de beca</td>
                            <%
                             if(expediente.getIdProgreso()<6)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(expediente.getIdProgreso()==6)
                                 { 
                               if(expediente.getEstadoProgreso().equals("REVISION"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Revisión </td>");
                               else if(expediente.getEstadoProgreso().equals("DENEGADO"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Denegado</td>");
                               else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>En proceso</td>"); 
                             }
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(expediente.getIdProgreso()<6){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(expediente.getIdProgreso()==6){ 
                               if(expediente.getEstadoProgreso().equals("REVISION")){
                                out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-exclamation-sign'></span>"); 
                               }
                               else if(expediente.getEstadoProgreso().equals("DENEGADO")){
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-alert'></span>");
                               }
                               else {
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                               }
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Acuerdos de beca del consejo superior universitario</td>
                            <%
                             if(expediente.getIdProgreso()<7)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(expediente.getIdProgreso()==7)
                                 { 
                               if(expediente.getEstadoProgreso().equals("REVISION"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Revisión </td>");
                               else if(expediente.getEstadoProgreso().equals("DENEGADO"))
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Denegado</td>");
                               else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>En proceso</td>"); 
                             }
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(expediente.getIdProgreso()<7){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(expediente.getIdProgreso()==7){ 
                               if(expediente.getEstadoProgreso().equals("REVISION")){
                                out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-exclamation-sign'></span>"); 
                               }
                               else if(expediente.getEstadoProgreso().equals("DENEGADO")){
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-alert'></span>");
                               }
                               else {
                                   out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                               }
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                            </form>
                            </td>
                        </tr>
                    </tbody>
                </table> 
                </div>
            </div>              
            <div class="col-md-5">
                <h3>Detalle</h3>
                <div class = "panel panel-default">
                    <div class="row">
                        <div class="col-md-12">
                            <%if(expedienteAbierto == false){%>
                                <br>
                                <p>Aun no ha iniciado el proceso para adquirir una beca de postgrado, 
                                    para ver las ofertas disponibles presione el botón “ver ofertas”.</p><br>
                                <div class="row text-center">
                                    <a href="301_inf_publica_ofertas_beca.jsp" class="btn btn-success">Ver Ofertas</a>
                                </div>
                                
                            <%}else if(expediente.getIdProgreso() == 1){%>
                                <br>
                                <p>En esta etapa debe de solicitar el Acuerdo de Permiso Inicial para poder gestionar la beca ante el Consejo de Becas.</p><br>
                                <p>Los documentos que debe adjuntar son:</p><br>
                                <p>Obligatorios</p><br>
                                <ul>
                                    <li>Carta de solicitud de permiso para poder aplicar a la beca seleccionada dirigida a Junta Directiva de su Facultad</li>
                                </ul>
                                <p>Opcionales</p><br>
                                <ul>
                                    <li>Carta de Solicitud o recomendación de la Escuela o Departamento en que labora</li>
                                    <li>Carta de solicitud de la institución que oferta la beca).</li>
                                </ul>
                                <div class="row text-center">
                                    <% if(expediente.getEstadoProgreso().equals("EN PROCESO")){%>
                                    <a href="303_candidato_estado_solicitudes.jsp" class="btn btn-success">Ver Estado de Solicitud</a>
                                    <%}else if(expediente.getEstadoProgreso().equals("REVISION")){%>
                                    <a href="304_candidato_sol_permiso_inicial.jsp" class="btn btn-success">Actualizar documentación</a>
                                    <%}else{%>
                                    <a href="304_candidato_sol_permiso_inicial.jsp" class="btn btn-success">Solicitar Ahora</a>
                                    <%}%>
                                </div>
                                
                            <%}else if(expediente.getIdProgreso() == 2){%>
                                <br>
                                <p>En esta etapa debe de solicitar el Acuerdo de Autorización Inicial al Consejo de Becas.</p><br>
                                <p>Los documentos que debe adjuntar son:</p><br>
                                <p>Obligatorios</p><br>
                                <ul>
                                    <li>Carta de solicitud de Autorización Inicial para poder gestionar el Dictamen de propuesta a Junta Directiva a la Comisión de Becas de su Facultad.</li>
                                </ul>
                                <p>Opcionales</p><br>
                                <ul>
                                    <li>Carta de Solicitud o recomendación de la Escuela o Departamento en que labora</li>
                                    <li>Carta de solicitud de la institución que oferta la beca).</li>
                                </ul>
                                <div class="row text-center">
                                    <% if(expediente.getEstadoProgreso().equals("EN PROCESO")){%>
                                    <a href="303_candidato_estado_solicitudes.jsp" class="btn btn-success">Ver Estado de Solicitud</a>
                                    <%}else if(expediente.getEstadoProgreso().equals("REVISION")){%>
                                    <a href="306_candidato_sol_autorizacion_inicial.jsp" class="btn btn-success">Actualizar documentación</a>
                                    <%}else{%>
                                    <a href="306_candidato_sol_autorizacion_inicial.jsp" class="btn btn-success">Solicitar Ahora</a>
                                    <%}%>
                                </div>
                                
                            <%}else if(expediente.getIdProgreso() == 3){%>
                                <br>
                                <p>En esta etapa debe de solicitar el Dictamen de Propuesta a la Comisión de Becas de su Facultad.</p><br>
                                <p>Los documentos que debe adjuntar son:</p><br>
                                <ul>
                                    <li>Carta de solicitud de dictamen de propuesta ante Junta Directiva dirigida a la Comisión de Becas de su Facultad.</li>
                                    <li>Carta de recomendación de la Escuela o Departamento al que pertenece.</li>
                                    <li>Carta  de aceptación de la institución que ofrece la beca.</li>
                                    <li>Plan de Estudios.</li>
                                    <li>Carta de Constancia de la Unidad de Recursos Humanos del tiempo de servicio.</li>
                                    <li>Carta de legalización de maestría ante el MINED. (solo para becas internas)</li>
                                </ul>
                                <div class="row text-center">
                                    <% if(expediente.getEstadoProgreso().equals("EN PROCESO")){%>
                                    <a href="303_candidato_estado_solicitudes.jsp" class="btn btn-success">Ver Estado de Solicitud</a>
                                    <%}else if(expediente.getEstadoProgreso().equals("REVISION")){%>
                                    <a href="307_candidato_sol_dictamen_propuesta.jsp" class="btn btn-success">Actualizar documentación</a>
                                    <%}else{%>
                                    <a href="307_candidato_sol_dictamen_propuesta.jsp" class="btn btn-success">Solicitar Ahora</a>
                                    <%}%>
                                </div>
                                
                            <%}else if(expediente.getIdProgreso() == 4){%>
                                <br>
                                <p>Se ha emitido el Dictamen de la Comisión de Becas, se ha iniciado el proceso de Resolución de los Permisos de Beca por parte Junta Directiva de su Facultad.</p><br>
                                                                
                            <%}else if(expediente.getIdProgreso() == 5){%>
                                <br>
                                <p>En esta etapa debe de llenar la Solicitud de Beca para obtener una resolución por el Consejo de Becas.</p><br>
                                <p>Los documentos que debe adjuntar son:</p><br>
                                <ul>
                                    <li>Dictamen del jefe del departamento o Escuela que manifieste que el candidato fue elegido por concurso de oposición</li>
                                    <li>Solicitud de Beca Firmada</li>
                                    <li>Título Académico</li>
                                    <li>Partida de Nacimiento</li>
                                    <li>Notas Globales</li>
                                    <li>DUI</li>
                                    <li>Currículum Vitae</li>
                                    <li>Certificado de Salud</li>
                                    <li>Poder Judicial otorgado a su apoderado.</li>
                                </ul>
                                <div class="row text-center">
                                    <% if(expediente.getEstadoProgreso().equals("EN PROCESO")){%>
                                    <a href="303_candidato_estado_solicitudes.jsp" class="btn btn-success">Ver Estado de Solicitud</a>
                                    <%}else if(expediente.getEstadoProgreso().equals("REVISION")){%>
                                    <a href="308_candidato_sol_beca1.jsp" class="btn btn-success">Actualizar documentación</a>
                                    <%}else{%>
                                    <a href="308_candidato_sol_beca1.jsp" class="btn btn-success">Solicitar Ahora</a>
                                    <%}%>
                                </div>
                                
                            <%}else if(expediente.getIdProgreso() == 6){%>
                                <br>
                                <p>Su solicitud de beca ha sido realizada al Consejo de Becas, su Expediente se encuentra en proceso de revisión para poder emitir la resolución de su solicitud.</p><br>                                
                            <%}else if(expediente.getIdProgreso() == 7){%>
                                <br>
                                <p>Se ha realizado la solicitud al Consejo Superior Universitario para que pueda emitir los Acuerdo de beca.</p><br>
                                
                                
                            <%}else if(expediente.getIdProgreso() == 8){%>
                                <br>
                                
                                <p>En esta etapa debe presentarse a las oficinas de Fiscalía Universitaria para el asesoramiento y validación del contrato de beca.</p><br>
                                
                            <%}else {%>
                                <br>
                                <p>Felicidades, es un becario de la Universidad de El Salvador.</p><br>
                                <p>Se le recomienda cumplir con sus obligaciones contractuales.</p><br>
                                
                                
                            <%}%>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-12 col-md-offset-4">
                            <form style='display:inline;' action='CancelarProcesoCandidato' method='post'>
                                <input type='hidden' name='id_exp' value='<%=expediente.getIdExpediente() %>'>
                          <%   
                              if(expedienteAbierto)
                                  out.write("<button id='cancelar' name='cancelar' class='btn b5tn-danger'>Cancelar proceso</button>");
                              else    
                                  out.write("<button id='cancelar' name='cancelar' class='btn btn-danger' disabled>Cancelar proceso</button>");
                                 %>
                         </form>
                        </div></br>
                    </div>
                </div>
            </div>  
        </div></fieldset>

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
</body>
</html>

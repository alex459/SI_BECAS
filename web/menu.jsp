<%-- 
    Document   : menu
    Created on : 10-17-2016, 06:49:53 AM
    Author     : next
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%@page import="MODEL.variablesDeSesion"%>
        <%
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Cache-Control", "must-revalidate");
            response.setHeader("Cache-Control", "no-cache");
            HttpSession actual = request.getSession();
            String r = (String) actual.getAttribute("rol");
            String u = (String) actual.getAttribute("user");           
            Integer t = (Integer) actual.getAttribute("id_tipo_usuario");
            if (u == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            Integer id_candidato = 1;
            Integer id_becario = 2;
            Integer id_comision = 3;
            Integer id_junta = 4;
            Integer id_csu = 5;
            Integer id_fiscalia = 6;
            Integer id_colaborador_consejo = 7;
            Integer id_director_consejo = 8;
            Integer id_admin = 9;
            Integer id_inactivo = 10;
            

        %>    
            
    <nav class="navbar navbar-custom" role="navigation">
        
        
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            
            <%                                
                
                //menu administracion                
                if(t==id_colaborador_consejo || t==id_director_consejo || t==id_admin){
                    out.write("<ul class='nav navbar-nav'>");
                    out.write("<li class='dropdown'>");
                    out.write("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Administración<strong class='caret'></strong></a>");
                    out.write("<ul class='dropdown-menu'>");
                    
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='#' >===Administración de usuarios===</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='101_agregar_usuario.jsp'>Agregar usuario</a></li>");                    
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='112_consulta_para_actualizar_usuario.jsp'>Actualizar usuarios</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='103_consultar_usuario.jsp'>Consultar usuarios</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='113_consulta_para_dar_de_baja_usuario.jsp'>Dar de baja usuarios</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='114_consulta_para_modificar_roles.jsp'>Modificar roles</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='106_bitacora.jsp'>Bitacora</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='#'>===Administración de becas===</a></li>");                    
                    if(t==id_director_consejo || t==id_admin)
                    {out.write("<li><a style='background-color: #cf2a27; color:white' href='107_agregar_oferta_de_beca.jsp'>Agregar oferta de beca</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='109_consultar_oferta_de_beca.jsp'>Consultar/Modificar oferta de beca</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='110_eliminar_oferta_de_beca.jsp'>Deshabilitar oferta de beca</a></li>");}
                    
                    if(t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='111_reporte_de_beca.jsp'>Reporte de oferta de becas</a></li>");
                    if(t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='#'>===Administración de becarios===</a></li>");
                    if(t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='201_consultar_expediente.jsp'>Consultar expediente</a></li>");
                    if(t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='202_consulta_modificar_estado_de_becario.jsp'>Modificar estado de becario</a></li>");
                    if(t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='203_suspender_becario.jsp'>Suspender becario</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='#'>===Administración de instituciones===</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='204_agregar_institucion.jsp'>Agregar institución</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='213_consulta_para_modificar_institucion.jsp'>Modificar institución</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='206_consultar_institucion.jsp'>Consultar institución</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='214_consulta_para_eliminar_institucion.jsp'>Eliminar institución</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='#'>===Administración de documentos===</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='208_agregar_documento.jsp'>Agregar documento</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='209_modificar_documento.jsp'>Modificar documento</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='210_consultar_documento.jsp'>Consultar documento</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='211_eliminar_documento.jsp'>Eliminar documento</a></li>");                    
                    
                    out.write("</ul>");
                    out.write("</li>");
                    out.write("</ul>");
                }
                
                
                //menu de candidatos. todos menos el becarios
                if(t==id_candidato || t==id_comision || t==id_csu || t==id_fiscalia || t==id_director_consejo || t==id_admin){                                                            
                    out.write("<ul class='nav navbar-nav'>");
                    out.write("<li class='dropdown'>");
                    out.write("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Candidatos<strong class='caret'></strong></a>");
                    out.write("<ul class='dropdown-menu'>");
                    
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='301_inf_publica_ofertas_beca.jsp'>Ofertas de becas</a></li>");                    
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='303_candidato_estado_solicitudes.jsp'>Estado de solicitudes</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='305_candidato_estado_proceso.jsp'>Estado de proceso de beca</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='304_candidato_sol_permiso_inicial.jsp'>Solicitud de Permiso Inicial</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='306_candidato_sol_autorizacion_inicial.jsp'>Solicitud de autorizacion inicial</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='307_candidato_sol_dictamen_propuesta.jsp'>Solicitud de dictamen de propuesta</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='308_candidato_sol_beca1.jsp'>Solicitud de beca</a></li>");
                    
                    out.write("</ul>");
                    out.write("</li>");
                    out.write("</ul>");
                }
                
                //menu de Becarios
                if(t==id_becario || t==id_director_consejo || t==id_admin){                                                            
                    out.write("<ul class='nav navbar-nav'>");
                    out.write("<li class='dropdown'>");
                    out.write("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Becarios<strong class='caret'></strong></a>");
                    out.write("<ul class='dropdown-menu'>");
                    
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='400_Becario_Solicitudes.jsp'>Estado de Solicitudes</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='401_Becario_Sol_Acuerdo_Anio_Fiscal.jsp'>Solicitud acuerdo de año fiscal</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='402_Becario_Sol_Prorroga.jsp'>Solicitud prorroga</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='801_agregar_documento_finalizacion_beca.jsp'>Agregar documentos de finalizacion de beca</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='802_solicitar_inicio_de_servicio_contractual.jsp'>Solicitar inicio de servicio contractual</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='803_solicitar_acuerdo_de_gestion_de_compromiso_contractual.jsp'>Solicitar acuerdo de gestion de compromiso contractual</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='804_solicitar_acuerdo_de_gestion_de_liberacion.jsp'>Solicitar Acuerdo de gestion de liberacion</a></li>");
                    
                    out.write("</ul>");
                    out.write("</li>");
                    out.write("</ul>");
                }
                
                //menu de Solicitudes y acuerdos
                if(t==id_comision || t==id_junta || t==id_csu || t==id_fiscalia || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin){                                                            
                    out.write("<ul class='nav navbar-nav'>");
                    out.write("<li class='dropdown'>");
                    out.write("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Solicitudes y acuerdos<strong class='caret'></strong></a>");
                    out.write("<ul class='dropdown-menu'>");
                    
                    if(t==id_comision || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='#'>===Comision de Becas===</a></li>");
                    if(t==id_comision || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='407_Comision_Becas_Solicitud_Acuerdos_Pendientes.jsp'>Solicitudes de dictamenes pendientes</a></li>");
                    if(t==id_comision || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='408_Comision_Becas_Resolver_Solicitud.jsp'>Resolver solicitudes de dictamenes pendientes</a></li>");
                    if(t==id_comision || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='409_Comision_Becas_Buscar_Acuerdo.jsp'>Buscar dictamenes emitidos</a></li>");
                    if(t==id_junta || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='#'>===Junta Directiva===</a></li>");
                    if(t==id_junta || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='410_Junta_Directiva_Solicitud_Acuerdos_Pendientes.jsp'>Solicitudes de acuerdos pendientes</a></li>");
                    if(t==id_junta || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='411_Junta_Directiva_Resolver_Solicitud.jsp'>Resolver solicitudes de acuerdos</a></li>");
                    if(t==id_junta || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='412_Junta_Directiva_Buscar_Acuerdos.jsp'>Buscar acuerdos emitidos</a></li>");
                    if(t==id_csu || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='#'>===Consejo Superior Universitario===</a></li>");
                    if(t==id_csu || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='413_Consejo_Superior_Universitario_Solicitud_Acuerdos_Pendientes.jsp'>Solicitudes de acuerdos pendientes</a></li>");
                    if(t==id_csu || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='414_Consejo_Superior_Universitario_Resolver_Solicitud.jsp'>Resolver solicitudes de acuerdos</a></li>");
                    if(t==id_csu || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='415_Consejo_Superior_Universitario_Buscar_Acuerdos.jsp'>Buscar acuerdos emitidos</a></li>");
                    // if(t==id_csu || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='#'>Buscar acuerdos emitidos</a></li>");
                    if(t==id_fiscalia || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='#'>===Fiscalia===</a></li>");
                    if(t==id_fiscalia || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='501_Solicitudes_Asesoria_Contrato.jsp'>Solicitudes de asesorias de contrato de beca</a></li>");
                    if(t==id_fiscalia || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='502_Resolver_Solicitudes_Asesoria_Contrato.jsp'>Resolver solicitudes de asesoria de contrato de beca</a></li>");
                    if(t==id_fiscalia || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='505_Buscar_Contrato.jsp'>Buscar contrato de beca</a></li>");
                    if(t==id_fiscalia || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='503_Solicitudes_Reintegro_Beca.jsp'>Solicitud de reintegro de beca</a></li>");                    
                    if(t==id_fiscalia || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='504_Resolver_Solicitudes_Reintegro_Beca.jsp'>Resolver solicitudes de asesoria de reintegro de beca</a></li>");
                    if(t==id_fiscalia || t==id_colaborador_consejo || t==id_director_consejo || t==id_admin)out.write("<li><a style='background-color: #cf2a27; color:white' href='506_Buscar_Acta_Reintegro.jsp'>Buscar acta de reintegro de beca</a></li>");
                   
                    out.write("</ul>");
                    out.write("</li>");
                    out.write("</ul>");
                }
                
                //menu de consejo de becas
                if(t==id_colaborador_consejo || t==id_director_consejo || t==id_admin){                                                            
                    out.write("<ul class='nav navbar-nav'>");
                    out.write("<li class='dropdown'>");
                    out.write("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Consejo de Becas<strong class='caret'></strong></a>");
                    out.write("<ul class='dropdown-menu'>");
                    
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='507_Consejo_Becas_Solicitudes_Pendientes.jsp'>Solicitudes de acuerdos pendientes</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='508_Consejo_Becas_Resolver_Solicitud.jsp'>Resolver solicitud de acuerdo pendiente</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='520_Solicitudes_de_Inicio_Beca.jsp'>Solicitudes de Inicio de Beca</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='521_Resolver_Solicitud_de_Inicio_de_Beca.jsp'>Resolver solicitud de Inicio de Beca</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='509_Consejo_Becas_Buscar_Acuerdo.jsp'>Buscar acuerdo</a></li>");                    
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='518_Solicitudes_de_Cierre_de_Expediente.jsp'>Solicitudes de Cierre de Expediente</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='519_Resolver_Cierre_de_Expediente.jsp'>Resolver Solicitud de Cierre de Expediente</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='510_Reportes.jsp'>Reportes</a></li>");
                    
                    out.write("</ul>");
                    out.write("</li>");
                    out.write("</ul>");
                }
 

            %>
            
            <!--
            <ul class="nav navbar-nav">                                
                <li class="dropdown">                    
                        
                    <ul class="dropdown-menu">                                                                    
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#" >===Administración de usuarios===</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="101_agregar_usuario.jsp">Agregar usuario</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="112_consulta_para_actualizar_usuario.jsp">Actualizar usuarios</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="103_consultar_usuario.jsp">Consultar usuarios</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="113_consulta_para_dar_de_baja_usuario.jsp">Dar de baja usuarios</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="114_consulta_para_modificar_roles.jsp">Modificar roles</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="106_bitacora.jsp">Bitacora</a>
                        </li> 
                                                
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">===Administración de becas===</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="107_agregar_oferta_de_beca.jsp">Agregar oferta de beca</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="108_modificar_oferta_de_beca.jsp">Modificar oferta de beca</a>
                        </li> 
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="109_consultar_oferta_de_beca.jsp">Consultar oferta de beca</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="110_eliminar_oferta_de_beca.jsp">Eliminar oferta de beca</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="111_reporte_de_beca.jsp">Reporte de oferta de becas</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">===Administración de becarios===</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="201_consultar_expediente.jsp">Consultar expediente</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="202_modificar_estado_de_becario.jsp">Modificar estado de becario</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="203_suspender_becario.jsp">Suspender becario</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">===Administración de instituciones===</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="204_agregar_institucion.jsp">Agregar institución</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="205_modificar_institucion.jsp">Modificar institución</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="206_consultar_institucion.jsp">Consultar institución</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="207_eliminar_institucion.jsp">Eliminar institución</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">===Administración de documentos===</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="208_agregar_documento.jsp">Agregar documento</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="209_modificar_documento.jsp">Modificar documento</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="210_consultar_documento.jsp">Consultar documento</a>
                        </li>
                        
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="211_eliminar_documento.jsp">Eliminar documento</a>
                        </li>
                        
                    </ul>
                </li>
            </ul>
            
              

            <ul class="nav navbar-nav">
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Información pública<strong class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Ofertas de becas</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Documentos</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Acerca de</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Login/Logout</a>
                        </li>
                    </ul>
                </li>
            </ul>

            
            
            <ul class="nav navbar-nav">
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Candidatos<strong class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Ofertas de becas</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Estado de solicitudes</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Estado de proceso de beca</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitud de Permiso Inicial</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitud de autorizacion inicial</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitud de dictamen de propuesta</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitud de beca</a>
                        </li>
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav">
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Becarios<strong class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitud acuerdo de año fiscal</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitud prorroga</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Agregar documentos de finalizacion de beca</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitar inicio de servicio contractual</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitar acuerdo de gestion de compromiso contractual</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitar Acuerdo de gestion de liberacion</a>
                        </li>                                   
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav">
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Solicitudes y acuerdos<strong class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">===Comision de Becas===</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitudes de dictamenes pendientes</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Resolver solicitudes de dictamenes pendientes</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Buscar dictamenes emitidos</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">===Junta Directiva===</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitudes de acuerdos pendientes</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Resolver solicitudes de acuerdos</a>
                        </li>                                    
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Buscar acuerdos emitidos</a>
                        </li>                                    
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">===Consejo Superior Universitario===</a>
                        </li>                                    
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitudes de acuerdos pendientes</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Resolver solicitudes de acuerdos</a>
                        </li>                                    
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Buscar acuerdos emitidos</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">===Fiscalia===</a>
                        </li>                                    
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitudes de asesorias de contrato de beca</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Resolver solicitudes de asesoria de contrato de beca</a>
                        </li>                                    
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitudes de reintegracion de beca</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Buscar contrato de beca</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Buscar acta de reintegro de beca</a>
                        </li>
                    </ul>
                </li>
            </ul>

            <ul class="nav navbar-nav">
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Consejo de Becas<strong class="caret"></strong></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Solicitudes de acuerdos pendientes</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Resolver solicitud de acuerdo pendiente</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Buscar acuerdo</a>
                        </li>
                        <li>
                            <a style='background-color: #cf2a27; color:white' href="#">Reportes</a>
                        </li>                                    
                    </ul>
                </li>
            </ul>

            -->
            
            <ul class="nav navbar-nav navbar-right">						
                <li>
                    <a href="logout.jsp">Salir</a>
                </li>                            
            </ul>
            
            
            
        </div>
    </nav>


</head>

</html>

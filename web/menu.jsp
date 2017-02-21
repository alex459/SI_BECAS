<%-- 
    Document   : menu
    Created on : 10-17-2016, 06:49:53 AM
    Author     : next
--%>

<%@page import="MODEL.Utilidades"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <%@page import="MODEL.variablesDeSesion"%>
        <%
            boolean menuValido = false;
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


        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
            </button> <a class="navbar-brand active" href="principal.jsp">-</a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <%                //menu administracion                
                if (t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                    menuValido = true;
                    out.write("<ul class='nav navbar-nav'>");
                    out.write("<li class='dropdown'>");
                    out.write("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Administración<strong class='caret'></strong></a>");
                    out.write("<ul class='dropdown-menu'>");

                    out.write("<li><a style='background: #cc0000; color:white' href='#' ><b><center>Administración de usuarios</center></b></a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='101_agregar_usuario.jsp'>Agregar Usuario</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='112_consulta_para_actualizar_usuario.jsp'>Actualizar Usuarios</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='103_consultar_usuario.jsp'>Consultar Usuarios</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='113_consulta_para_dar_de_baja_usuario.jsp'>Dar de Baja Usuarios</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='114_consulta_para_modificar_roles.jsp'>Modificar Roles</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='106_bitacora.jsp'>Bitácora</a></li>");
                    out.write("<li><a style='background: #cc0000; color:white' href='#'><b><center>Administración de Becas</center></b></a></li>");
                    if (t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='107_agregar_oferta_de_beca.jsp'>Agregar Oferta de Beca</a></li>");
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='109_consultar_oferta_de_beca.jsp'>Consultar/Modificar Oferta de Beca</a></li>");
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='110_eliminar_oferta_de_beca.jsp'>Deshabilitar Oferta de Beca</a></li>");
                    }

                    if (t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='111_reporte_de_beca.jsp'>Reporte de Oferta de Becas</a></li>");
                    }
                    if (t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background: #cc0000; color:white' href='#'><b></center>Administración de Becarios</center></b></a></li>");
                    }
                    if (t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='201_consultar_expediente.jsp'>Consultar Expediente</a></li>");
                    }
                    if (t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='202_consulta_modificar_estado_de_becario.jsp'>Modificar estado de becario</a></li>");
                    }
                    if (t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='203_consulta_suspender_becario.jsp'>Suspender Becario</a></li>");
                    }
                    out.write("<li><a style='background: #cc0000; color:white' href='#'><b><center>Administración de Instituciones</center></b></a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='204_agregar_institucion.jsp'>Agregar Institución</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='213_consulta_para_modificar_institucion.jsp'>Modificar Institución</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='206_consultar_institucion.jsp'>Consultar Institución</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='214_consulta_para_eliminar_institucion.jsp'>Eliminar Institución</a></li>");
                    out.write("<li><a style='background: #cc0000; color:white' href='#'><b><center>Administración de Documentos</center></b></a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='208_agregar_documento.jsp'>Agregar Documento</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='209_modificar_documento.jsp'>Modificar Documento</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='210_consultar_documento.jsp'>Consultar Documento</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='211_eliminar_documento.jsp'>Eliminar Documento</a></li>");

                    out.write("</ul>");
                    out.write("</li>");
                    out.write("</ul>");
                }

                //menu de candidatos. todos menos el becarios
                if (t == id_candidato || t == id_director_consejo || t == id_admin) {
                    menuValido = true;
                    out.write("<ul class='nav navbar-nav'>");
                    out.write("<li class='dropdown'>");
                    out.write("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Candidatos<strong class='caret'></strong></a>");
                    out.write("<ul class='dropdown-menu'>");

                    out.write("<li><a style='background-color: #cf2a27; color:white' href='301_inf_publica_ofertas_beca.jsp'>Ofertas de Becas</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='303_candidato_estado_solicitudes.jsp'>Estado de Solicitudes</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='305_candidato_estado_proceso.jsp'>Estado de Proceso de Beca</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='304_candidato_sol_permiso_inicial.jsp'>Solicitud de Permiso de Gestión de Beca</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='306_candidato_sol_autorizacion_inicial.jsp'>Solicitud de Autorización Inicial</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='307_candidato_sol_dictamen_propuesta.jsp'>Solicitud de Dictamen de Propuesta</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='308_candidato_sol_beca1.jsp'>Solicitud de Beca</a></li>");

                    out.write("</ul>");
                    out.write("</li>");
                    out.write("</ul>");
                }

                //menu de Becarios
                if (t == id_becario || t == id_director_consejo || t == id_admin) {
                    menuValido = true;
                    out.write("<ul class='nav navbar-nav'>");
                    out.write("<li class='dropdown'>");
                    out.write("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Becarios<strong class='caret'></strong></a>");
                    out.write("<ul class='dropdown-menu'>");

                    out.write("<li><a style='background-color: #cf2a27; color:white' href='400_Becario_Solicitudes.jsp'>Estado de Solicitudes</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='401_Becario_Sol_Acuerdo_Anio_Fiscal.jsp'>Solicitud Acuerdo de Año Fiscal</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='402_Becario_Sol_Prorroga.jsp'>Solicitud Prórroga</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='801_agregar_documento_finalizacion_beca.jsp'>Agregar Documentos de Finalización de Beca</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='802_solicitar_inicio_de_servicio_contractual.jsp'>Solicitar Inicio de Servicio Contractual</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='803_solicitar_acuerdo_de_gestion_de_compromiso_contractual.jsp'>Solicitar Acuerdo de Gestión de Compromiso Contractual</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='804_solicitar_acuerdo_de_gestion_de_liberacion.jsp'>Solicitar Acuerdo de Gestión de Liberación</a></li>");

                    out.write("</ul>");
                    out.write("</li>");
                    out.write("</ul>");
                }

                //menu de Solicitudes y acuerdos
                if (t == id_comision || t == id_junta || t == id_csu || t == id_fiscalia || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                    menuValido = true;
                    out.write("<ul class='nav navbar-nav'>");
                    out.write("<li class='dropdown'>");
                    out.write("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Solicitudes y acuerdos<strong class='caret'></strong></a>");
                    out.write("<ul class='dropdown-menu'>");

                    if (t == id_comision || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background: #cc0000; color:white' href='#'><b><center>Comision de Becas</center></b></a></li>");
                    }
                    if (t == id_comision || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='407_Comision_Becas_Solicitud_Acuerdos_Pendientes.jsp'>Solicitudes de Dictamenes Pendientes</a></li>");
                    }
                    if (t == id_comision || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='409_Comision_Becas_Buscar_Acuerdo.jsp'>Buscar Dictamenes Emitidos</a></li>");
                    }
                    if (t == id_junta || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background: #cc0000; color:white' href='#'><b><center>Junta Directiva</center></b></a></li>");
                    }
                    if (t == id_junta || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='410_Junta_Directiva_Solicitud_Acuerdos_Pendientes.jsp'>Solicitudes de Acuerdos Pendientes</a></li>");
                    }
                    if (t == id_junta || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='412_Junta_Directiva_Buscar_Acuerdos.jsp'>Buscar Acuerdos Emitidos</a></li>");
                    }
                    if (t == id_csu || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background: #cc0000; color:white' href='#'><b><center>Consejo Superior Universitario</center></b></a></li>");
                    }
                    if (t == id_csu || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='413_Consejo_Superior_Universitario_Solicitud_Acuerdos_Pendientes.jsp'>Solicitudes de Acuerdos Pendientes</a></li>");
                    }
                    if (t == id_csu || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='415_Consejo_Superior_Universitario_Buscar_Acuerdos.jsp'>Buscar Acuerdos Emitidos</a></li>");
                    }
                    if (t == id_fiscalia || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background: #cc0000; color:white' href='#'><b><center>Fiscalia</center></b></a></li>");
                    }
                    if (t == id_fiscalia || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='501_Solicitudes_Asesoria_Contrato.jsp'>Solicitudes de Asesorias de Contrato de Beca</a></li>");
                    }
                    if (t == id_fiscalia || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='505_Buscar_Contrato.jsp'>Buscar Contrato de Beca</a></li>");
                    }
                    if (t == id_fiscalia || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='503_Solicitudes_Reintegro_Beca.jsp'>Solicitud de Reintegro de Beca</a></li>");
                    }
                    if (t == id_fiscalia || t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                        out.write("<li><a style='background-color: #cf2a27; color:white' href='506_Buscar_Acta_Reintegro.jsp'>Buscar Acta de Reintegro de Beca</a></li>");
                    }

                    out.write("</ul>");
                    out.write("</li>");
                    out.write("</ul>");
                }

                //menu de consejo de becas
                if (t == id_colaborador_consejo || t == id_director_consejo || t == id_admin) {
                    menuValido = true;
                    out.write("<ul class='nav navbar-nav'>");
                    out.write("<li class='dropdown'>");
                    out.write("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>Consejo de Becas<strong class='caret'></strong></a>");
                    out.write("<ul class='dropdown-menu'>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='507_Consejo_Becas_Solicitudes_Pendientes.jsp'>Solicitudes de Acuerdos Pendientes</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='520_Solicitudes_de_Inicio_Beca.jsp'>Solicitudes de Inicio de Beca</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='509_Consejo_Becas_Buscar_Acuerdo.jsp'>Buscar Acuerdo</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='518_Solicitudes_de_Cierre_de_Expediente.jsp'>Solicitudes de Cierre de Expediente</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='510_Reportes.jsp'>Reportes</a></li>");
                    out.write("<li><a style='background-color: #cf2a27; color:white' href='522_Becas_Expiradas.jsp'>Becas Expiradas</a></li>");
                    out.write("</ul>");
                    out.write("</li>");
                    out.write("</ul>");
                }

                if (!menuValido) {
                    response.sendRedirect("logout.jsp");
                }

            %>

            <ul class="nav navbar-nav navbar-right">						
                <li>
                    <a href="logout.jsp">Salir</a>
                </li>                            
            </ul>



        </div>
    </nav>


</head>

</html>

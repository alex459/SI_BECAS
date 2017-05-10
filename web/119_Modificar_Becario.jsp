<%-- 
    Document   : 119_Modificar_Becario
    Created on : 20/03/2017, 09:24:56 AM
    Author     : adminPC
--%>
<%@page import="POJO.Documento"%>
<%@page import="DAO.DocumentoDAO"%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page import="POJO.Expediente"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="DAO.BecaDAO"%>
<%@page import="POJO.Beca"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="POJO.Institucion"%>
<%@page import="POJO.OfertaBeca"%>
<%@page import="DAO.OfertaBecaDAO"%>
<!-- inicio proceso de seguridad de login -->
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
    request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
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
    tipo_usuarios_permitidos.add("7");
    tipo_usuarios_permitidos.add("8");
    tipo_usuarios_permitidos.add("9");
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!-- fin de proceso de seguridad de login -->

<!--Recuperacion de datos -->
<%
    String nombre1 = "";
    String nombre2 = "";
    String apellido1 = "";
    String apellido2 = "";
    String nombreCompleto = "";
    String estado = "";
    ArrayList<OfertaBeca> ofertas = new ArrayList();
    int id_Expediente = 0;
    Institucion institucionEstudio = new Institucion();
    Institucion institucionOferente = new Institucion();
    String pais = "";
    OfertaBecaDAO ofertaDao = new OfertaBecaDAO();
    OfertaBeca oferta = new OfertaBeca();
    InstitucionDAO institucionDao = new InstitucionDAO();
    Beca beca = new Beca();
    BecaDAO becaDao = new BecaDAO();
    String consultaSql = "SELECT DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, DU.CARNET, F.FACULTAD, TU.TIPO_USUARIO, U.ID_USUARIO, DU.ID_DETALLE_USUARIO  FROM DETALLE_USUARIO DU NATURAL JOIN USUARIO U NATURAL JOIN FACULTAD F NATURAL JOIN TIPO_USUARIO TU WHERE TU.TIPO_USUARIO IN ('CANDIDATO')";
    ConexionBD conexionbd = new ConexionBD();
    ResultSet rs = null;
    try {
        nombre1 = request.getParameter("nombre1");
        nombre2 = request.getParameter("nombre2");
        apellido1 = request.getParameter("apellido1");
        apellido2 = request.getParameter("apellido2");
        id_Expediente = Integer.parseInt(request.getParameter("id_Expediente"));
        if (nombre1.equals(null) || apellido1.equals(null)) {
            response.sendRedirect("Agregar_Becario_Consulta.jsp");
        }
        if (nombre2.equals(null)) {
            nombre2 = "";
        }
        if (apellido2.equals(null)) {
            apellido2 = "";
        }
        nombreCompleto = nombre1 + " " + nombre2 + " " + apellido1 + " " + apellido2;
        int idOferta = ofertaDao.consultarPorExpediente(id_Expediente);
        oferta = ofertaDao.consultarPorId(idOferta);
        institucionEstudio = institucionDao.consultarPorId(oferta.getIdInstitucionEstudio());
        institucionOferente = institucionDao.consultarPorId(oferta.getIdInstitucionFinanciera());
        beca = becaDao.consultarPorExpediente(id_Expediente);
        rs = conexionbd.consultaSql(consultaSql);
        ofertas = ofertaDao.consultarTodos();
        Expediente expediente = new Expediente();
        ExpedienteDAO expedienteDao = new ExpedienteDAO();
        expediente = expedienteDao.consultarPorId(id_Expediente);
        switch (expediente.getIdProgreso()) {
            case 9:
                estado = "estudio";
                break;
            case 12:
                estado = "servicio";
                break;
            case 13:
                estado = "compromiso";
                break;
            case 14:
                estado = "liberacion";
                break;
            case 16:
                //Ver si es finalizada o reintegro
                break;
            case 23:
                estado = "reintegro";
                break;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("118_Modificar_Becario_Consulta.jsp");
    }
%>

<%
    DocumentoDAO documentoDao = new DocumentoDAO();
    ArrayList<Documento> lista = documentoDao.consultarFiscaliaContratoBeca(id_Expediente);
    int numero = 1;

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

        <jsp:include page="cabecera.jsp"></jsp:include>



        <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>

    </head>
    <body ng-app="ModificarBecaApp" ng-controller="ModificarBecaCtrl">
        <!--TITULO DE PANTALLA-->
        <h3 class="text-center" style="color:#cf2a27">
            Modificar Becario
        </h3>
        <!--FIN TITULO DE PANTALLA-->
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <fieldset class="custom-border">
                    <legend class="custom-border">Modificar Becario</legend>
                    <div class="row">
                        <!--Tabla-->
                        <div class="col-md-12">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td>Becario: </td>
                                        <td><%=nombreCompleto%></td>
                                    <td>Expediente: </td>
                                    <td><%=id_Expediente%></td>
                                </tr>

                                <tr>
                                    <td>Título de Beca: </td>
                                    <td><%=oferta.getNombreOferta()%></td>
                                    <td>País: </td>
                                    <td><%=institucionEstudio.getPais()%></td>
                                </tr>

                                <tr>
                                    <td>Institución de Estudio:</td>
                                    <td><%=institucionEstudio.getNombreInstitucion()%></td>
                                    <td>Institución Oferente: </td>
                                    <td><%=institucionOferente.getNombreInstitucion()%></td>
                                </tr>

                                <tr>
                                    <td>Fecha de Inicio:</td>
                                    <td><%=beca.getFechaInicio()%></td>
                                    <td>Fecha de Fin:</td>
                                    <td><%=beca.getFechaFin()%></td>
                                </tr>

                            </tbody>    
                        </table>
                    </div>
                    <!--Fin Tabla-->
                </div>

                <div class="row">
                    <!--Opciones-->
                    <div class="row">
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Seleccione Opción a Modificar</legend>
                                <div class="col-md-1"></div>
                                <div class="col-md-5">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-7">
                                        <label class="form-control-static">Becario</label>
                                    </div>
                                    <div class="col-md-1">
                                        <input type="radio" name="opcion" class="form-control" value="becario" ng-click="seleccionarBecario()" ng-model="accion">
                                    </div>
                                    <div class="col-md-1"></div>
                                </div>
                                <div class="col-md-5">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-7">
                                        <label class="form-control-static">Expediente</label>
                                    </div>
                                    <div class="col-md-1">
                                        <input type="radio" name="opcion" class="form-control" value="expediente" ng-click="seleccionarExpediente()" ng-model="accion">
                                    </div>
                                    <div class="col-md-1"></div>
                                </div>
                                <div class="col-md-1"></div>
                            </fieldset>
                        </div>
                        <div class="col-md-3"></div>                        
                    </div>
                    <!--Fin Opciones-->                   

                    <!--Editar Becario-->
                    <div class="row" ng-show="mostrarBecario">                        
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Seleccione el Candidato a Asignar la beca</legend>
                                <table id="tablaUsuarios" class="table table-bordered text-center">                      
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Nombre de Empleado</th>
                                            <th>Código de Usuario</th>
                                            <th>Facultad</th>
                                            <th>Tipo de Empleado</th>
                                            <th>Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>                            
                                        <%
                                            String usuarios_consultados = new String();
                                            try {

                                                Integer i = 0;
                                                while (rs.next()) {
                                                    i = i + 1;
                                                    out.write("<tr>");
                                                    out.write("<td>" + i + "</td>");
                                                    out.write("<td>" + rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4) + "</td>");
                                                    usuarios_consultados = usuarios_consultados.concat(rs.getString(5).toString() + ", ");
                                                    out.write("<td>" + rs.getString(5) + "</td>");
                                                    out.write("<td>" + rs.getString(6) + "</td>");
                                                    out.write("<td>" + rs.getString(7) + "</td>");
                                                    out.write("<td>");
                                                    out.write("<center>");
                                                    out.write("<form style='display:inline;' action='ModificarBecarioServlet' method='post' enctype='multipart/form-data'><input type='hidden' name='id_Expediente' value='" + id_Expediente + "'><input type='hidden' name='ID_USUARIO' value='" + rs.getString(8) + "'><input type='hidden' name='accion' value='becario'><input type='submit' class='btn btn-success' name='submit' value='Cambiar Becario'></form> ");
                                                    out.write("</center>");
                                                    out.write("</td>");
                                                    out.write("</tr>");
                                                }

                                            } catch (Exception ex) {
                                                System.out.println("error: " + ex);
                                            }

                                        %>
                                    </tbody>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-md-1"></div>                        
                    </div>
                    <!--Fin Editar Becario-->
                    
                    
                    <div class="row" ng-show="mostrarExpediente">
                        <fieldset class="custom-border">
                                    <legend class="custom-border">Documentos Adjuntados</legend>
                                    <table class="table table-bordered text-center">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>Documento</th>
                                                <th>Documento Digital</th>                                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <% for (int i = 0; i < lista.size(); i++) {%>
                                        <tr>
                                            <td><%=numero%></td>
                                            <td><%=lista.get(i).getIdTipoDocumento().getTipoDocumento()%></td>
                                            <td>
                                                <form action="verDocumentoConsejo" method="post" target="_blank">
                                                    <input type = "hidden" name="id" value="<%= lista.get(i).getIdDocumento()%>">
                                                    <input type="submit" class="btn btn-success" value="Ver Documento ">
                                                </form>
                                            </td>                                            
                                        </tr>
                                        <%numero=numero+1;}%>
                                    </tbody>
                                </table>
                            </fieldset>
                    </div>
                    <!--Editar Expediente-->
                    <div class="row" ng-show="mostrarExpediente">
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Modificar Expediente</legend>
                                <form action="ModificarBecarioServlet" method="post" name="agregarBecario" enctype="multipart/form-data" novalidate>                                   
                                    <div class="row" ng-init="fechaInicio = '<%=beca.getFechaInicio()%>'; fechaFin = '<%=beca.getFechaFin()%>'; oferta = '<%=oferta.getIdOfertaBeca()%>'; estado = '<%=estado%>';">

                                        <div class="row">                    
                                            <div class="col-md-12">
                                                <div class="col-md-2"></div>
                                                <div class="col-md-3">
                                                    <label>Seleccione la oferta de beca: </label><br>
                                                </div>
                                                <div class="col-md-5">

                                                    <select name="oferta" class="form-control" ng-model="oferta" ng-disabled="checkOferta" ng-required="!checkOferta">
                                                        <%                                                            for (int i = 0; i < ofertas.size(); i++) {
                                                                out.write("<option value=" + ofertas.get(i).getIdOfertaBeca() + ">" + ofertas.get(i).getNombreOferta() + "</option>");
                                                            }
                                                        %>    
                                                    </select> 
                                                    <span class="text-danger" ng-show="agregarBecario.oferta.$error.required">Seleccione una Oferta.</span>
                                                    <br>
                                                </div>
                                                <div class="col-md-2"></div>
                                            </div>                                            
                                        </div>  
                                        <div class="row">                    
                                            <div class="col-md-6">
                                                <div class="col-md-4">
                                                    <label>Fecha de Inicio de Beca: </label><br>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="input-group date">
                                                        <input type="text" name="fechaInicio" id="fechaInicio" class="form-control" ng-model="fechaInicio" ng-required="true"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="fechaInicio"></i></span>
                                                    </div> 
                                                    <span class="text-danger" ng-show="agregarBecario.fechaInicio.$error.required">Seleccione la Fecha de Inicio de Beca.</span><br>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="col-md-4">
                                                    <label>Fecha de Fin Beca: </label><br>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="input-group date">
                                                        <input type="text" name="fechaFin" id="fechaFin" class="form-control" ng-model="fechaFin" ng-required="true"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="fechaFin"></i></span>
                                                    </div>    
                                                    <span class="text-danger" ng-show="agregarBecario.fechaFin.$error.required">Seleccione la Fecha de Fin de Beca.</span><br>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-2"></div>
                                            <div class="col-md-8">
                                                <fieldset class="custom-border">
                                                    <legend class="custom-border">Estado de la Beca</legend>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Realización de Estudio</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="estudio" ng-click="activarEstudio()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Servicio Contractual</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="servicio" ng-click="activarContractual()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Gestión de Compromiso Contractual</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="compromiso" ng-click="activarCompromiso()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Gestión de Liberación</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="liberacion" ng-click="activarLiberacion()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Beca Finalizada</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="becaFinalizada" ng-click="activarBecaFinalizada()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Reintegro de Beca</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="reintegro" ng-click="activarEstudio()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Finalizada por Reintegro de Beca</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="finReintegro" ng-click="activarFinReintegro()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row text-center">
                                                        <span class="text-danger" ng-show="agregarBecario.estado.$error.required">Seleccione el estado de la beca.</span><br>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-md-2"></div>
                                        </div> 
                                    </div>

                                    <div class="row">
                                        <fieldset class="custom-border">
                                            <legend class="custom-border">Documentos</legend>
                                            <div class="row"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acuerdo de Permiso de Gestion de Beca:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accpermisoGestion"  value="ninguna"  ng-model ="accpermisoGestion" ng-required="true" ng-click="NadapermisoGestion()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accpermisoGestion"  value="actualizar"  ng-model ="accpermisoGestion" ng-required="true" ng-click="ActualizarpermisoGestion()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostrarpermisoGestion">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="permisoGestion" accept="application/pdf" ng-model="permisoGestion" valid-file ng-required="mostrarpermisoGestion">
                                                        <span class="text-danger" ng-show="agregarBecario.permisoGestion.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acuerdo de Autorización inicial:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accautorizacionInicial"  value="ninguna"  ng-model ="accautorizacionInicial" ng-required="true" ng-click="NadaautorizacionInicial()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accautorizacionInicial"  value="actualizar"  ng-model ="accautorizacionInicial" ng-required="true" ng-click="ActualizarautorizacionInicial()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostrarautorizacionInicial">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="autorizacionInicial" accept="application/pdf" ng-model="autorizacionInicial" valid-file ng-required="mostrarautorizacionInicial">
                                                        <span class="text-danger" ng-show="agregarBecario.autorizacionInicial.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Dictamen de Propuesta ante Junta Directiva:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accdictamen"  value="ninguna"  ng-model ="accdictamen" ng-required="true" ng-click="Nadadictamen()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accdictamen"  value="actualizar"  ng-model ="accdictamen" ng-required="true" ng-click="Actualizardictamen()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostrardictamen">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="dictamen" accept="application/pdf" ng-model="dictamen" valid-file ng-required="mostrardictamen">
                                                        <span class="text-danger" ng-show="agregarBecario.dictamen.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acuerdo de Permiso de Beca de Junta Directiva:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoBecaJD"  value="ninguna"  ng-model ="accacuerdoBecaJD" ng-required="true" ng-click="NadaacuerdoBecaJD()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoBecaJD"  value="actualizar"  ng-model ="accacuerdoBecaJD" ng-required="true" ng-click="ActualizaracuerdoBecaJD()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostraracuerdoBecaJD">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="acuerdoBecaJD" accept="application/pdf" ng-model="acuerdoBecaJD" valid-file ng-required="mostraracuerdoBecaJD">
                                                        <span class="text-danger" ng-show="agregarBecario.acuerdoBecaJD.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acuerdo de Otorgamiento de Beca:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoBecaCNB"  value="ninguna"  ng-model ="accacuerdoBecaCNB" ng-required="true" ng-click="NadaacuerdoBecaCNB()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoBecaCNB"  value="actualizar"  ng-model ="accacuerdoBecaCNB" ng-required="true" ng-click="ActualizaracuerdoBecaCNB()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostraracuerdoBecaCNB">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="acuerdoBecaCNB" accept="application/pdf" ng-model="acuerdoBecaCNB" valid-file ng-required="mostraracuerdoBecaCNB">
                                                        <span class="text-danger" ng-show="agregarBecario.acuerdoBecaCNB.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acuerdo de Permiso de Beca (CSU):</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoBecaCSU"  value="ninguna"  ng-model ="accacuerdoBecaCSU" ng-required="true" ng-click="NadaacuerdoBecaCSU()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoBecaCSU"  value="actualizar"  ng-model ="accacuerdoBecaCSU" ng-required="true" ng-click="ActualizaracuerdoBecaCSU()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostraracuerdoBecaCSU">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="acuerdoBecaCSU" accept="application/pdf" ng-model="acuerdoBecaCSU" valid-file ng-required="mostraracuerdoBecaCSU">
                                                        <span class="text-danger" ng-show="agregarBecario.acuerdoBecaCSU.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Contrato de Beca:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="acccontrato"  value="ninguna"  ng-model ="acccontrato" ng-required="true" ng-click="Nadacontrato()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="acccontrato"  value="actualizar"  ng-model ="acccontrato" ng-required="true" ng-click="Actualizarcontrato()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostrarcontrato">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="contrato" accept="application/pdf" ng-model="contrato" valid-file ng-required="mostrarcontrato">
                                                        <span class="text-danger" ng-show="agregarBecario.contrato.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verContractual"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Titulo Obtenido:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="acctituloObtenido"  value="ninguna"  ng-model ="acctituloObtenido" ng-required="true" ng-click="NadatituloObtenido()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="acctituloObtenido"  value="actualizar"  ng-model ="acctituloObtenido" ng-required="true" ng-click="ActualizartituloObtenido()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostrartituloObtenido">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="tituloObtenido" accept="application/pdf" ng-model="tituloObtenido" valid-file ng-required="mostrartituloObtenido">
                                                        <span class="text-danger" ng-show="agregarBecario.tituloObtenido.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verContractual"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Certificación De Notas:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="acccertificacionNotasFin"  value="ninguna"  ng-model ="acccertificacionNotasFin" ng-required="true" ng-click="NadacertificacionNotasFin()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="acccertificacionNotasFin"  value="actualizar"  ng-model ="acccertificacionNotasFin" ng-required="true" ng-click="ActualizarcertificacionNotasFin()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostrarcertificacionNotasFin">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="certificacionNotasFin" accept="application/pdf" ng-model="certificacionNotasFin" valid-file ng-required="mostrarcertificacionNotasFin">
                                                        <span class="text-danger" ng-show="agregarBecario.certificacionNotasFin.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verContractual"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acta De Evaluación De Tesis:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accactaEvaluacion"  value="ninguna"  ng-model ="accactaEvaluacion" ng-required="true" ng-click="NadaactaEvaluacion()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accactaEvaluacion"  value="actualizar"  ng-model ="accactaEvaluacion" ng-required="true" ng-click="ActualizaractaEvaluacion()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostraractaEvaluacion">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="actaEvaluacion" accept="application/pdf" ng-model="actaEvaluacion" valid-file ng-required="mostraractaEvaluacion">
                                                        <span class="text-danger" ng-show="agregarBecario.actaEvaluacion.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verContractual"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Constancia de Egresado:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accconstanciaEgresado"  value="ninguna"  ng-model ="accconstanciaEgresado" ng-required="true" ng-click="NadaconstanciaEgresado()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accconstanciaEgresado"  value="actualizar"  ng-model ="accconstanciaEgresado" ng-required="true" ng-click="ActualizarconstanciaEgresado()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostrarconstanciaEgresado">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="constanciaEgresado" accept="application/pdf" ng-model="constanciaEgresado" valid-file ng-required="mostrarconstanciaEgresado">
                                                        <span class="text-danger" ng-show="agregarBecario.constanciaEgresado.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verContractual"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acta De Toma De Posesión:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="acctomaPosesion"  value="ninguna"  ng-model ="acctomaPosesion" ng-required="true" ng-click="NadatomaPosesion()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="acctomaPosesion"  value="actualizar"  ng-model ="acctomaPosesion" ng-required="true" ng-click="ActualizartomaPosesion()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostrartomaPosesion">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="tomaPosesion" accept="application/pdf" ng-model="tomaPosesion" valid-file ng-required="mostrartomaPosesion">
                                                        <span class="text-danger" ng-show="agregarBecario.tomaPosesion.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verContractual"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Proyecto mediante el cual se compromete a multiplicar los conocimientos adquiridos durante la beca:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accproyecto"  value="ninguna"  ng-model ="accproyecto" ng-required="true" ng-click="Nadaproyecto()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accproyecto"  value="actualizar"  ng-model ="accproyecto" ng-required="true" ng-click="Actualizarproyecto()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostrarproyecto">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="proyecto" accept="application/pdf" ng-model="proyecto" valid-file ng-required="mostrarproyecto">
                                                        <span class="text-danger" ng-show="agregarBecario.proyecto.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verCompromiso"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Carta De Oficina De RRHH que cumplió con el tiempo acordado:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="acccartaRRHH"  value="ninguna"  ng-model ="acccartaRRHH" ng-required="true" ng-click="NadacartaRRHH()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="acccartaRRHH"  value="actualizar"  ng-model ="acccartaRRHH" ng-required="true" ng-click="ActualizarcartaRRHH()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostrarcartaRRHH">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="cartaRRHH" accept="application/pdf" ng-model="cartaRRHH" valid-file ng-required="mostrarcartaRRHH">
                                                        <span class="text-danger" ng-show="agregarBecario.cartaRRHH.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verLiberacion"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acuerdo de Gestión de Compromiso Contractual:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoGestionContractual"  value="ninguna"  ng-model ="accacuerdoGestionContractual" ng-required="true" ng-click="NadaacuerdoGestionContractual()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoGestionContractual"  value="actualizar"  ng-model ="accacuerdoGestionContractual" ng-required="true" ng-click="ActualizaracuerdoGestionContractual()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostraracuerdoGestionContractual">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="acuerdoGestionContractual" accept="application/pdf" ng-model="acuerdoGestionContractual" valid-file ng-required="mostraracuerdoGestionContractual">
                                                        <span class="text-danger" ng-show="agregarBecario.acuerdoGestionContractual.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verFinReintegro"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acta de Reintegro de Beca:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accactaReintegro"  value="ninguna"  ng-model ="accactaReintegro" ng-required="true" ng-click="NadaactaReintegro()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accactaReintegro"  value="actualizar"  ng-model ="accactaReintegro" ng-required="true" ng-click="ActualizaractaReintegro()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostraractaReintegro">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="actaReintegro" accept="application/pdf" ng-model="actaReintegro" valid-file ng-required="mostraractaReintegro">
                                                        <span class="text-danger" ng-show="agregarBecario.actaReintegro.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verFinReintegro"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acuerdo de Gestión de Liberación:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoGestionLiberacion2"  value="ninguna"  ng-model ="accacuerdoGestionLiberacion2" ng-required="true" ng-click="NadaacuerdoGestionLiberacion2()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoGestionLiberacion2"  value="actualizar"  ng-model ="accacuerdoGestionLiberacion2" ng-required="true" ng-click="ActualizaracuerdoGestionLiberacion2()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostraracuerdoGestionLiberacion2">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="acuerdoGestionLiberacion2" accept="application/pdf" ng-model="acuerdoGestionLiberacion2" valid-file ng-required="mostraracuerdoGestionLiberacion2">
                                                        <span class="text-danger" ng-show="agregarBecario.acuerdoGestionLiberacion2.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verFinReintegro"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acuerdo de Liberacion del Compromiso Contractual:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoLiberacion2"  value="ninguna"  ng-model ="accacuerdoLiberacion2" ng-required="true" ng-click="NadaacuerdoLiberacion2()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoLiberacion2"  value="actualizar"  ng-model ="accacuerdoLiberacion2" ng-required="true" ng-click="ActualizaracuerdoLiberacion2()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostraracuerdoLiberacion2">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="acuerdoLiberacion2" accept="application/pdf" ng-model="acuerdoLiberacion2" valid-file ng-required="mostraracuerdoLiberacion2">
                                                        <span class="text-danger" ng-show="agregarBecario.acuerdoLiberacion2.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verBecaFinalizada"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acuerdo de Gestión de Liberación:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoGestionLiberacion"  value="ninguna"  ng-model ="accacuerdoGestionLiberacion" ng-required="true" ng-click="NadaacuerdoGestionLiberacion()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoGestionLiberacion"  value="actualizar"  ng-model ="accacuerdoGestionLiberacion" ng-required="true" ng-click="ActualizaracuerdoGestionLiberacion()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostraracuerdoGestionLiberacion">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="acuerdoGestionLiberacion" accept="application/pdf" ng-model="acuerdoGestionLiberacion" valid-file ng-required="mostraracuerdoGestionLiberacion">
                                                        <span class="text-danger" ng-show="agregarBecario.acuerdoGestionLiberacion.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                            <div class="row" ng-show="verBecaFinalizada"><!--DOCUMENTO-->
                                                <div class="row">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-7">
                                                        <label class="form-control-static">Acuerdo de Liberacion del Compromiso Contractual:</label>
                                                    </div>   
                                                    <div class="col-md-4">
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoLiberacion"  value="ninguna"  ng-model ="accacuerdoLiberacion" ng-required="true" ng-click="NadaacuerdoLiberacion()">
                                                            Ninguna
                                                        </label>
                                                        <label class="radio-inline" for="radios-0">
                                                            <input type="radio" name="accacuerdoLiberacion"  value="actualizar"  ng-model ="accacuerdoLiberacion" ng-required="true" ng-click="ActualizaracuerdoLiberacion()">
                                                            Actualizar
                                                        </label> 
                                                    </div> 
                                                </div>                            
                                                <div class="row" ng-show="mostraracuerdoLiberacion">
                                                    <div class="col-md-1"></div>
                                                    <div class="col-md-11">
                                                        <input type="file" class="" name="acuerdoLiberacion" accept="application/pdf" ng-model="acuerdoLiberacion" valid-file ng-required="mostraracuerdoLiberacion">
                                                        <span class="text-danger" ng-show="agregarBecario.acuerdoLiberacion.$invalid">Debe ingresar un documento en formato PDF.</span>
                                                    </div>
                                                </div>
                                            </div><!-- FIN DOCUMENTO-->
                                        </fieldset>
                                    </div>
                                    <div class="row text-center">      
                                        <input type="hidden" name="accion" value="expediente"> 
                                        <input type="hidden" name="id_Expediente" value="<%=id_Expediente%>">                                                                                
                                        <input type="submit" name="guardar" value="Guardar" class="btn btn-success" ng-disabled="!agregarBecario.$valid">
                                    </div> 
                                </form>
                            </fieldset>
                        </div>
                        <div class="col-md-1"></div>
                    </div>         
                    <!--Fin Editar Expediente-->

                </div>
            </fieldset>

        </div>
        <div class="col-md-1"></div>
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
    <script src="js/angular.min.js"></script>
    <script src="js/modificarBecario.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript">
                                $(document).ready(function () {
                                    $('#tablaUsuarios').DataTable(
                                            {
                                                "language":
                                                        {
                                                            "sProcessing": "Procesando...",
                                                            "sLengthMenu": "Mostrar _MENU_ registros",
                                                            "sZeroRecords": "No se encontraron resultados",
                                                            "sEmptyTable": "Ningún dato disponible en esta tabla",
                                                            "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                                                            "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                                                            "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                                                            "sInfoPostFix": "",
                                                            "sSearch": "Buscar:",
                                                            "sUrl": "",
                                                            "sInfoThousands": ",",
                                                            "sLoadingRecords": "Cargando...",
                                                            "oPaginate": {
                                                                "sFirst": "Primero",
                                                                "sLast": "Último",
                                                                "sNext": "Siguiente",
                                                                "sPrevious": "Anterior"
                                                            },
                                                            "oAria": {
                                                                "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                                                                "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                                                            }
                                                        }
                                            }
                                    );
                                });

    </script>
</body>
</html>

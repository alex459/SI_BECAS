<%-- 
    Document   : 412_Junta_Directiva_Buscar_Acuerdos
    Created on : 11-09-2016, 09:41:03 PM
    Author     : aquel
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="MODEL.AgregarOfertaBecaServlet"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.TipoDocumento"%>
<%@page import="DAO.TipoDocumentoDAO"%>
<%@page import="DAO.DetalleUsuarioDAO"%>
<%@page import="MODEL.variablesDeSesion"%>


<!-- inicio proceso de seguridad de login -->
<%@page import="MODEL.Utilidades"%>


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
    tipo_usuarios_permitidos.add("4");
    tipo_usuarios_permitidos.add("9");
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
    
    
    Integer idFacultad = 0;    
    AgregarOfertaBecaServlet OfertaServlet = new AgregarOfertaBecaServlet();
    try {
        DetalleUsuarioDAO DetUsDao = new DetalleUsuarioDAO();
        // Obtener la facultad a la que pertenece el usuario
        idFacultad = DetUsDao.obtenerFacultad(user);
        
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
        <%
        %>
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
        <body ng-app="solicitudAcuerdosPendientesJuntaDirectivaApp" ng-controller="solicitudAcuerdosPendientesJuntaDirectivaCtrl">

            <div class="container-fluid">
                <H3 class="text-center" style="color:#E42217;">Buscar Acuerdo Emitidos</H3>
                <fieldset class="custom-border">
                    <legend class="custom-border">Acuerdos</legend>


                    <form name="solicitudAcuerdosPendientesJuntaDirectiva" class="form-horizontal" action="412_Junta_Directiva_Buscar_Acuerdos.jsp" method="post" novalidate>

                        <div class="row">      <!-- FILTROS -->
                            <div class="col-md-2"></div>
                            <div class="col-md-8"> 

                                <fieldset class="custom-border">
                                    <legend class="custom-border">Filtros</legend>

                                    <div class="row"> 
                                        <div class="col-md-12">   
                                            <label for="textinput">Solicitante: </label>                                                                                      
                                        </div>

                                        <div class="col-md-12">    

                                            <div class="row">

                                                <div class="col-md-3">                                                                                    
                                                    <input id="NOMBRE1" name="NOMBRE1" type="text" placeholder="Primer Nombre" class="form-control input-md" ng-model="datos.nombre1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                    <span class="text-danger" ng-show="solicitudAcuerdosPendientesJuntaDirectiva.NOMBRE1.$error.minlength">Mínimo 3 Caracteres.</span>
                                                    <span class="text-danger" ng-show="solicitudAcuerdosPendientesJuntaDirectiva.NOMBRE1.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>

                                                </div>

                                                <div class="col-md-3">    
                                                    <input id="NOMBRE2" name="NOMBRE2" type="text" placeholder="Segundo Nombre" class="form-control input-md" ng-model="datos.nombre2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                    <span class="text-danger" ng-show="solicitudAcuerdosPendientesJuntaDirectiva.NOMBRE2.$error.minlength">Mínimo 3 Caracteres.</span>
                                                    <span class="text-danger" ng-show="solicitudAcuerdosPendientesJuntaDirectiva.NOMBRE2.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                                                </div> 
                                                <div class="col-md-3">
                                                    <input id="APELLIDO1" name="APELLIDO1" type="text" placeholder="Primer Apellido" class="form-control input-md" ng-model="datos.apellido1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                    <span class="text-danger" ng-show="solicitudAcuerdosPendientesJuntaDirectiva.APELLIDO1.$error.minlength">Mínimo 3 Caracteres.</span>
                                                    <span class="text-danger" ng-show="solicitudAcuerdosPendientesJuntaDirectiva.APELLIDO1.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span>
                                                </div> 
                                                <div class="col-md-3">
                                                    <input id="APELLIDO2" name="APELLIDO2" type="text" placeholder="Segundo Apellido" class="form-control input-md" ng-model="datos.apellido2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">
                                                    <span class="text-danger" ng-show="solicitudAcuerdosPendientesJuntaDirectiva.APELLIDO2.$error.minlength">Mínimo 3 Caracteres.</span>
                                                    <span class="text-danger" ng-show="solicitudAcuerdosPendientesJuntaDirectiva.APELLIDO2.$error.pattern">Solo se Permiten Letras Mayúsculas.. (A-Z).</span>
                                                </div>

                                            </div> 
                                            <div class="col-md-3 text-right"></div> 
                                        </div>
                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-6">   
                                            <label for="textinput">Código de Usuario: </label>  
                                            <input id="CARNET" name="CARNET" type="text" placeholder="Ingrese el usuario a buscar" class="form-control input-md" ng-model="datos.codigo" ng-pattern="/^[A-Z0-9]*$/" minlength="7" maxlength="7">
                                            <span class="text-danger" ng-show="solicitudAcuerdosPendientesJuntaDirectiva.CARNET.$error.minlength">Mínimo 7 Caracteres.</span>
                                            <span class="text-danger" ng-show="solicitudAcuerdosPendientesJuntaDirectiva.CARNET.$error.pattern">Solo se Permiten Letras Mayúsculas y Números. (A-Z, 0-9).</span>
                                            <small id="help5"></small>
                                        </div>

                                         <div class="col-md-6 ">
                                        <div class="col-md-6">          
                                            <label for="fIngresoIni">Fecha Resolución (Inicio) :</label> 
                                            <div class="input-group date">
                                                <input type="text" name="fIngresoIni" id="fIngresoIni" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">      
                                            <label for="fIngresoFin">Fecha de Resolución (Fin) :</label>
                                            <div class="input-group date">
                                                <input type="text" name="fIngresoFin" id="fIngresoFin" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ></i></span>
                                            </div>
                                        </div>
                                    </div>

                                    </div>
                                    <br>
                                    <div class="row">
                                        <div class="col-md-6">  
                                            <label for="textinput">Tipo de Documento :</label>  
                                            <select id="selectbasic" name="ID_TIPO_DOCUMENTO" class="form-control">
                                                <option value="0">Consultar Tipo Documento</option>    
                                            <%
                                                TipoDocumentoDAO tipoDocumentoDao = new TipoDocumentoDAO();
                                                ArrayList<TipoDocumento> listaTipoDocumento = new ArrayList<TipoDocumento>();
                                                listaTipoDocumento = tipoDocumentoDao.consultarPorDepartamento("JUNTA DIRECTIVA");
                                                for (int i = 0; i < listaTipoDocumento.size(); i++) {
                                                    out.write("<option value=" + listaTipoDocumento.get(i).getIdTipoDocumento() + ">" + listaTipoDocumento.get(i).getTipoDocumento() + "</option>");
                                                }
                                            %>                    
                                        </select>
                                    </div>
                                </div>
                                <br>
                                <div class="row text-center"> 
                                    <input type="submit" class="btn btn-primary" name="submit" value="Buscar" ng-disabled="!solicitudAcuerdosPendientesJuntaDirectiva.$valid">
                                </div>
                            </fieldset>

                        </div>

                    </div>
                </form>


                <%
                    response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
                    request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
                    String nombre1;
                    String nombre2;
                    String apellido1;
                    String apellido2;
                    String carnet;
                    Integer id_tipo_documento;
                    String documento;
                   
                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                    ConexionBD conexionbd = null;

                    ResultSet rs = null;

                    //formando la consulta
                    //out.write(consultaSql);
                    //realizando la consulta
                    try {

                        nombre1 = request.getParameter("NOMBRE1");
                        nombre2 = request.getParameter("NOMBRE2");
                        apellido1 = request.getParameter("APELLIDO1");
                        apellido2 = request.getParameter("APELLIDO2");
                        carnet = request.getParameter("CARNET");
                        id_tipo_documento = Integer.parseInt(request.getParameter("ID_TIPO_DOCUMENTO"));
                        documento = request.getParameter("ID_TIPO_DOCUMENTO");
                        String consultaSql = "";
                        //String pendiente = "PENDIENTE";
                        String aprobado = "APROBADO";
                        String denegado = "DENEGADO";
                        String juntaD = "JUNTA DIRECTIVA";
                        
                        String fIngresoIni = request.getParameter("fIngresoIni");
                        String fIngresoFin = request.getParameter("fIngresoFin");

                        if (nombre1 != null) {
                        } else {
                            nombre1 = "";
                        };
                        if (nombre2 != null) {
                        } else {
                            nombre2 = "";
                        };
                        if (apellido1 != null) {
                        } else {
                            apellido1 = "";
                        };
                        if (apellido2 != null) {
                        } else {
                            apellido2 = "";
                        };
                        if (carnet != null) {
                        } else {
                            carnet = "";
                        };
                    
                    
                        consultaSql = "SELECT U.NOMBRE_USUARIO, DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, IFNULL(DU.DEPARTAMENTO, ''), F.FACULTAD, D.FECHA_INGRESO, TD.TIPO_DOCUMENTO,D.ESTADO_DOCUMENTO , D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, E.ID_PROGRESO, E.ESTADO_PROGRESO, E.ESTADO_EXPEDIENTE FROM DETALLE_USUARIO DU JOIN FACULTAD F ON DU.ID_FACULTAD=F.ID_FACULTAD JOIN USUARIO U ON DU.ID_USUARIO=U.ID_USUARIO JOIN SOLICITUD_DE_BECA SB ON U.ID_USUARIO=SB.ID_USUARIO JOIN EXPEDIENTE E ON SB.ID_EXPEDIENTE=E.ID_EXPEDIENTE JOIN DOCUMENTO D ON D.ID_EXPEDIENTE=E.ID_EXPEDIENTE JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO=TD.ID_TIPO_DOCUMENTO WHERE D.ESTADO_DOCUMENTO IN ('APROBADO','DENEGADO','REVISION') AND TD.DEPARTAMENTO='" + juntaD + "' AND F.ID_FACULTAD='" + idFacultad + "' AND DU.NOMBRE1_DU LIKE '%" + nombre1 + "%' AND DU.NOMBRE2_DU LIKE '%" + nombre2 + "%' AND DU.APELLIDO1_DU LIKE '%" + apellido1 + "%' AND DU.APELLIDO2_DU LIKE '%" + apellido2 + "%' AND DU.CARNET LIKE '%" + carnet + "%' ";
                        
                        if (!fIngresoIni.isEmpty() && !fIngresoFin.isEmpty()) {
                            java.sql.Date sqlFIngresoIni = new java.sql.Date(OfertaServlet.StringAFecha(fIngresoIni).getTime());
                            java.sql.Date sqlFIngresoFin = new java.sql.Date(OfertaServlet.StringAFecha(fIngresoFin).getTime());
                            consultaSql = consultaSql.concat(" AND D.FECHA_INGRESO BETWEEN '" + sqlFIngresoIni + "' AND '" + sqlFIngresoFin + "' ");
                        }
                       
                        
                        if (id_tipo_documento == 0) {

                        } else {
                            consultaSql = consultaSql.concat(" AND TD.ID_TIPO_DOCUMENTO = " + id_tipo_documento);
                        }
                        
                        

                        conexionbd = new ConexionBD();
                        rs = conexionbd.consultaSql(consultaSql);
                        //con el rs se llenara la tabla de resultados

                    } catch (Exception ex) {
                    }

                %>    





                <div class="col-md-2"></div> 

                <div class="row">
                    <h5>Resultados</h5>
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                            <table  id="tablaResultados" class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>No.</th>
                                    <th>Código de Empleado</th>
                                    <th>Solicitante</th>
                                    <th>Unidad</th>
                                    <th>Fecha de Resolución</th>
                                    <th>Tipo de Acuerdo</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>  
                            </thead>
                            <tbody>
                                <%                                        try {
                                        Integer i = 0;
                                        int idTipoDoc = 0;
                                        int idProgreso =0;
                                        String estadoProgreso = "";
                                        String estadoExpediente ="";
                                        while (rs.next()) {
                                            i = i + 1;
                                            out.write("<tr>");
                                            out.write("<td>" + i + "</td>");
                                            out.write("<td>" + rs.getString(1) + "</td>");
                                            out.write("<td>" + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4) + " " + rs.getString(5) + "</td>");
                                            out.write("<td>" + rs.getString(6) + " " + rs.getString(7) + "</td>");
                                            out.write("<td>" + rs.getString(8) + "</td>");
                                            out.write("<td>" + rs.getString(9) + "</td>");
                                            out.write("<td>" + rs.getString(10) + "</td>");
                                            out.write("<td>");
                                            out.write("<center>");
                                            //SWIFT DE ID TIPO DOCUMENTO
                                            idTipoDoc = rs.getInt(12);
                                            idProgreso = rs.getInt(13);
                                            estadoProgreso = rs.getString(14);
                                            estadoExpediente = rs.getString(15);
                                            switch (idTipoDoc) {
                                                case 103:
                                                        if(estadoExpediente.equals("ABIERTO")){
                                                            //VERIFICAR PROGRESO
                                                            if(idProgreso == 1){
                                                                // ACUERDO DENEGADO O SE HA SOLICITADO REVISION
                                                                if(estadoProgreso.equals("REVISION") || estadoProgreso.equals("DENEGADO")){
                                                                    //EDITAR
                                                                    out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                }else{
                                                                    //SOLO VER DOCUMENTO
                                                                }
                                                            }else{
                                                                //ACUERDO APROBADO
                                                                //VER SI SE ENCUENTRA EN EL PROGRESO SIGUIENTE
                                                                if(idProgreso == 2){
                                                                    if(estadoProgreso.equals("PENDIENTE") || estadoProgreso.equals("EN PROCESO")){
                                                                        //NO SE HA REALIZADO O RESUELTO LA SOLICITUD DEL SIGUIENTE DOCUMENTO
                                                                        //MOSTRAR EDITAR
                                                                        out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                    }else{
                                                                        //YA NO SE PUEDE EDITAR
                                                                    }
                                                                }else{
                                                                    //PROGRESO AVANZADO NO SE PUEDE EDITAR
                                                                }
                                                            }
                                                        }else{
                                                            //SOLO VER DOCUMENTO
                                                        }
                                                        //BOTON PARA VER DOCUMENTO
                                                        out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(11) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");
                                                    break;
                                                case 120:
                                                        if(estadoExpediente.equals("ABIERTO")){
                                                            //VERIFICAR PROGRESO
                                                            if(idProgreso == 4){
                                                                // ACUERDO DENEGADO O SE HA SOLICITADO REVISION
                                                                if(estadoProgreso.equals("REVISION") || estadoProgreso.equals("DENEGADO")){
                                                                    //EDITAR
                                                                    out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                }else{
                                                                    //SOLO VER DOCUMENTO
                                                                }
                                                            }else{
                                                                //ACUERDO APROBADO
                                                                //VER SI SE ENCUENTRA EN EL PROGRESO SIGUIENTE
                                                                if(idProgreso == 5){
                                                                    if(estadoProgreso.equals("PENDIENTE") || estadoProgreso.equals("EN PROCESO")){
                                                                        //NO SE HA REALIZADO O RESUELTO LA SOLICITUD DEL SIGUIENTE DOCUMENTO
                                                                        //MOSTRAR EDITAR
                                                                        out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                    }else{
                                                                        //YA NO SE PUEDE EDITAR
                                                                    }
                                                                }else{
                                                                    //PROGRESO AVANZADO NO SE PUEDE EDITAR
                                                                }
                                                            }
                                                        }else{
                                                            //SOLO VER DOCUMENTO
                                                        }
                                                        //BOTON PARA VER DOCUMENTO
                                                        out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(11) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");
                                                    break;
                                                case 121:
                                                    
                                                        if(estadoExpediente.equals("ABIERTO")){
                                                            //VERIFICAR PROGRESO
                                                            if(idProgreso == 4){
                                                                // ACUERDO DENEGADO O SE HA SOLICITADO REVISION
                                                                if(estadoProgreso.equals("REVISION") || estadoProgreso.equals("DENEGADO")){
                                                                    //EDITAR
                                                                    out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                }else{
                                                                    //SOLO VER DOCUMENTO
                                                                }
                                                            }else{
                                                                //ACUERDO APROBADO
                                                                //VER SI SE ENCUENTRA EN EL PROGRESO SIGUIENTE
                                                                if(idProgreso == 5){
                                                                    if(estadoProgreso.equals("PENDIENTE") || estadoProgreso.equals("EN PROCESO")){
                                                                        //NO SE HA REALIZADO O RESUELTO LA SOLICITUD DEL SIGUIENTE DOCUMENTO
                                                                        //MOSTRAR EDITAR
                                                                        out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                    }else{
                                                                        //YA NO SE PUEDE EDITAR
                                                                    }
                                                                }else{
                                                                    //PROGRESO AVANZADO NO SE PUEDE EDITAR
                                                                }
                                                            }
                                                        }else{
                                                            //SOLO VER DOCUMENTO
                                                        }
                                                        //BOTON PARA VER DOCUMENTO
                                                        out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(11) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");
                                                    break;
                                                    
                                                case 136:
                                                    if(estadoExpediente.equals("ABIERTO")){
                                                            //VERIFICAR PROGRESO
                                                            if(idProgreso == 9){
                                                                // ACUERDO DENEGADO O SE HA SOLICITADO REVISION
                                                                if(estadoProgreso.equals("REVISION") || estadoProgreso.equals("DENEGADO")){
                                                                    //EDITAR
                                                                    out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                }else{
                                                                    //SOLO VER DOCUMENTO
                                                                }
                                                            }else{
                                                                //ACUERDO APROBADO
                                                                //VER SI SE ENCUENTRA EN EL PROGRESO SIGUIENTE
                                                                if(idProgreso == 12){
                                                                    if(estadoProgreso.equals("PENDIENTE") || estadoProgreso.equals("EN PROCESO")){
                                                                        //NO SE HA REALIZADO O RESUELTO LA SOLICITUD DEL SIGUIENTE DOCUMENTO
                                                                        //MOSTRAR EDITAR
                                                                        out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                    }else{
                                                                        //YA NO SE PUEDE EDITAR
                                                                    }
                                                                }else{
                                                                    //PROGRESO AVANZADO NO SE PUEDE EDITAR
                                                                }
                                                            }
                                                        }else{
                                                            //SOLO VER DOCUMENTO
                                                        }
                                                        //BOTON PARA VER DOCUMENTO
                                                        out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(11) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");
                                                    break;
                                                case 140:
                                                    if(estadoExpediente.equals("ABIERTO")){
                                                            //VERIFICAR PROGRESO
                                                            if(idProgreso == 9 || idProgreso == 20){
                                                                // ACUERDO DENEGADO O SE HA SOLICITADO REVISION
                                                                if(estadoProgreso.equals("REVISION") || estadoProgreso.equals("DENEGADO")){
                                                                    //EDITAR
                                                                    out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                }else{
                                                                    //SOLO VER DOCUMENTO
                                                                }
                                                            }else{
                                                                //ACUERDO APROBADO
                                                                //VER SI SE ENCUENTRA EN EL PROGRESO SIGUIENTE
                                                                if(idProgreso == 21){
                                                                    if(estadoProgreso.equals("PENDIENTE") || estadoProgreso.equals("EN PROCESO")){
                                                                        //NO SE HA REALIZADO O RESUELTO LA SOLICITUD DEL SIGUIENTE DOCUMENTO
                                                                        //MOSTRAR EDITAR
                                                                        out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                    }else{
                                                                        //YA NO SE PUEDE EDITAR
                                                                    }
                                                                }else{
                                                                    //PROGRESO AVANZADO NO SE PUEDE EDITAR
                                                                }
                                                            }
                                                        }else{
                                                            //SOLO VER DOCUMENTO
                                                        }
                                                        //BOTON PARA VER DOCUMENTO
                                                        out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(11) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");
                                                    break;
                                                case 151:
                                                    if(estadoExpediente.equals("ABIERTO")){
                                                            //VERIFICAR PROGRESO
                                                            if(idProgreso == 9 || idProgreso == 12){
                                                                // ACUERDO DENEGADO O SE HA SOLICITADO REVISION
                                                                if(estadoProgreso.equals("REVISION") || estadoProgreso.equals("DENEGADO")){
                                                                    //EDITAR
                                                                    out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                }else{
                                                                    //SOLO VER DOCUMENTO
                                                                }
                                                            }else{
                                                                //ACUERDO APROBADO
                                                                //VER SI SE ENCUENTRA EN EL PROGRESO SIGUIENTE
                                                                if(idProgreso == 13){
                                                                    if(estadoProgreso.equals("PENDIENTE") || estadoProgreso.equals("EN PROCESO")){
                                                                        //NO SE HA REALIZADO O RESUELTO LA SOLICITUD DEL SIGUIENTE DOCUMENTO
                                                                        //MOSTRAR EDITAR
                                                                        out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                    }else{
                                                                        //YA NO SE PUEDE EDITAR
                                                                    }
                                                                }else{
                                                                    //PROGRESO AVANZADO NO SE PUEDE EDITAR
                                                                }
                                                            }
                                                        }else{
                                                            //SOLO VER DOCUMENTO
                                                        }
                                                        //BOTON PARA VER DOCUMENTO
                                                        out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(11) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");
                                                    break;
                                                case 155:
                                                    if(estadoExpediente.equals("ABIERTO")){
                                                            //VERIFICAR PROGRESO
                                                            if(idProgreso == 13){
                                                                // ACUERDO DENEGADO O SE HA SOLICITADO REVISION
                                                                if(estadoProgreso.equals("REVISION") || estadoProgreso.equals("DENEGADO")){
                                                                    //EDITAR
                                                                    out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                }else{
                                                                    //SOLO VER DOCUMENTO
                                                                }
                                                            }else{
                                                                //ACUERDO APROBADO
                                                                //VER SI SE ENCUENTRA EN EL PROGRESO SIGUIENTE
                                                                if(idProgreso == 14){
                                                                    if(estadoProgreso.equals("PENDIENTE") || estadoProgreso.equals("EN PROCESO")){
                                                                        //NO SE HA REALIZADO O RESUELTO LA SOLICITUD DEL SIGUIENTE DOCUMENTO
                                                                        //MOSTRAR EDITAR
                                                                        out.write("<form style='display:inline;' action='411_Junta_Directiva_Resolver_Solicitud.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(11) + "'><input type='hidden' name='ACCION' value='actualizar'><input type='submit' class='btn btn-danger' name='submit' value='Editar'></form> ");
                                                                    }else{
                                                                        //YA NO SE PUEDE EDITAR
                                                                    }
                                                                }else{
                                                                    //PROGRESO AVANZADO NO SE PUEDE EDITAR
                                                                }
                                                            }
                                                        }else{
                                                            //SOLO VER DOCUMENTO
                                                        }
                                                        //BOTON PARA VER DOCUMENTO
                                                        out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + rs.getString(11) + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Acuerdo'></form> ");
                                                    break;
                                            }
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
                    </div>
                    <div class="col-md-1"></div>
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


        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/angular.min.js"></script>
        <script src="js/scripts.js"></script>
        <script src="js/solicitudAcuerdosPendientesJuntaDirectiva.js"></script>
        <script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">
   $(document).ready(function() {
    $('#tablaResultados').DataTable(
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
} );
    
                                           $(function () {
        $('#fIngresoIni').datepicker({
            format: 'yyyy-mm-dd',
            calendarWeeks: true,
            todayHighlight: true,
            autoclose: true,
            endDate: '-0y'
        }).on('change.dp', function (e) {
            $('#fIngresoFin').datepicker('setStartDate', new Date($(this).val()));
        });
        $('#fIngresoFin').datepicker({
            format: 'yyyy-mm-dd',
            calendarWeeks: true,
            todayHighlight: true,
            autoclose: true,
            endDate: '-0y'
        }).on('change.dp', function (e) {
            $('#fIngresoIni').datepicker('setEndDate', new Date($(this).val()));
        });
       
    });
    
</script>
</body>
</html>

<%-- 
    Document   : 408_Comision_Becas_Resolver_Solicitud
    Created on : 11-08-2016, 10:04:12 PM
    Author     : aquel
--%>

<%@page import="DAO.DetalleUsuarioDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.TipoDocumento"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="POJO.Documento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TipoDocumentoDAO"%>
<%@page import="DAO.DocumentoDAO"%>
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
    tipo_usuarios_permitidos.add("3"); //comision de beca
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
    Integer idFacultad = 0;
    String nombreFacultad="";
    try {
        DetalleUsuarioDAO DetUsDao = new DetalleUsuarioDAO();
        // Obtener la facultad a la que pertenece el usuario
        idFacultad = DetUsDao.obtenerFacultad(user);
        nombreFacultad = DetUsDao.obtenerNombreFacultad(user);
    } catch (Exception e) {
        e.printStackTrace();
    }
    String id_documento = request.getParameter("ID_DOCUMENTO");

    Integer id_expedie = Integer.parseInt(request.getParameter("ID_EXPEDIENTE"));
    ConexionBD conexionBD = new ConexionBD();
    //out.write(id_expediente);
    String consultaSql = "SELECT CONCAT(DU.NOMBRE1_DU,' ', DU.NOMBRE2_DU, ' ', DU.APELLIDO1_DU, ' ', DU.APELLIDO2_DU) AS NOMBRES, U.NOMBRE_USUARIO, E.ID_EXPEDIENTE,CONCAT(DU.DEPARTAMENTO, ' ',F.FACULTAD ) AS UNIDAD, TD.TIPO_DOCUMENTO, D.FECHA_SOLICITUD, P.ID_PROGRESO FROM DETALLE_USUARIO DU JOIN FACULTAD  F ON DU.ID_FACULTAD=F.ID_FACULTAD JOIN USUARIO U ON DU.ID_USUARIO=U.ID_USUARIO JOIN SOLICITUD_DE_BECA SB ON U.ID_USUARIO=SB.ID_USUARIO JOIN EXPEDIENTE  E ON SB.ID_EXPEDIENTE=E.ID_EXPEDIENTE JOIN DOCUMENTO  D ON D.ID_EXPEDIENTE=E.ID_EXPEDIENTE JOIN TIPO_DOCUMENTO  TD ON D.ID_TIPO_DOCUMENTO=TD.ID_TIPO_DOCUMENTO JOIN PROGRESO P ON E.ID_PROGRESO = P.ID_PROGRESO WHERE D.ID_DOCUMENTO = " + id_documento;
    ResultSet rs = null;

    String nombres = new String();
    String codigo_usuario = new String();
    String unidad = new String();
    String id_expediente = new String();
    String tipo_documento = new String();
    String fecha_solicitud = new String();
    String id_progreso = new String();
    int id_p = 3;
    try {
        rs = conexionBD.consultaSql(consultaSql);
        while (rs.next()) {
            nombres = rs.getString(1);
            codigo_usuario = rs.getString(2);
            id_expediente = rs.getString(3);
            unidad = rs.getString(4);
            tipo_documento = rs.getString(5);
            fecha_solicitud = rs.getString(6);
            id_progreso = rs.getString(7);
        }
    } catch (Exception ex) {
        System.err.println("error: " + ex);
    }
    //out.write(id_progreso);
    /* out.write(id_usuario);
    out.write(id_expediente1);
    out.write(unidad);
    out.write(tipo_documento);
    out.write(fecha_solicitud);*/

    DocumentoDAO docComision = new DocumentoDAO();
    ArrayList<Documento> publicos = new ArrayList<Documento>();
    publicos = docComision.consultarComisionExpe(id_expedie);

    //Ver si es editar o agregar
    String accion = request.getParameter("ACCION");

    if (accion == null) {
        accion = "insertar";
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

    <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>
    
    <p class="text-right" style="font-weight:bold;">Facultad: <%= nombreFacultad %></p>

    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>
    </head>

    <body ng-app="resolverSolComisionBecasApp" ng-controller="resolverSolComisionBecasCtrl">
        <div class="container-fluid">
            <div class="row"><!-- TITULO DE LA PANTALLA -->
                <h2>
                    <p class="text-center" style="color:#cf2a27"> Resolver Solicitud de Acuerdo</p>
                </h2>

                <br></br>

            </div><!-- TITULO DE LA PANTALLA --> 
            <div class="col-md-12">

                <fieldset class="custom-border">
                    <legend class="custom-border">Solicitud</legend>

                    <div class="row">    <!-- TABLA RESULTADOS --> 
                        <div class="col-md-1"></div> 
                        <div class="col-md-10">
                            <table class="table table-bordered"></br>
                                <tbody>
                                    <tr>
                                        <td>Solicitante: </td>
                                        <td><%=nombres%> </td>
                                    <td>Código de Empleado: </td>
                                    <td><%=codigo_usuario%> </td>
                                </tr>

                                <tr>
                                    <td>Unidad: </td>
                                    <td><%=unidad%> </td>
                                    <td>Expediente: </td>
                                    <td><%=id_expediente%> </td>
                                </tr>

                                <tr>
                                    <td>Documento Solicitado: </td>
                                    <td><%=tipo_documento%> </td>
                                    <td>Fecha Solicitud: </td>
                                    <td><%=fecha_solicitud%> </td>
                                </tr>

                            </tbody>    
                        </table>
                    </div>
                </div>




                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-8">
                        <fieldset class="custom-border">
                            <legend class="custom-border"> Documentos Adjuntados</legend>

                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-10">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>No.</th><th>Tipo de Documento</th><th>Documento Digital</th>
                                            </tr>   
                                        </thead>
                                        <tbody >
                                            <%
                                                for (int i = 0; i < publicos.size(); i++) {%>
                                            <tr>
                                                <td><%=i + 1%></td>
                                                <td><% out.write(publicos.get(i).getIdTipoDocumento().getTipoDocumento());%></td>
                                                <td>
                                                    <form action="verDocumentoComision" method="post" target="_blank" >
                                                        <input type = "hidden" name="id" value="<%= publicos.get(i).getIdDocumento()%>">
                                                        <input type="submit" class="btn btn-success" value="Ver Documento ">
                                                    </form>
                                                </td>
                                            </tr>
                                            <% }%>



                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-md-1"></div>
                            </div>


                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-10">
                                    <fieldset class="custom-border">
                                        <legend class="custom-border"> Resolucion</legend>
                                        <%if (accion.equals("insertar")) {%>
                                        <form  name="resolverSolComisionBecas" action="ResolverDictamen" method="POST" enctype="multipart/form-data" novalidate>           
                                            <div class="row" >
                                                <div class="col-md-4" ng-show="requerido">
                                                    <label>Documento Digital:</label>
                                                </div>
                                                <div class="col-md-8" ng-show="requerido">
                                                    <input type="file" name="doc_digital" accept="application/pdf" ng-model="acuerdo" valid-file ng-required="requerido">
                                                    <span class="text-danger" ng-show="resolverSolComisionBecas.doc_digital.$invalid && requerido">Debe ingresar un documento en formato PDF.</span>

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Observacion:</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <textarea class="form-control" name="observacion" ng-model="observacion" maxlength="1024" ng-required="obsReq"></textarea>
                                                    <span class="text-danger" ng-show="resolverSolComisionBecas.observacion.$error.required">Ingrese la observacion del documento</span><br>
                                                </div>
                                                <div class="col-md-1"></div>
                                            </div>
                                            <div class="row text-center">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-10 btn-group text-center" data-toggle="buttons">
                                                    <div class="col-md-4">
                                                        <label class="btn btn-primary " ng-click="CambiarEstadoAprobado()">
                                                            <input type="radio" name="resolucion" value="APROBADO" autocomplete="off" ng-model="resolucion" ng-required="true"> Aprobado
                                                        </label>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="btn btn-danger" ng-click="CambiarEstadoDenegado()">
                                                            <input type="radio" name="resolucion" value="DENEGADO" autocomplete="off" ng-model="resolucion" ng-required="true"> Denegado
                                                        </label>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="btn btn-info" ng-click="CambiarEstadoCorreccion()">
                                                            <input type="radio" name="resolucion" value="CORRECCION" autocomplete="off" ng-model="resolucion" ng-required="true"> Solicitar Correccion
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-md-1"></div>   
                                            </div>
                                            <div class="row text-center">
                                                <span class="text-danger" ng-show="!resolverSolComisionBecas.$pristine && resolverSolComisionBecas.resolucion.$error.required">Debe Seleccionar una Resolucion.</span>
                                            </div> 
                                            <%if (id_p == 1) {%>
                                            <input type="hidden" name="tipoCorreccion" value="solicitud">
                                            <%} else {%>                                            
                                            <div class="row" ng-show="mostrartipocorrecion">
                                                <div class="text-center"><br><br><label>Seleccione el Tipo de Correccion a solicitar:</label></div>
                                                <div class="col-md-4"></div> 
                                                <div class="col-md-3">
                                                    <label class="form-control-static" ng-click="">
                                                        <input type="radio" name="tipoCorreccion" class="form-control" value="documento" autocomplete="off" ng-model="tipoCorreccion" ng-required="mostrartipocorrecion"> Documento
                                                    </label>
                                                </div> 
                                                <div class="col-md-3">
                                                    <label class="form-control-static" ng-click="">
                                                        <input type="radio" name="tipoCorreccion" class="form-control" value="solicitud" autocomplete="off" ng-model="tipoCorreccion" ng-required="mostrartipocorrecion"> Solicitud
                                                    </label>
                                                </div> 
                                                <div class="col-md-2"></div>                                                                                                 
                                            </div>
                                            <div class="row text-center">
                                                <span class="text-danger" ng-show="!resolverSolComisionBecas.$pristine && resolverSolComisionBecas.tipoCorreccion.$error.required">Debe Seleccionar un tipo de correccion.</span>
                                            </div> 
                                            <%}%>
                                            <div class="row text-center">
                                                <br>
                                            </div>
                                            <div class="row text-center">
                                                <input type="hidden" name="accion" value="<%=accion%>">
                                                <input type="hidden" name="id_documento" value="<%=id_documento%>">
                                                <input type="hidden" name="id_p" value="3">
                                                <input type="submit" value="Guardar" class="btn btn-success" ng-disabled="!resolverSolComisionBecas.$valid">
                                            </div>  
                                        </form> 
                                        <%} else {
                                            Documento acuerdo = docComision.obtenerInformacionDocumentoPorId(Integer.parseInt(id_documento));
                                        %>
                                        <div class="row">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>Acuerdo Ingresado</th><th>Observacion</th><th>Documento</th>
                                                    </tr>                                                        
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td><%=acuerdo.getIdTipoDocumento().getTipoDocumento()%></td>
                                                        <td><%=acuerdo.getObservacion()%></td>
                                                        <td>
                                                            <form action="verDocumentoConsejo" method="post" target="_blank" >
                                                                <input type = "hidden" name="id" value="<%=id_documento%>">
                                                                <input type="submit" class="btn btn-success" value="Ver Documento ">
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <form  name="resolverSolComisionBecas" action="ResolverDictamen" method="POST" enctype="multipart/form-data" novalidate>           
                                            <div class="row" >
                                                <div class="col-md-4" ng-show="requerido">
                                                    <label>Documento Digital:</label>
                                                </div>
                                                <div class="col-md-8" ng-show="requerido">
                                                    <input type="file" name="doc_digital" accept="application/pdf" ng-model="acuerdo">
                                                    <span class="text-danger" ng-show="resolverSolComisionBecas.doc_digital.$invalid && requerido">Debe ingresar un documento en formato PDF.</span>

                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label>Observacion:</label>
                                                </div>
                                                <div class="col-md-7">
                                                    <textarea class="form-control" name="observacion" ng-model="observacion" maxlength="1024" ng-required="obsReq"></textarea>
                                                    <span class="text-danger" ng-show="resolverSolComisionBecas.observacion.$error.required">Ingrese la observacion del documento</span><br>
                                                </div>
                                                <div class="col-md-1"></div>
                                            </div>
                                            <div class="row text-center">
                                                <div class="col-md-1"></div>
                                                <div class="col-md-10 btn-group text-center" data-toggle="buttons">
                                                    <div class="col-md-4">
                                                        <label class="btn btn-primary " ng-click="CambiarEstadoAprobado()">
                                                            <input type="radio" name="resolucion" value="APROBADO" autocomplete="off" ng-model="resolucion" ng-required="true"> Aprobado
                                                        </label>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="btn btn-danger" ng-click="CambiarEstadoDenegado()">
                                                            <input type="radio" name="resolucion" value="DENEGADO" autocomplete="off" ng-model="resolucion" ng-required="true"> Denegado
                                                        </label>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <label class="btn btn-info" ng-click="CambiarEstadoCorreccion()">
                                                            <input type="radio" name="resolucion" value="CORRECCION" autocomplete="off" ng-model="resolucion" ng-required="true"> Solicitar Correccion
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="col-md-1"></div>   
                                            </div>
                                            <div class="row text-center">
                                                <span class="text-danger" ng-show="!resolverSolComisionBecas.$pristine && resolverSolComisionBecas.resolucion.$error.required">Debe Seleccionar una Resolucion.</span>
                                            </div> 
                                            <%if (id_p == 1) {%>
                                            <input type="hidden" name="tipoCorreccion" value="solicitud">
                                            <%} else {%>                                            
                                            <div class="row" ng-show="mostrartipocorrecion">
                                                <div class="text-center"><br><br><label>Seleccione el Tipo de Correccion a solicitar:</label></div>
                                                <div class="col-md-4"></div> 
                                                <div class="col-md-3">
                                                    <label class="form-control-static" ng-click="">
                                                        <input type="radio" name="tipoCorreccion" class="form-control" value="documento" autocomplete="off" ng-model="tipoCorreccion" ng-required="mostrartipocorrecion"> Documento
                                                    </label>
                                                </div> 
                                                <div class="col-md-3">
                                                    <label class="form-control-static" ng-click="">
                                                        <input type="radio" name="tipoCorreccion" class="form-control" value="solicitud" autocomplete="off" ng-model="tipoCorreccion" ng-required="mostrartipocorrecion"> Solicitud
                                                    </label>
                                                </div> 
                                                <div class="col-md-2"></div>                                                                                                 
                                            </div>
                                            <div class="row text-center">
                                                <span class="text-danger" ng-show="!resolverSolComisionBecas.$pristine && resolverSolComisionBecas.tipoCorreccion.$error.required">Debe Seleccionar un tipo de correccion.</span>
                                            </div> 
                                            <%}%>
                                            <div class="row text-center">
                                                <br>
                                            </div>
                                            <div class="row text-center">
                                                <input type="hidden" name="accion" value="<%=accion%>">
                                                <input type="hidden" name="id_documento" value="<%=id_documento%>">
                                                <input type="hidden" name="id_p" value="3">
                                                <input type="submit" value="Guardar" class="btn btn-success" ng-disabled="!resolverSolComisionBecas.$valid">
                                            </div>  
                                        </form>
                                        <%}%>
                                    </fieldset>
                                </div>
                                <div class="col-md-1"></div>
                            </div>


                        </fieldset>      
                    </div>
                </div>
                <div class="col-md-3"></div>
            </fieldset>
        </div>  

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
    <script src="js/resolverSolComisionBecas.js"></script>


</body>
</html>

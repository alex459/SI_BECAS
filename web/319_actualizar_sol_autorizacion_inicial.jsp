<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.Documento"%>
<%@page import="DAO.DocumentoDAO"%>
<%@page import="POJO.Expediente"%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page import="DAO.DetalleUsuarioDAO"%>

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
    tipo_usuarios_permitidos.add("1"); //candidato
    tipo_usuarios_permitidos.add("9"); //admin
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!-- fin de proceso de seguridad de login -->

<%

    DocumentoDAO documentoDao = new DocumentoDAO();
    int idDocumento = Integer.parseInt(request.getParameter("idDocumento"));
    int idexp = documentoDao.ObtenerIdExpedientePorIdDocumento(idDocumento);
    ArrayList<Documento> lista = documentoDao.documentosAutorizacionInicial(idexp);
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
    <body ng-app = "solicitudApp" ng-controller="SolicitarAutorizacionCtrl">

        <div class="container-fluid">        
            <H3 class="text-center" style="color:#E42217;">Editar Solicitud de Autorización Inicial</H3>
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-10">
                    <fieldset class="custom-border">
                        <legend class="custom-border">Solicitud de Autorización Inicial</legend>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
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
                                        <% numero=numero+1;}%>
                                    </tbody>
                                </table>
                            </fieldset>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-1"></div>
                        <div class="col-md-10 text-center">
                            <label>Seleccione la accion que desea realizar</label>
                        </div>
                        <div class="col-md-1"></div>                        
                    </div>
                    <form name="solicitudPermisoInicial" action="ActualizarAutorizacionInicialServlet" method="post" enctype="multipart/form-data" novalidate>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <div class="col-md-1"></div>
                                <div class="col-md-10">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="form-control-static"> Carta de Solicitud de Autorización Inicial</label>
                                        </div>   
                                        <div class="col-md-6">
                                            <label class="radio-inline" for="radios-0">
                                                <input type="radio" name="accCarta"  value="ninguna"  ng-model ="accCarta" ng-required="true" ng-click="NadaCarta()">
                                                Ninguna
                                            </label>
                                            <label class="radio-inline" for="radios-0">
                                                <input type="radio" name="accCarta"  value="actualizar"  ng-model ="accCarta" ng-required="true" ng-click="ActualizarCarta()">
                                                Actualizar
                                            </label> 
                                            
                                        </div> 
                                    </div>
                                    <div class="row" ng-show="mostrarCarta">
                                        <div class="col-md-12">
                                            <input type="file" class="" name="cartaSolicitud" accept="application/pdf" ng-model="cartaSolicitud" valid-file ng-required="mostrarCarta">
                                            <span class="text-danger" ng-show="solicitudPermisoInicial.cartaSolicitud.$invalid">Debe ingresar un documento en formato PDF.</span>
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <div class="col-md-1"></div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <div class="col-md-1"></div>
                                <div class="col-md-10">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="form-control-static"> Título de la UES:</label>
                                        </div>   
                                        <div class="col-md-6">
                                            <label class="radio-inline" for="radios-0">
                                                <input type="radio" name="accCartaEscuela"  value="ninguna"  ng-model ="accCartaEscuela" ng-required="true" ng-click="NadaCartaEscuela()">
                                                Ninguna
                                            </label>
                                            <label class="radio-inline" for="radios-0">
                                                <input type="radio" name="accCartaEscuela"  value="actualizar"  ng-model ="accCartaEscuela" ng-required="true" ng-click="ActualizarCartaEscuela()">
                                                Actualizar
                                            </label> 
                                            
                                        </div> 
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12" ng-show="mostrarCartaEscuela">
                                            <input type="file" class="" name="cartaEscuela" accept="application/pdf" ng-model="cartaEscuela" valid-file ng-required="mostrarCartaEscuela">
                                            <span class="text-danger" ng-show="solicitudPermisoInicial.cartaEscuela.$invalid">Debe ingresar un documento en formato PDF.</span>
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <div class="col-md-1"></div>
                        </div>

                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <div class="col-md-1"></div>
                                <div class="col-md-10">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="form-control-static"> Certificación de Notas:</label>
                                        </div>   
                                        <div class="col-md-6">
                                            <label class="radio-inline" for="radios-0">
                                                <input type="radio" name="accCartaInstitucion"  value="ninguna"  ng-model ="accCartaInstitucion" ng-required="true" ng-click="NadaCartaInstitucion()">
                                                Ninguna
                                            </label>
                                            <label class="radio-inline" for="radios-0">
                                                <input type="radio" name="accCartaInstitucion"  value="actualizar"  ng-model ="accCartaInstitucion" ng-required="true" ng-click="ActualizarCartaInstitucion()">
                                                Actualizar
                                            </label> 
                                            
                                        </div> 
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12" ng-show="mostrarCartaInstitucion">
                                            <input type="file" class="" name="CartaInstitucion" accept="application/pdf" ng-model="CartaInstitucion" valid-file ng-required="mostrarCartaInstitucion">
                                            <span class="text-danger" ng-show="solicitudPermisoInicial.CartaInstitucion.$invalid">Debe ingresar un documento en formato PDF.</span>
                                        </div>
                                    </div>
                                </div>


                            </div>
                            <div class="col-md-1"></div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <div class="col-md-1"></div>
                                <div class="col-md-10">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="form-control-static"> Copia de DUI:</label>
                                        </div>   
                                        <div class="col-md-6">
                                            <label class="radio-inline" for="radios-0">
                                                <input type="radio" name="accDui"  value="ninguna"  ng-model ="accDui" ng-required="true" ng-click="NadaDui()">
                                                Ninguna
                                            </label>
                                            <label class="radio-inline" for="radios-0">
                                                <input type="radio" name="accDui"  value="actualizar"  ng-model ="accDui" ng-required="true" ng-click="ActualizarDui()">
                                                Actualizar
                                            </label>                                             
                                        </div> 
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12" ng-show="mostrarDui">
                                            <input type="file" class="" name="Dui" accept="application/pdf" ng-model="Dui" valid-file ng-required="mostrarDui">
                                            <span class="text-danger" ng-show="solicitudPermisoInicial.Dui.$invalid">Debe ingresar un documento en formato PDF.</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                        
                                                                        
                        <div class="row text-center">
                            <input type="hidden" name="idExpediente" value="<%=idexp%>">
                            <input type="submit" name="guardar" value="Guardar" class="btn btn-success" ng-disabled="!solicitudPermisoInicial.$valid">                            
                        </div>
                    </form>
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
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/angular.min.js"></script>
    <script src="js/solicitarAutorizacionInicial.js"></script>
</body>
</html>

<%-- 
    Document   : 419_Modificar_Acuerdo_Anyo_Fiscal
    Created on : 8/01/2017, 09:17:47 PM
    Author     : adminPC
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="POJO.Documento"%>
<%@page import="DAO.DocumentoDAO"%>
<%@page import="POJO.Expediente"%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page import="DAO.DetalleUsuarioDAO"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String rol = (String) actual.getAttribute("rol");
    String user = (String) actual.getAttribute("user");

    DocumentoDAO documentoDao = new DocumentoDAO();
    int idDocumento = Integer.parseInt(request.getParameter("idDocumento"));
    int idexp = documentoDao.ObtenerIdExpedientePorIdDocumento(idDocumento);
    ArrayList<Documento> lista = documentoDao.DocumentosAcuerdoFiscal(idexp);
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
            <H3 class="text-center" style="color:#E42217;">Editar Solicitud de Acuerdo de Año Fiscal</H3>
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-10">
                    <fieldset class="custom-border">
                        <legend class="custom-border">Solicitud de Acuerdo de Año Fiscal</legend>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <fieldset class="custom-border">
                                    <legend class="custom-border">Documentos Adjuntados</legend>
                                    <table class="table text-center">
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
                    <form name="solicitudPermisoInicial" action="ActualizarAnyoFiscalServlet" method="post" enctype="multipart/form-data" novalidate>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <div class="col-md-1"></div>
                                <div class="col-md-10">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <label class="form-control-static"> Carta de solicitud:</label>
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

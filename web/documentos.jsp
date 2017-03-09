<%-- 
    Document   : documentos
    Created on : 11-07-2016, 04:58:22 AM
    Author     : Mauricio
--%>

<%@page import="POJO.TipoDocumento"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="POJO.Documento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TipoDocumentoDAO"%>
<%@page import="DAO.DocumentoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    DocumentoDAO docDao = new DocumentoDAO();
    TipoDocumentoDAO tipDocDao= new TipoDocumentoDAO();
    ArrayList<Documento> publicos = new ArrayList<Documento>();
    publicos =  docDao.consultarTodos();
    Gson gson = new Gson();
    String documentosJSON1 = gson.toJson(publicos);
    String documentosJSON =  documentosJSON1.replace("\"", "'");
    ArrayList<TipoDocumento> tiposDoc = new ArrayList<TipoDocumento>();
    tiposDoc = tipDocDao.consultarTodosPublicosIngresados();
    Gson gson2 = new Gson();
    String tiposJSON1 = gson2.toJson(tiposDoc);
    String tiposJSON =  tiposJSON1.replace("\"", "'"); 
%>
<!DOCTYPE html>
<html ng-app="DocumentoApp">
    <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Sistema informático para la administración de becas de postgrado</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <jsp:include page="cabecera.jsp"></jsp:include>
                <nav class="navbar navbar-custom" role="navigation">
                    <div class="navbar-header">

                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                        </button> <a class="navbar-brand active" href="index.jsp">Inicio</a>
                    </div>

                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        
                        <ul class="nav navbar-nav">
                            <li>
                                        <a href="documentos.jsp">Documentos</a>                                   
                            </li>
                        </ul>
                        
                        <ul class="nav navbar-nav navbar-right">						
                            
                            <li>
                                <a href="login.jsp">Iniciar Sesión</a>
                            </li>
                        </ul>
                    </div>

                </nav>
</head>
    
    <body ng-controller="BuscarCtrl" ng-init="documentos=<%=documentosJSON%>">
    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Consultar Documento</H3>
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <fieldset class="custom-border">
                <legend class="custom-border">Consultar Documento</legend>
                
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-8">
                        <fieldset class="custom-border">
                            <legend class="custom-border">Filtro</legend>
                            <form>
                                <div class="row" ng-init="tipos=<%=tiposJSON%>">
                                    <div class="col-md-4">
                                        <label>Tipo Documento:</label>
                                    </div>
                                    <div class="col-md-8">
                                        <select class="form-control" ng-model = "idTipo">
                                            <option ng-repeat="option in tipos" value="{{option.idTipoDocumento}}">{{option.tipoDocumento}}</option>
                                        </select><br>
                                    </div>
                                </div>
                            </form>
                        </fieldset>

                    </div>
                    <div class="col-md-2"></div>
                </div>

                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                        <table class="table table-bordered text-center">
                                    <thead>
                                        <tr>
                                            <th>No.</th><th>Tipo de Documento</th><th>Documento Digital</th>
                                        </tr>   
                                    </thead>
                                    <%int i =0;%>
                                    <tbody ng-repeat="x in documentos |filter:{idTipoDocumento:{idTipoDocumento:idTipo}}">
                                        <tr>
                                            <td>{{documentos.indexOf(x)+1}}</td>
                                            <td>{{x.idTipoDocumento.tipoDocumento}}</td>
                                            <td><form action="Documento" method="post"  target="_blank">
                                                    <input type="hidden" name="id" value="{{x.idDocumento}}">
                                                    <input type="submit" class="btn btn-success" value="Ver Documento">
                                                </form>
                                            </td>
                                            
                                            
                                        </tr>
                                        
                                    </tbody>
                                </table>
                    </div>
                    <div class="col-md-1"></div>
                </div>

            </fieldset>
        </div>
        <div class="col-md-3"></div>
       
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
</div>


<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/angular.min.js"></script>
<script src="js/buscarDocumento.js"></script>


</body>
</html>

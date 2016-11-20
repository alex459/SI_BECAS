<%-- 
    Document   : 208_agregar_documento
    Created on : 11-07-2016, 04:53:51 AM
    Author     : Mauricio
--%>


<%@page import="POJO.TipoDocumento"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TipoDocumentoDAO"%>
<%@page import="MODEL.variablesDeSesion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    TipoDocumentoDAO tipDocDao= new TipoDocumentoDAO();
    Gson gson = new Gson();
    ArrayList<TipoDocumento> tiposDoc = new ArrayList<TipoDocumento>();
    tiposDoc = tipDocDao.consultarTodosPublicosPendientes();
    String tiposJSON1 = gson.toJson(tiposDoc);
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

    <p class="text-right">Rol: </p>
    <p class="text-right">Usuario: </p>

    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu.jsp"></jsp:include>
</head>

<body ng-controller="AgregarCtrl">

    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Agregar Documento</H3>
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <fieldset class="custom-border">
                <legend class="custom-border">Datos del Documento</legend>
                <h5 style="color:#E42217;">Ingrese la informacion del documento</h5><br>
                <form  name="agregarDocumento" action="AgregarDocumentoServlet" method="POST" enctype="multipart/form-data">
                    <div class="row" ng-init="tipos=<%=tiposJSON%>">
                        <div class="col-md-4">
                            <label>Tipo de Documento:</label>
                        </div>
                        <div class="col-md-7">
                            <select class="form-control" name="tipo" ng-model = "idTipo" ng-required="true">
                                <option ng-repeat="option in tipos" value="{{option.idTipoDocumento}}">{{option.tipoDocumento}}</option>

                            </select><br>
                            <span class="text-danger" ng-show="!agregarDocumento.$pristine && agregarDocumento.tipo.$error.required">Debe seleccionar el Tipo de Documento a Ingresar.</span>
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <label>Documento Digital:</label>
                        </div>
                        <div class="col-md-8">
                            <input type="file" name="doc_digital" accept="application/pdf" valid-file ng-required="true"><br>
                            <span class="text-danger" ng-show="!agregarDocumento.$pristine && agregarDocumento.doc_digital.$error.required">Debe Agregar un Documento PDF.</span>
                            
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <label>Observacion:</label>
                        </div>
                        <div class="col-md-7">
                            <textarea class="form-control" name="observacion" ng-model="observacion" maxlength="1024"></textarea><br>
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="row text-center">
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <div class="col-md-6">
                                <input type="submit" name="guardar" value="Guardar" class="btn btn-primary" ng-disabled="!agregarDocumento.$valid">
                            </div>
                            <div class="col-md-6">
                                <a href=""><button class="btn btn-danger">Cancelar</button></a>
                            </div>
                        </div>
                        <div class="col-md-3"></div>   
                    </div>
                </form>


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
<script src="js/agregarDocumento.js"></script>


</body>
</html>
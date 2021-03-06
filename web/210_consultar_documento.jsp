<%-- 
    Document   : 210_consultar_documento
    Created on : 11-07-2016, 04:58:22 AM
    Author     : Mauricio
--%>

<%@page import="POJO.TipoDocumento"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="POJO.Documento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TipoDocumentoDAO"%>
<%@page import="DAO.DocumentoDAO"%>
<%@page import="MODEL.variablesDeSesion"%>
<%@page import="MODEL.Utilidades"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
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
        <link href="css/customfieldset.css" rel="stylesheet">
        <jsp:include page="cabecera.jsp"></jsp:include>

        <p class="text-right" style="font-weight:bold;">Rol: <%= rol %></p>
        <p class="text-right" style="font-weight:bold;">Usuario: <%= user %></p>


        <%-- todo el menu esta contenido en la siguiente linea
             el menu puede ser cambiado en la pagina menu.jsp --%>
        <jsp:include page="menu_corto.jsp"></jsp:include>
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
                        <table id="tablaUsuarios" class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>No.</th><th>Tipo de Documento</th><th>Documento Digital</th><th>Observaciones</th><th>Acción</th>
                                        </tr>   
                                    </thead>
                                    <%int i =0;%>
                                    <tbody ng-repeat="x in documentos |filter:{idTipoDocumento:{idTipoDocumento:idTipo}}">
                                        <tr ng-class-even="'even'" ng-class-odd="'odd'">
                                            <td>{{documentos.indexOf(x)+1}}</td>
                                            <td>{{x.idTipoDocumento.tipoDocumento}}</td>
                                            <td><form action="Documento" method="post"  target="_blank">
                                                    <input type="hidden" name="id" value="{{x.idDocumento}}">
                                                    <input type="submit" class="btn btn-primary" value="Ver Documento">
                                                </form>
                                            </td>
                                            <td>{{x.observacion}}</td>
                                            <td>
                                                <form action="209_modificar_documento.jsp" method="post">
                                                    <input type="hidden" name="id" value="{{x.idDocumento}}">
                                                    <input type="submit" class="btn btn-success" value="Editar">
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
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">
   $(document).ready(function() {
    $('#tablaUsuarios').DataTable(
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
    
</script>

</body>
</html>

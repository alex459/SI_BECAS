<%-- 
    Document   : 209_modificar_documento
    Created on : 11-07-2016, 04:55:43 AM
    Author     : Mauricio
--%>

<%@page import="POJO.Documento"%>
<%@page import="DAO.DocumentoDAO"%>
<%@page import="POJO.TipoDocumento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="DAO.TipoDocumentoDAO"%>
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
    
    
    

    Integer id=0;
    Integer idtipo=0;
    TipoDocumentoDAO tipDocDao= new TipoDocumentoDAO();
    Gson gson = new Gson();
    ArrayList<TipoDocumento> tiposDoc = new ArrayList<TipoDocumento>();
    
    DocumentoDAO docDao = new DocumentoDAO();
    String observacion="";
    String nombreTipo ="";
    
try{
    id=Integer.parseInt(request.getParameter("id"));
} catch(Exception e){
    e.printStackTrace();
}
try{
    idtipo=Integer.parseInt(request.getParameter("idTipo"));
    id = docDao.ObtenerIdDocumento(idtipo);
} catch(Exception e){
    e.printStackTrace();
}

if (id !=0){
    Documento publicos = new Documento();
    tiposDoc = tipDocDao.consultarPorIdDocumento(id);
    publicos =  docDao.consultarPorId(id);
    observacion = publicos.getObservacion();
    idtipo = publicos.getIdTipoDocumento().getIdTipoDocumento();
    nombreTipo = publicos.getIdTipoDocumento().getTipoDocumento();
    
}else{
    tiposDoc = tipDocDao.consultarTodosPublicosIngresados();
    
}
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
        <jsp:include page="cabecera.jsp"></jsp:include>

        <p class="text-right" style="font-weight:bold;">Rol: <%= rol %></p>
        <p class="text-right" style="font-weight:bold;">Usuario: <%= user %></p>


        <%-- todo el menu esta contenido en la siguiente linea
             el menu puede ser cambiado en la pagina menu.jsp --%>
        <jsp:include page="menu_corto.jsp"></jsp:include>
    </head>
    <body ng-controller="ModificarCtrl" >

    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Modificar Documento</H3>
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <fieldset class="custom-border">
                <legend class="custom-border">Datos del Documento</legend>
                <h5 style="color:#E42217;">Ingrese la informacion del documento</h5><br>
                <%
                    if (id !=0){%>
                    <form action="ModificarDocumentoServlet" method = post enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-4">
                              <label>Documento:</label>
                            </div>
                            <div class="col-md-7">
                                <span><%=nombreTipo%></span>
                                <input type="hidden" name="id" value="<%=id%>" />
                                <br>
                            
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                        <div class="row">
                        <div class="col-md-4">
                            <label>Documento Digital:</label>
                        </div>
                        <div class="col-md-8">
                            <input type="file" name="doc_digital" accept="application/pdf"><br>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <label>Observacion:</label>
                        </div>
                        <div class="col-md-7">
                            <textarea name="observacion" class="form-control" ><%=observacion%></textarea><br>
                        </div>
                        <div class="col-md-1"></div>
                    </div>

                    <div class="row text-center">
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <div class="col-md-6">
                                <input type="submit" name="guardar" value="Guardar" class="btn btn-primary">
                            </div>
                            <div class="col-md-6">
                                <a href="principal.jsp" class="btn btn-danger">Cancelar</a>
                            </div>
                        </div>
                        <div class="col-md-3"></div>   
                    </div>
                    </form>
                 <%   } else{%>
                    <form action="209_modificar_documento.jsp" method = post>
                        <div class="row" ng-init="tipos=<%=tiposJSON%>">
                            <div class="col-md-4">
                                <label>Documento:</label>
                            </div>
                            <div class="col-md-7">
                                <select  name="idTipo" class="form-control" ng-model = "idTipo">
                                    <option ng-repeat="option in tipos" value="{{option.idTipoDocumento}}">{{option.tipoDocumento}}</option>
                                </select><br>
                            
                            </div>
                            <div class="col-md-1"></div>
                        </div>

                        <div class="row text-center">
                            
                            <input type="submit" name="cargar" value="Cargar" class="btn btn-primary"/><br><br>
                        </div>
                    </form> 
                 <%   }
                %>
                              
                

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
<script src="js/modificarDocumento.js"></script>


</body>
</html>
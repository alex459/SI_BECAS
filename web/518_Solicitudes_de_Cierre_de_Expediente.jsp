<%-- 
    Document   : 518_Solicitudes_de_Cierre_de_Expediente
    Created on : 25/12/2016, 03:46:27 PM
    Author     : adminPC
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.TipoDocumento"%>
<%@page import="DAO.TipoDocumentoDAO"%>
<% 
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String rol=(String)actual.getAttribute("rol");
    String user=(String)actual.getAttribute("user");%>
    
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
    <body ng-app="solicitudCierreExpedienteConsejoBecasApp" ng-controller="solicitudCierreExpedienteConsejoBecasCtrl">
        <div class="container-fluid"> 
            <H3 class="text-center" style="color:#E42217;">Solicitudes de Cierre de Expediente</H3>
        
            <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->
                
                
               
                    <fieldset class="custom-border">
                        <legend class="custom-border">Solicitudes de Cierre de Expediente</legend>
                        
                         <form name="solicitudCierreExpedientePendiente" class="form-horizontal" action="518_Solicitudes_de_Cierre_de_Expediente.jsp" method="post" novalidate>
   
                            <div class="row">      <!-- FILTROS -->
                                <div class="col-md-2"></div>
                                <div class="col-md-8"> 
                
                                    <fieldset class="custom-border">
                                        <legend class="custom-border">Filtros</legend>
                                
                                            <div class="row"> 
                                                <div class="col-md-12">   
                                                    <label for="textinput">Propietario: </label>                                                                                      
                                                </div>
                                        
                                                <div class="col-md-12">   
                                            
                                                    <div class="row">
                                            
                                                        <div class="col-md-3">                                                                                    
                                                            <input id="NOMBRE1" name="NOMBRE1" type="text" placeholder="primer nombre" class="form-control input-md" ng-model="datos.nombre1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                            <span class="text-danger" ng-show="solicitudCierreExpedientePendiente.NOMBRE1.$error.minlength">Minimo 3 caracteres.</span>
                                                            <span class="text-danger" ng-show="solicitudCierreExpedientePendiente.NOMBRE1.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>

                                                        </div>
                                            
                                                        <div class="col-md-3">    
                                                            <input id="NOMBRE2" name="NOMBRE2" type="text" placeholder="segundo nombre" class="form-control input-md" ng-model="datos.nombre2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                            <span class="text-danger" ng-show="solicitudCierreExpedientePendiente.NOMBRE2.$error.minlength">Minimo 3 caracteres.</span>
                                                            <span class="text-danger" ng-show="solicitudCierreExpedientePendiente.NOMBRE2.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                                                        </div> 
                                                        <div class="col-md-3">
                                                            <input id="APELLIDO1" name="APELLIDO1" type="text" placeholder="primer apellido" class="form-control input-md" ng-model="datos.apellido1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                                            <span class="text-danger" ng-show="solicitudCierreExpedientePendiente.APELLIDO1.$error.minlength">Minimo 3 caracteres.</span>
                                                            <span class="text-danger" ng-show="solicitudCierreExpedientePendiente.APELLIDO1.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                                                        </div> 
                                                        <div class="col-md-3">
                                                            <input id="APELLIDO2" name="APELLIDO2" type="text" placeholder="segundo apellido" class="form-control input-md" ng-model="datos.apellido2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">
                                                            <span class="text-danger" ng-show="solicitudCierreExpedientePendiente.APELLIDO2.$error.minlength">Minimo 3 caracteres.</span>
                                                            <span class="text-danger" ng-show="solicitudCierreExpedientePendiente.APELLIDO2.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                                                        </div>

                                                    </div> 
                                                    <div class="col-md-3 text-right"></div> 
                                                </div>
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-md-6">   
                                                    <label for="textinput">Expediente: </label>  
                                                    <input id="exp" name="EXPEDIENTE" type="number" placeholder="ingrese el usuario a buscar" class="form-control input-md" ng-model="datos.codigo" min="0" max="100000">
                                                    <span class="text-danger" ng-show="solicitudCierreExpedientePendiente.EXPEDIENTE.$error.min">Debe introducir un numero mayor que 0.</span>
                                                </div>
                                        
                                                <div class="col-md-6">   
                                                    <label for="textinput">Tipo de Documento :</label>  
                                                         <select id="selectbasic" name="ID_TIPO_DOCUMENTO" class="form-control">
                                                                <option value="0">CONSULTAR TIPO DOCUMENTO</option> 
                                                                
                                                                <%
                                                                    TipoDocumentoDAO tipoDocumentoDao = new TipoDocumentoDAO();
                                                                    ArrayList<TipoDocumento> listaTipoDocumento = new ArrayList<TipoDocumento>();
                                                                    listaTipoDocumento = tipoDocumentoDao.consultarTiposDocumentosDeSolicitudes();
                                                                    for (int i = 0; i < listaTipoDocumento.size(); i++) {
                                                                    out.write("<option value=" + listaTipoDocumento.get(i).getIdTipoDocumento() + ">" + listaTipoDocumento.get(i).getTipoDocumento() + "</option>");
                                                                     }
                                                                %>                   
                                                            </select>
                                                </div>
                                                                         
                                            </div>
                                            <br>
                                            <div class="row">
                                                <div class="col-md-6">  
                                                    <label for="textinput">ESTADO EXPEDIENTE: </label>
                                                        <select id="selectbasic" name="ESTADO" class="form-control">
                                                            <option value="">SELECCIONE ESTADO DEL EXPEDIENTE</option>    
                                                            <option value="DENEGADO">DENEGADO</option>
                                                            <option value="FINALIZADO">FINALIZADO</option>
                                                        </select>
                                                
                                                </div>
                                                <div class="col-md-6"></div>
                                            </div>
                                            <br>
                                            <div class="row text-center"> 
                                                <input type="submit" class="btn btn-primary" name="submit" value="Buscar" ng-disabled="!solicitudCierreExpedientePendiente.$valid">
                                            </div>
                                        </fieldset>
                                
                                    </div>
                    
                                </div>
                            </form>                            
           <%
              //  response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
              //  request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
                String nombre1;
                String nombre2;
                String apellido1;
                String apellido2;
                int expediente =0;
                Integer id_tipo_documento;
                String estado;
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
            try{
                expediente = Integer.parseInt(request.getParameter("EXPEDIENTE"));  
            }catch(Exception ex){
                ex.printStackTrace();
            }
            id_tipo_documento = Integer.parseInt(request.getParameter("ID_TIPO_DOCUMENTO"));
            estado = request.getParameter("ESTADO");
            
            String consultaSql="";
            
            if(nombre1!=null) {} else {nombre1="";};
            if(nombre2!=null) {} else {nombre2="";};
            if(apellido1!=null) {} else {apellido1="";};
            if(apellido2!=null) {} else {apellido2="";};
            if(estado!=null) {} else {estado="";};
            
            consultaSql = "SELECT DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, D.ID_EXPEDIENTE, E.ESTADO_PROGRESO, TD.TIPO_DOCUMENTO, D.ID_DOCUMENTO FROM detalle_usuario DU JOIN usuario U ON DU.ID_USUARIO = U.ID_USUARIO JOIN solicitud_de_beca SB ON SB.ID_USUARIO = U.ID_USUARIO JOIN documento D ON D.ID_EXPEDIENTE = SB.ID_EXPEDIENTE JOIN expediente E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE JOIN tipo_documento TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE (E.ESTADO_PROGRESO = 'DENEGADO' AND D.ESTADO_DOCUMENTO = 'DENEGADO' OR E.ESTADO_PROGRESO = 'FINALIZADO' AND D.ESTADO_DOCUMENTO = 'APROBADO' AND TD.ID_TIPO_DOCUMENTO=158) AND E.ESTADO_EXPEDIENTE='ABIERTO' AND DU.NOMBRE1_DU LIKE '%" + nombre1 + "%' AND DU.NOMBRE2_DU LIKE '%" + nombre2 + "%' AND DU.APELLIDO1_DU LIKE '%" + apellido1 + "%' AND DU.APELLIDO2_DU LIKE '%" + apellido2 + "%' AND E.ESTADO_PROGRESO LIKE '%" + estado + "%'  ";
             
          if (id_tipo_documento == 0) {

                    } else {
                        consultaSql = consultaSql.concat(" AND TD.ID_TIPO_DOCUMENTO = " + id_tipo_documento + " ");
                    }
          if (expediente == 0) {

                    } else {
                        consultaSql = consultaSql.concat(" AND DU.ID_FACULTAD = " + expediente);
                    }   
            
           
            
            conexionbd = new ConexionBD();
            rs = conexionbd.consultaSql(consultaSql);
                    //con el rs se llenara la tabla de resultados
           
            }
            catch (Exception ex){
            }
            
            %>    
             
                    
                    <br>
                    <div class="col-md-2"></div> 
                   
                    <div class="row">
                        <h5>Resultados</h5>
                        <div class="col-md-12">
                            <table class="table text-center">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Propietario</th>
                                        <th>Expediente</th>
                                        <th>Estado Expediente</th>
                                        <th>Documento Solicitado</th>
                                        <th>Acción</th>
                                    </tr>  
                                </thead>
                                <tbody>
                                <%
                                try {
                                    Integer i = 0;
                                    while (rs.next()) {
                                        i = i + 1;
                                        out.write("<tr>");
                                        out.write("<td>" + i + "</td>");
                                        out.write("<td>" + rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4) + "</td>");
                                        out.write("<td>" + rs.getInt(5) + "</td>");
                                        out.write("<td>" + rs.getString(6) + "</td>");
                                        out.write("<td>" + rs.getString(7) + "</td>");
                                        out.write("<td>");
                                        out.write("<center>");
                                        out.write("<form style='display:inline;' action='519_Resolver_Cierre_de_Expediente.jsp' method='post'><input type='hidden' name='ID_DOCUMENTO' value='" + rs.getString(8) + "'><input type='submit' class='btn btn-success' name='submit' value='Resolver'></form> ");
                                        
                                        out.write("</center>");
                                        out.write("</td>");
                                        out.write("</tr>");
                                    }
                                }catch (Exception ex) {
                                    System.out.println("error: " + ex);
                                }

                            %>  
                            </tbody>
                        </table> 
                    </div>
                    </div>
                </fieldset>
                    
             
            </div><!-- CONTENIDO DE LA PANTALLA -->
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
    <script src="js/solicitudCierreExpediente.js"></script>
    </body>
</html>

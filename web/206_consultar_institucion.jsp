<%-- 
    Document   : 206_consultar_institucion
    Created on : 11-07-2016, 04:48:27 AM
    Author     : Manuel Miranda
--%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String rol = (String) actual.getAttribute("rol");
    String user = (String) actual.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>


<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="MODEL.variablesDeSesion"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <%response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        %>
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

        <%-- todo el menu esta contenido en la siguiente linea
             el menu puede ser cambiado en la pagina menu.jsp --%>
        <jsp:include page="menu_corto.jsp"></jsp:include>
    

    </head>
    <body ng-app="ConsultarInstitucionApp" ng-controller="ConsultarInstitucionCtrl">
        <div class="container-fluid" >
            <div class="row"><!-- TITULO DE LA PANTALLA -->
                <h2>
                    <p class="text-center" style="color:#cf2a27">Consultar institucion</p>
                </h2>
                <br></br> 
            </div><!-- TITULO DE LA PANTALLA -->  

            <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->
                
                
                <form class="form-horizontal" name="consultarInst" action="206_consultar_institucion.jsp" method="post" novalidate>
                <fieldset class="custom-border">
                    <legend class="custom-border">Consultar institucion</legend>
                    <div class="col-md-6 col-md-offset-3">
                        <fieldset class="custom-border">
                            <legend class="custom-border">filtros:</legend>
                            <div class="row">
                                <div class="col-md-4 text-right">
                                <label for="textinput">Nombre de la institucion : </label>
                            </div>
                            <div class="col-md-8">
                                <input id="text_NomInstitucion" name="text_NomInstitucion" type="text" placeholder="ingrese el nombre de instirucion" class="form-control input-md" ng-model="datos.nombreInst"  ng-pattern="/^[a-zA-ZáÁéÉíÍóÓúÚñÑ ]*$/" minlength="3" maxlength="100" >
                                
                                <span class="text-danger" ng-show="consultarInst.text_NomInstitucion.$error.minlength">Minimo 3 caracteres</span>
                                <span class="text-danger" ng-show="consultarInst.text_NomInstitucion.$error.pattern">Solo se permiten caracteres alfabeticos .</span>
                            </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-4 text-right">
                                <label for="textinput">Pais : </label>
                            </div>
                            <div class="col-md-6">
                                <input id="tex_paisInstitucion" name="tex_paisInstitucion" type="text" placeholder="ingrese el pais" class="form-control input-md" ng-model="datos.pais"  ng-pattern="/^[a-zA-ZáÁéÉíÍóÓúÚñÑ ]*$/" minlength="3" maxlength="20" >
                                
                                <span class="text-danger" ng-show="consultarInst.tex_paisInstitucion.$error.minlength">Minimo 3 caracteres</span>
                                <span class="text-danger" ng-show="consultarInst.tex_paisInstitucion.$error.pattern">Solo se permiten caracteres alfabeticos.</span>
                                </div>
                            </div>
                            <br>
                            <div class="row">
                                <div class="col-md-4 text-right">
                                <label for="textinput">Tipo de institucion : </label>
                            </div>
                            <div class="col-md-6">
                                <select id="select_tipoInstitucion" name="select_tipoInstitucion"  class="form-control">                            
                                    <option value="">Seleccione Tipo de Institución</option>
                                    <option value="Ofertante">Ofertante</option>
                                    <option value="Estudio">Estudio</option>
                                </select>
                            </div>
                            </div>
                            <br>
                            <div class="row text-center">
                                <input type="submit" class="btn btn-primary" name="submit" value="Buscar"> 
                            </div>
                        </fieldset>
                    </div>
                    
           <%
                String nombre;
                String pais;
                String tipo;
                String activa = "1";
                
                
                ConexionBD conexionbd = null;
               
                ResultSet rs = null;

                try {
                    nombre = request.getParameter("text_NomInstitucion");
                    pais = request.getParameter("tex_paisInstitucion");
                    tipo = request.getParameter("select_tipoInstitucion");
                    
                    
                    

                    //formando la consulta
                    String consultaSql;
                    //out.write(consultaSql);
                    //realizando la consulta
                 
             if ( ((nombre == null) || (nombre.equals("")))){
                    if(((pais == null) || (pais.equals("")))){
                            if(((tipo == null) || (tipo.equals("")))){
                                    consultaSql = "SELECT NOMBRE_INSTITUCION, TIPO_INSTITUCION, PAIS, PAGINA_WEB, EMAIL  FROM  INSTITUCION WHERE  INSTITUCION_ACTIVA ='"+activa+"';";
                                    System.out.println("consulta: esta se realiza todo");
                            }
                            else{
                                    consultaSql = "SELECT NOMBRE_INSTITUCION, TIPO_INSTITUCION, PAIS, PAGINA_WEB, EMAIL  FROM  INSTITUCION WHERE TIPO_INSTITUCION ='"+tipo+"' && INSTITUCION_ACTIVA ='"+activa+"';";
                                    System.out.println("consulta: esta se realiza tipo ");   
                            }
                    }
                    else{
                            if(((tipo == null) || (tipo.equals("")))){
                                    consultaSql = "SELECT NOMBRE_INSTITUCION, TIPO_INSTITUCION, PAIS, PAGINA_WEB, EMAIL  FROM  INSTITUCION WHERE PAIS ='"+pais+"' && INSTITUCION_ACTIVA ='"+activa+"';";
                                    System.out.println("consulta: esta se realiza pais");  
                            }
                            else{
                                    consultaSql = "SELECT NOMBRE_INSTITUCION, TIPO_INSTITUCION, PAIS, PAGINA_WEB, EMAIL  FROM  INSTITUCION WHERE TIPO_INSTITUCION ='"+tipo+"' && PAIS ='"+pais+"' && INSTITUCION_ACTIVA ='"+activa+"';";
                                    System.out.println("consulta: esta se realiza pais mas tipo");	
                            }
								
								
                    }
            }
            else{
                    if(((pais == null) || (pais.equals("")))){
                            if(((tipo == null) || (tipo.equals("")))){
                                    consultaSql = "SELECT NOMBRE_INSTITUCION, TIPO_INSTITUCION, PAIS, PAGINA_WEB, EMAIL  FROM  INSTITUCION WHERE NOMBRE_INSTITUCION ='"+nombre+"' && INSTITUCION_ACTIVA ='"+activa+"';";
                                    System.out.println("error: esta se realiza nombre"); 
                            }
                            else{
                                    consultaSql = "SELECT NOMBRE_INSTITUCION, TIPO_INSTITUCION, PAIS, PAGINA_WEB, EMAIL  FROM INSTITUCION WHERE TIPO_INSTITUCION ='"+tipo+"' && NOMBRE_INSTITUCION='"+nombre+"' && INSTITUCION_ACTIVA ='"+activa+"';";
                                    System.out.println("consulta: esta se realiza nombre mas tipo");												
                            }
                    }
                    else{
                            if(((tipo == null) || (tipo.equals("")))){
                                    consultaSql = "SELECT NOMBRE_INSTITUCION, TIPO_INSTITUCION, PAIS, PAGINA_WEB, EMAIL  FROM  INSTITUCION WHERE PAIS ='"+pais+"' && NOMBRE_INSTITUCION='"+nombre+"' && INSTITUCION_ACTIVA ='"+activa+"';";
                                    System.out.println("consulta: esta se realiza nombre mas pais");												
													
                            }
                            else{
                                    consultaSql = "SELECT NOMBRE_INSTITUCION, TIPO_INSTITUCION, PAIS, PAGINA_WEB, EMAIL  FROM  INSTITUCION WHERE PAIS ='"+pais+"' && NOMBRE_INSTITUCION='"+nombre+"' && TIPO_INSTITUCION ='"+tipo+"' && INSTITUCION_ACTIVA ='"+activa+"';";
                                    System.out.println("consulta: esta se realiza nombre mas pais mas tipo");
                            }
                    }
            }
                    
                    
            conexionbd = new ConexionBD();
            rs = conexionbd.consultaSql(consultaSql);;
                    //con el rs se llenara la tabla de resultados
            } catch (Exception ex) {
                   System.out.println("error: " + ex);
            }
            %>  
                    
                    
                    
                    
                    
                    
                    <br>
                    <div class="row">
                       <table class="table">
                            <thead>
                                <th>No</th>
                                <th>Nombre de la institución</th>
                                <th>Tipo institución</th>
                                <th>País</th>
                                <th>Página web</th>
                                <th>Correo electronico</th>
                                
                                <th>Opción</th>
                            </thead>
                            <tbody>
                                 <%
                                try {
                                    Integer i = 0;
                                    while (rs.next()) {
                                        i = i + 1;
                                        out.write("<tr>");
                                        out.write("<td>" + i + "</td>");
                                        out.write("<td>" + rs.getString(1) + "</td>");
                                        out.write("<td>" + rs.getString(2) + "</td>");
                                        out.write("<td>" + rs.getString(3) + "</td>");
                                        out.write("<td>" + rs.getString(4) + "</td>");
                                        out.write("<td>" + rs.getString(5) + "</td>");
                                        out.write("<td>");
                                        out.write("<center>");
                                        out.write("<form style='display:inline;' action='205_modificar_institucion.jsp' method='post'><input type='hidden' name='NOMBRE_INSTITUCION' value='" + rs.getString(5) + "'><input type='submit' class='btn btn-success' name='submit' value='Editar'></form> ");
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
                </fieldset>
                    
             </form> 
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
        <script src="js/consultarInstitucion.js"></script>
    </body>
</html>
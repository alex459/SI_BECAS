<%-- 
    Document   : documentos
    Created on : 10-16-2016, 05:11:54 PM
    Author     : MauricioBC
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Documento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<% 
   response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String rol=(String)actual.getAttribute("rol");
    String user=(String)actual.getAttribute("user");
     if(user==null){
     response.sendRedirect("login.jsp");
        return;
     }  
    response.setContentType("text/html;charset=UTF-8"); 
    request.setCharacterEncoding("UTF-8");
            ConexionBD conexionbd = null;
            ResultSet rs = null;
            ArrayList<Documento> listaDocs = new ArrayList();
            Documento temp3 = new Documento();
            try {
                //formando la consulta
                String consultaSql="";
                    consultaSql = "SELECT ID_DOCUMENTO,OBSERVACION_O FROM DOCUMENTO WHERE ESTADO_DOCUMENTO='Publico'";                
                System.out.println(consultaSql);  
                //realizando la consulta
                conexionbd = new ConexionBD();
                rs = conexionbd.consultaSql(consultaSql);              
                while (rs.next()) {
                    temp3 = new Documento();
                    temp3.setIdDocumento(rs.getInt("ID_DOCUMENTO"));
                    temp3.setObservacion(rs.getString("OBSERVACION_O"));
                    listaDocs.add(temp3);
                    System.out.println("GGGGGGGGTTTTTTTTT");
                }
                //con el rs se llenara la tabla de resultados
            } catch (Exception ex) {
                System.out.println(ex);
            }
        %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Sistema informático para la administración de becas de postgrado</title>

    <meta name="description" content="Source code generated using layoutit.com">
    <meta name="author" content="LayoutIt!">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

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
<p class="text-right">Rol: <%= rol %></p>
<p class="text-right">Usuario: <%= user %></p>
<jsp:include page="menuCandidato.jsp"></jsp:include>
</head>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">

            <div class="col-xs-12" style="height:50px;"></div>
            <div class="jumbotron" style="background-color:white; ">
                <div class="row">
                        <h2>Documentos publicos</h2>
                        <fieldset class="custom-border"> 
            <legend class="custom-border">Documentos disponibles</legend>   <table class="table">
                            <thead>
                                <tr>
                                    <th>Nombre del documento</th>
                                    <th>Descripción</th>
                                    <th>Archivo</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                            if (listaDocs.size() >= 0) {
                                                int i = 0;
                                                while (i < listaDocs.size()) {
                                        %><tr class="bg-primary"><%
                                        %><td></td><%
                                        %><td><%=listaDocs.get(i).getObservacion()%></td><%
                                        %><td>
                                            <center><form action="Documento" method="post"  target="_blank"> 
                                                    <input type="hidden" name="id" value="<%=listaDocs.get(i).getIdDocumento()%>">
                                                    <input type="submit" class="btn btn-primary" value="Ver Documento">
                                                    </form></center></td><%    
                                                    i++;
                                                }
                                            }
                                            %>   
                                    </tr>
                            </tbody>
                        </table>
                     </fieldset>   
                </div>
            </div>
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
<script src="js/scripts.js"></script>
</body>
</html>

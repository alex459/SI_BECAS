<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="POJO.Usuario"%>
<%@page import="DAO.SolocitudBecaDAO"%>
<%@page import="POJO.SolicitudDeBeca"%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page import="POJO.Expediente"%>
<%@page import="DAO.ProgresoDAO"%>
<%@page import="POJO.Progreso"%>
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
   //
   int idUser, idSol, idExp, idProg;
            ConexionBD conexionbd = null;
            ResultSet rs = null;
            Usuario temp1=new Usuario();
            SolicitudDeBeca temp2=new SolicitudDeBeca();
            Expediente temp3=new Expediente();
            Progreso temp4=new Progreso();
            //////////Obtener el id del usuario
             try {
                //formando la consulta
                String consultaSql="SELECT ID_USUARIO FROM USUARIO WHERE NOMBRE_USUARIO='"+user+"';";
                //realizando la consulta
                conexionbd = new ConexionBD();
                rs = conexionbd.consultaSql(consultaSql); 
                temp1 = new Usuario();
                if(rs.next()) {
                    temp1.setIdUsuario(rs.getInt("ID_USUARIO"));
                }
                //con el rs se llenara la tabla de resultados
            } catch (Exception ex) {
                System.out.println(ex);
            }
            idUser=temp1.getIdUsuario();
            ////////Obtener el id del expediente
             try {
                //formando la consulta
                String consultaSql= "SELECT ID_EXPEDIENTE FROM SOLICITUD_DE_BECA WHERE ID_USUARIO="+idUser;
                //realizando la consulta
                conexionbd = new ConexionBD();
                rs = conexionbd.consultaSql(consultaSql); 
                temp2 = new SolicitudDeBeca();
                if(rs.next()) {
                    temp2.setIdExpediente(rs.getInt("ID_EXPEDIENTE"));
                }
                //con el rs se llenara la tabla de resultados
            } catch (Exception ex) {
                System.out.println(ex);
            }
            idExp=temp2.getIdExpediente();
            ////////Obtener el id del progreso actual del candidato
             try {
                //formando la consulta
                String consultaSql= "SELECT ID_PROGRESO FROM EXPEDIENTE WHERE ID_EXPEDIENTE="+idExp;
                //realizando la consulta
                conexionbd = new ConexionBD();
                rs = conexionbd.consultaSql(consultaSql); 
                temp3 = new Expediente();
                if(rs.next()) {
                    temp3.setIdProgreso(rs.getInt("ID_PROGRESO"));
                }
                //con el rs se llenara la tabla de resultados
            } catch (Exception ex) {
                System.out.println(ex);
            }
            idProg=temp3.getIdProgreso();
            System.out.println("IDUS: "+idUser+" IDEXP: "+idExp+" ID_PROG: "+idProg);
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
<p class="text-right">Rol: <%= rol %></p>
<p class="text-right">Usuario: <%= user %></p>
<jsp:include page="menuCandidato.jsp"></jsp:include>
</head>
<body>

    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Estado del proceso de beca</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Becas</legend>
        <div class="row">            
            <div class="col-md-6">
                <div class = "panel panel-default">
                   <table class="table table-bordered">
                    <thead>
                        <tr class="success">
                            <th>Proceso</th>
                            <th>Estado</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>                            
                            <td style="background-color:#728FCE; color:white">Sin iniciar</td>
                            <%
                            if(idProg==1)    
                            out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                            else
                            out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                            %>        
                            <td class="text-center" style="background-color:white; color:black;">
                                <center>                                    
                                <form style='display:inline;' >
                                    <%
                                    if(idProg==1)    
                                    out.write("<input type='submit' class='btn btn-success' name='submit' value='Ver -opción-'>");
                                    else
                                    out.write("<input type='submit' class='btn btn-success' name='submit' value='Ver -opción-' disabled>");
                                                                %>
                                </form>
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Permiso inicial de junta directova</td>
                            <%
                             if(idProg<2)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(idProg==2)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Proceso</td>");
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(idProg<2){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(idProg==2){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>  
                                    </button>                                
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Autorización inicial del consejo de becas</td>
                            <%
                             if(idProg<3)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(idProg==3)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Proceso</td>");
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(idProg<3){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(idProg==3){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                                    </button>
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Dictamen de la comisión de beca</td>
                            <%
                             if(idProg<4)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(idProg==4)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Proceso</td>");
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(idProg<4){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(idProg==4){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                                    </button>
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Acuerdos de permisos de beca de junta directiva</td>
                            <%
                             if(idProg<5)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(idProg==5)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Proceso</td>");
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(idProg<5){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(idProg==5){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                                    </button>
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Solicitud de beca</td>
                            <%
                             if(idProg<6)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(idProg==6)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Proceso</td>");
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(idProg<6){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(idProg==6){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                                    </button>
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Resolución del expediente de beca</td>
                            <%
                             if(idProg<7)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(idProg==7)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Proceso</td>");
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(idProg<7){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(idProg==7){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                                    </button>
                            </form>
                            </td>
                        </tr>
                        <tr>
                            <td style="background-color:#728FCE; color:white">Acuerdos de beca del consejo superior universitario</td>
                            <%
                             if(idProg<8)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>Pendiente</td>");
                             else if(idProg==8)
                                 out.write("<td style='background-color:#E5E4E2; color:black;'>En Proceso</td>");
                             else 
                                out.write("<td style='background-color:#E5E4E2; color:black;'>Finalizado</td>");
                                    %>
                            <td class="text-center" style="background-color:white;">
                            <form style='display:inline; color:black;' >
                              <%
                             if(idProg<8){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-lock'></span>");
                             }else if(idProg==8){
                                 out.write("<button type='submit' class='btn btn-default' disabled>");
                                 out.write("<span class='glyphicon glyphicon-arrow-left'></span>");
                             }else{ 
                                out.write("<button type='submit' class='btn btn-success' disabled>");
                                out.write("<span class='glyphicon glyphicon-check'></span> ");
                             }%>
                                    </button>
                            </form>
                            </td>
                        </tr>
                    </tbody>
                </table> 
                </div>
            </div>              
            <div class="col-md-5">
                <h3>Detalle</h3>
                <div class = "panel panel-default">
                    </br><div class="row">
                        <div class="col-md-12 col-md-offset-1">
                        colocar aqui descripcion del proceso 
                        </div>
                    </div></br>
                    <div class="row">
                        <div class="col-md-12 col-md-offset-4">
                        <button id="solicitar" name="solicitar" class="btn btn-success">Solicitar ahora</button>
                        </div>
                    </div></br>
                    <div class="row">
                        <div class="col-md-12 col-md-offset-4">
                         <button id="cancelar" name="cancelar" class="btn btn-danger">Cancelar proceso</button>
                        </div>
                    </div></br>
                </div>
            </div>  
        </div></fieldset>

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

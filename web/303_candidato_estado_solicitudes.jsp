<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="DAO.DocumentoDAO"%>
<%@page import="POJO.Documento"%>
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
    String rol = (String) actual.getAttribute("rol");
    String user = (String) actual.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    boolean expedienteAbierto = false; 
    Expediente expediente = new Expediente();
    //Obtener Expediente Abierto
    try{
        // Comprobando si tiene un proceso de beca abierto
        ExpedienteDAO expDao = new ExpedienteDAO();
        expedienteAbierto = expDao.expedienteAbierto(user);
        if(expedienteAbierto == true){
            //obtener el expediente
            expDao = new ExpedienteDAO();
            expediente = expDao.obtenerExpedienteAbierto(user);
        }else{
        expediente.setIdProgreso(0);        
        }
    } catch (Exception e){
        e.printStackTrace();
    }
    int idExp= expediente.getIdExpediente();
    int idProg = expediente.getIdProgreso();
    Documento doc=new Documento();
    DocumentoDAO docDao= new DocumentoDAO();
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
<p class="text-right">Rol: <%= rol%></p>
<p class="text-right">Usuario: <%= user%></p>
<jsp:include page="menuCandidato.jsp"></jsp:include>
</head>
<body>


    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Estado de solicitudes</H3>
            <fieldset class="custom-border">
                <legend class="custom-border">Solicitudes realizadas</legend>
                <div class="row">
                    <div class="col-md-12">
                        <table class="table table-bordered">

                            <thead>
                                <tr class="success">
                                    <th>No</th>
                                    <th>Solicitud</th>
                                    <th>Unidad</th>
                                    <th>Fecha solicitud</th>
                                    <th>Estado</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="info">
                                    <td style="color:black;">1</>
                                    <td style="color:black;">Permiso Inicial</td>
                                    <td style="color:black;">Junta directiva de la facultad</td>
                                    <td style="color:black;"> </td>
                                <%
                                    if (idProg == 1) {
                                        out.write("<td style='color:black;'>Pendiente</td>");
                                    } else {
                                        out.write("<td  style='color:black;'>Finalizado</td>");
                                    }
                                    if (idProg > 1) 
                                    { %><td><form action="VerDocumentoCandidato" method="post"  target="_blank"> 
                                                    <input type="hidden" name="idexp" value="<%=idExp%>">
                                                    <input type="hidden" name="idprog" value="<%=idProg%>">
                                                    <input type="hidden" name="idtipodoc" value="<%=200%>">
                                                    <input type="submit" class="btn btn-primary" value="Ver Documento">
                                                    </form></td><%    }
                                    else{
                                out.write("<td><button id='Editar' name='Editar' href='304_candidato_sol_permiso_inicial.jsp' class='btn btn-success'>Editar</button>");                                    
                                    out.write("<button id='cancelar' name='cancelar' class='btn btn-danger'>Cancelar</button></td>");}
                                %> 
                            </tr>
                            <tr class="info">
                                <td style="color:black;">2</>
                                <td>Autorización inicial</td>
                                <td>Consejo de becas</td>
                                <td style="color:black;"> </td>
                                <%
                                    if (idProg < 2) {
                                        out.write("<td style=' color:black;'>Pendiente</td>");
                                    } else if (idProg == 2) {
                                        out.write("<td style=' color:black;'>En Proceso</td>");
                                    } else {
                                        out.write("<td style=' color:black;'>Finalizado</td>");
                                    }
                                if (idProg > 2) 
                                     { %><td><form action="VerDocumentoCandidato" method="post"  target="_blank"> 
                                                    <input type="hidden" name="idexp" value="<%=idExp%>">
                                                    <input type="hidden" name="idprog" value="<%=idProg%>">
                                                    <input type="submit" class="btn btn-primary" value="Ver Documento">
                                                    </form></td><%    }
                                else{
                                out.write("<td><button id='Editar' name='Editar' href='306_candidato_sol_autorizacion_inicial.jsp' class='btn btn-success'>Editar</button>");                                    
                                    out.write("<button id='cancelar' name='cancelar' class='btn btn-danger'>Cancelar</button></td>");}
                                %> 
                            </tr>
                            <tr class="info">
                                <td style="color:black;">3</>
                                <td style="color:black;">Dictamen</td>
                                <td style="color:black;">Comisión de beca</td>
                                <td style="color:black;"> </td>
                                <%
                                    if (idProg < 3) {
                                        out.write("<td style=' color:black;'>Pendiente</td>");
                                    } else if (idProg == 3) {
                                        out.write("<td style=' color:black;'>En Proceso</td>");
                                    } else {
                                        out.write("<td style=' color:black;'>Finalizado</td>");
                                    }
                                if (idProg > 3) 
                                    { %><td><form action="VerDocumentoCandidato" method="post"  target="_blank"> 
                                                    <input type="hidden" name="idexp" value="<%=idExp%>">
                                                    <input type="hidden" name="idprog" value="<%=idProg%>">
                                                    <input type="submit" class="btn btn-primary" value="Ver Documento">
                                                    </form></td><%    } 
                                else{
                                out.write("<td><button id='Editar' name='Editar' href='307_candidato_sol_dictamen_propuesta.jsp' class='btn btn-success'>Editar</button>");                                    
                                    out.write("<button id='cancelar' name='cancelar' class='btn btn-danger'>Cancelar</button></td>");}
                                %> 
                            </tr>
                            <tr class="info">
                                <td style="color:black;">4</>
                                <td>Acuerdo de permiso inicial</td>
                                <td>Junta directiva</td>
                                <td> </td>
                                <%
                                    if (idProg < 4) {
                                        out.write("<td style=' color:black;'>Pendiente</td>");
                                    } else if (idProg == 4) {
                                        out.write("<td style=' color:black;'>En Proceso</td>");
                                    } else {
                                        out.write("<td style=' color:black;'>Finalizado</td>");
                                    }
                                if (idProg > 4) 
                                      { %><td><form action="VerDocumentoCandidato" method="post"  target="_blank"> 
                                                    <input type="hidden" name="idexp" value="<%=idExp%>">
                                                    <input type="hidden" name="idprog" value="<%=idProg%>">
                                                    <input type="submit" class="btn btn-primary" value="Ver Documento">
                                                    </form></td><%    }
                                else{
                                out.write("<td><button id='Editar' name='Editar' href='307_candidato_sol_dictamen_propuesta.jsp' class='btn btn-success'>Editar</button>");                                    
                                    out.write("<button id='cancelar' name='cancelar' class='btn btn-danger'>Cancelar</button></td>");}
                                %> 
                            </tr>
                            <tr class="info">
                                <td style="color:black;">5</>
                                <td style="color:black;">Solicitud de beca</td>
                                <td style="color:black;">Consejo de becas</td>
                                <td style="color:black;"> </td>
                                <%
                                    if (idProg < 5) {
                                        out.write("<td style=' color:black;'>Pendiente</td>");
                                    } else if (idProg == 5) {
                                        out.write("<td style=' color:black;'>En Proceso</td>");
                                    } else {
                                        out.write("<td style=' color:black;'>Finalizado</td>");
                                    }
                                if (idProg > 5) 
                                      { %><td><form action="VerDocumentoCandidato" method="post"  target="_blank"> 
                                                    <input type="hidden" name="idexp" value="<%=idExp%>">
                                                    <input type="hidden" name="idprog" value="<%=idProg%>">
                                                    <input type="submit" class="btn btn-primary" value="Ver Documento">
                                                    </form></td><%    } 
                                else{
                                out.write("<td><button id='Editar' name='Editar' href='308_candidato_sol_beca1.jsp' class='btn btn-success'>Editar</button>");                                    
                                    out.write("<button id='cancelar' name='cancelar' class='btn btn-danger'>Cancelar</button></td>");}
                                %> 
                            </tr>
                            <tr class="info">
                                <td style="color:black;">6</>
                                <td>Resolución de expediente de beca</td>
                                <td>Consejo de becas</td>
                                <td> </td>
                                <%
                                    if (idProg < 6) {
                                        out.write("<td style=' color:black;'>Pendiente</td>");
                                    } else if (idProg == 6) {
                                        out.write("<td style=' color:black;'>En Proceso</td>");
                                    } else {
                                        out.write("<td style=' color:black;'>Finalizado</td>");
                                    }
                                if (idProg > 6) 
                                       { %><td><form action="VerDocumentoCandidato" method="post"  target="_blank"> 
                                                    <input type="hidden" name="idexp" value="<%=idExp%>">
                                                    <input type="hidden" name="idprog" value="<%=idProg%>">
                                                    <input type="submit" class="btn btn-primary" value="Ver Documento">
                                                    </form></td><%    }
                                else{
                                out.write("<td><button id='Editar' name='Editar' class='btn btn-success'>Editar</button>");                                    
                                    out.write("<button id='cancelar' name='cancelar' class='btn btn-danger'>Cancelar</button></td>");}
                                %> 
                            </tr>
                            <tr class="info">
                                <td style="color:black;">7</>
                                <td style="color:black;">Acuerdos de beca</td>
                                <td style="color:black;">Consejo universitario</td>
                                <td style="color:black;"> </td>
                                <%
                                    if (idProg < 7) {
                                        out.write("<td style=' color:black;'>Pendiente</td>");
                                    } else if (idProg == 7) {
                                        out.write("<td style=' color:black;'>En Proceso</td>");
                                    } else {
                                        out.write("<td style=' color:black;'>Finalizado</td>");
                                    }
                                if (idProg > 7) 
                                      { %><td><form action="VerDocumentoCandidato" method="post"  target="_blank"> 
                                                    <input type="hidden" name="idexp" value="<%=idExp%>">
                                                    <input type="hidden" name="idprog" value="<%=idProg%>">
                                                    <input type="submit" class="btn btn-primary" value="Ver Documento">
                                                    </form></td><%    }
                                else{
                                out.write("<td><button id='Editar' name='Editar' class='btn btn-success'>Editar</button>");                                    
                                    out.write("<button id='cancelar' name='cancelar' class='btn btn-danger'>Cancelar</button></td>");}
                                %> 
                            </tr>
                        </tbody>
                    </table>
                </div> 
            </div>
        </fieldset>

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

<%-- 
    Document   : 203_1_datos_del_becario_a_suspender
    Created on : 11-15-2016, 04:41:14 AM
    Author     : Manuel Miranda
--%>

<%@page import="DAO.ConexionBD"%>
<%@page import="java.sql.ResultSet"%>
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
     
    String idUsuario = request.getParameter("ID_USUARIO");
    String consultaSql;

    consultaSql = "SELECT U.NOMBRE_USUARIO, DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, F.FACULTAD, SC.NOMBRE_INSTITUCION, SC.TIPO_OFERTA_BECA, P.ESTADO_BECARIO, SC.ID_EXPEDIENTE, P.ID_PROGRESO"+
            " FROM FACULTAD F INNER JOIN DETALLE_USUARIO DU ON F.ID_FACULTAD = DU.ID_FACULTAD INNER JOIN USUARIO U ON DU.ID_USUARIO = U.ID_USUARIO"+
            " JOIN (SELECT I.NOMBRE_INSTITUCION, OB.TIPO_OFERTA_BECA, SB.ID_USUARIO, SB.ID_EXPEDIENTE, I.ID_INSTITUCION"+
                    " FROM INSTITUCION I INNER JOIN OFERTA_BECA OB ON I.ID_INSTITUCION = OB.ID_INSTITUCION_ESTUDIO NATURAL JOIN SOLICITUD_DE_BECA SB) SC ON U.ID_USUARIO = SC.ID_USUARIO"+
            " INNER JOIN EXPEDIENTE E ON SC.ID_EXPEDIENTE = E.ID_EXPEDIENTE INNER JOIN PROGRESO P ON E.ID_PROGRESO = P.ID_PROGRESO WHERE ESTADO_EXPEDIENTE = 'ABIERTO' AND U.NOMBRE_USUARIO LIKE '%" + idUsuario + "%'";

    ResultSet rs = null;
    ConexionBD conexionBD = new ConexionBD();

    String carnet=new String();
    String nombre1=new String();
    String nombre2=new String();
    String apellido1=new String();
    String apellido2=new String();
    String facultad=new String();
    String univ_estudio=new String();
    String tipo_beca=new String();
    String estado_becario=new String(); 
    Integer idExpediente = 0;
    Integer idProgreso = 0;
    try{
        rs = conexionBD.consultaSql(consultaSql);  
        while(rs.next()){
            carnet = rs.getString(1);
            nombre1 = rs.getString(2);
            nombre2 = rs.getString(3);
            apellido1 = rs.getString(4);
            apellido2 = rs.getString(5);
            facultad = rs.getString(6);
            univ_estudio = rs.getString(7);
            tipo_beca = rs.getString(8);
            estado_becario = rs.getString(9);
            idExpediente = rs.getInt(10);
            idProgreso = rs.getInt(11);
        }
    }catch(Exception ex){
        System.err.println("error: "+ex);
    }
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

        <p class="text-right" style="font-weight:bold;">Rol: <%= rol %></p>
        <p class="text-right" style="font-weight:bold;">Usuario: <%= user %></p>

        <%-- todo el menu esta contenido en la siguiente linea
             el menu puede ser cambiado en la pagina menu.jsp --%>
        <jsp:include page="menu_corto.jsp"></jsp:include>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row"><!-- TITULO DE LA PANTALLA -->
                <h2>
                    <p class="text-center" style="color:#cf2a27">Suspender becario</p>
                </h2>
                <br></br> 
            </div><!-- TITULO DE LA PANTALLA -->  

            <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->
                <form class="form-horizontal" action="SuspenderBecarioServlet" method="post">
                    <fieldset class="custom-border">
                        <legend class="custom-border">Suspender becario</legend>
                        <div class="col-md-6 col-md-offset-3">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Datos del becario</legend>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Id usuario : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <label><%=idUsuario%></label>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Nombre del becario : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <label><%=nombre1 +" "+nombre2+" "+apellido1+" "+apellido2%></label>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Facultad : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <label><%=facultad%></label>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Universidad de estudio : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <label><%=univ_estudio%></label>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Tipo de beca : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <label><%=tipo_beca%></label>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Estado del becario : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <label><%=estado_becario%></label>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Suspender becario : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="checkbox" name="SUSPENDER_BECARIO" value="True">
                                    </div>
                                </div>
                                <br>
                                <div class="row text-center">
                                    <input type="hidden" name="idExpediente" value="<%=idExpediente%>">
                                    <input type="hidden" name="idUsuario" value="<%=idUsuario%>">
                                    <input type="submit" class="btn btn-primary" name="submit" value="Suspender">
                                </div>
                            </fieldset>
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
        <script src="js/scripts.js"></script>
        <script src="js/angular.min.js"></script>
    </body>
</html>

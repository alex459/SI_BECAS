<%-- 
    Document   : 203_suspender_becario
    Created on : 11-07-2016, 04:39:34 AM
    Author     : Manuel Miranda
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Facultad"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.InstitucionDAO"%>
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
                    <p class="text-center" style="color:#cf2a27">Suspender Becario</p>
                </h2>
                <br></br> 
            </div><!-- TITULO DE LA PANTALLA -->  

            <div class="col-md-12"><!-- CONTENIDO DE LA PANTALLA -->
                <form class="form-horizontal" action="203_consulta_suspender_becario.jsp" method="post">
                    <fieldset class="custom-border">
                        <legend class="custom-border">Suspender Becario</legend>
                        <div class="col-md-6 col-md-offset-3">
                            <fieldset class="custom-border">
                                <legend class="custom-border">filtros</legend>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Codigo : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <input id="textinput" name="ID_USUARIO" type="text" placeholder="ingrese el Id del usuario" class="form-control input-md">
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Nombre del becario : </label>
                                    </div>
                                    <div class="col-md-4">
                                        <input id="textinput" name="NOM_BECARIO1" type="text" placeholder="Primer nombre" class="form-control input-md">
                                    </div>
                                    <div class="col-md-4">
                                        <input id="textinput" name="NOM_BECARIO2" type="text" placeholder="Segundo nombre" class="form-control input-md">
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">

                                    </div>
                                    <div class="col-md-4">
                                        <input id="textinput" name="APELL_BECARIO1" type="text" placeholder="Primer apellido" class="form-control input-md">
                                    </div>
                                    <div class="col-md-4">
                                        <input id="textinput" name="APELL_BECARIO2" type="text" placeholder="Segundo apellido" class="form-control input-md">
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Facultad : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <select id="selectbasic" name="ID_FACULTAD" class="form-control">   
                                            <option value=0></option>
                                            <%
                                                FacultadDAO facultadDao = new FacultadDAO();
                                                ArrayList<Facultad> listaFacultades = new ArrayList<Facultad>();
                                                listaFacultades = facultadDao.consultarTodos();
                                                for (int i = 0; i < listaFacultades.size(); i++) {
                                                    out.write("<option value=" + listaFacultades.get(i).getIdFacultad() + ">" + listaFacultades.get(i).getFacultad() + "</option>");
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Universidad de estudio : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <select id="selectbasic" name="UNIV_ESTUDIO" class="form-control">                            
                                            <option value=0></option>
                                            <%
                                                InstitucionDAO institucionDao = new InstitucionDAO();
                                                ArrayList<Institucion> listaInstitucionEst = new ArrayList<Institucion>();
                                                listaInstitucionEst = institucionDao.consultarPorTipo("ESTUDIO");
                                                for (int i = 0; i < listaInstitucionEst.size(); i++) {
                                                    out.write("<option value=" + listaInstitucionEst.get(i).getIdInstitucion() + ">" + listaInstitucionEst.get(i).getNombreInstitucion() + "</option>");
                                                }
                                            %>
                                        </select>
                                    </div>
                                </div>
                                <br>
                                <div class="row">
                                    <div class="col-md-4 text-right">
                                        <label for="textinput">Tipo de beca : </label>
                                    </div>
                                    <div class="col-md-6">
                                        <select id="selectbasic" name="TIPO_BECA" class="form-control">                            
                                            <option value="">Seleccione tipo de beca</option>
                                            <option value="INTERNA">INTERNA</option>
                                            <option value="EXTERNA">EXTERNA</option>
                                        </select>
                                    </div>
                                </div>
                                <br>
                                <div class="row text-center">
                                    <input type="submit" class="btn btn-primary" name="submit" value="Consultar">
                                </div>
                            </fieldset>
                        </div>
                        <%
                            response.setContentType("text/html;charset=UTF-8");
                            request.setCharacterEncoding("UTF-8");
                            String carnet;
                            String nombre1;
                            String nombre2;
                            String apellido1;
                            String apellido2;
                            Integer id_facultad;
                            Integer id_univ_estudio;
                            String tipo_beca;
                            ConexionBD conexionbd = null;
                            ResultSet rs = null;

                            try {
                                carnet = request.getParameter("ID_USUARIO");
                                nombre1 = request.getParameter("NOM_BECARIO1");
                                nombre2 = request.getParameter("NOM_BECARIO2");
                                apellido1 = request.getParameter("APELL_BECARIO1");
                                apellido2 = request.getParameter("APELL_BECARIO2");
                                id_facultad = Integer.parseInt(request.getParameter("ID_FACULTAD"));
                                id_univ_estudio = Integer.parseInt(request.getParameter("UNIV_ESTUDIO"));
                                tipo_beca = request.getParameter("TIPO_BECA");

                                //formando la consulta
                                String consultaSql;

                                consultaSql = "SELECT U.NOMBRE_USUARIO, DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, F.FACULTAD, SC.NOMBRE_INSTITUCION, SC.TIPO_OFERTA_BECA, P.ESTADO_BECARIO"+
                                        " FROM FACULTAD F INNER JOIN DETALLE_USUARIO DU ON F.ID_FACULTAD = DU.ID_FACULTAD INNER JOIN USUARIO U ON DU.ID_USUARIO = U.ID_USUARIO"+
                                        " JOIN (SELECT I.NOMBRE_INSTITUCION, OB.TIPO_OFERTA_BECA, SB.ID_USUARIO, SB.ID_EXPEDIENTE, I.ID_INSTITUCION"+
                                                " FROM INSTITUCION I INNER JOIN OFERTA_BECA OB ON I.ID_INSTITUCION = OB.ID_INSTITUCION_ESTUDIO NATURAL JOIN SOLICITUD_DE_BECA SB) SC ON U.ID_USUARIO = SC.ID_USUARIO"+
                                        " INNER JOIN EXPEDIENTE E ON SC.ID_EXPEDIENTE = E.ID_EXPEDIENTE INNER JOIN PROGRESO P ON E.ID_PROGRESO = P.ID_PROGRESO WHERE ESTADO_EXPEDIENTE = 'ABIERTO' AND DU.NOMBRE1_DU LIKE '%" + nombre1 + "%' AND DU.NOMBRE2_DU LIKE '%" + nombre2 + "%' AND DU.APELLIDO1_DU LIKE '%" + apellido1 + "%' AND DU.APELLIDO2_DU LIKE '%" + apellido2 + "%' AND U.NOMBRE_USUARIO LIKE '%" + carnet + "%' AND SC.TIPO_OFERTA_BECA LIKE '%" + tipo_beca + "%'";

                                if (id_facultad != 0) {
                                    consultaSql = consultaSql.concat(" AND F.ID_FACULTAD = " + id_facultad + " ");
                                } 
                                if (id_univ_estudio != 0) {
                                    consultaSql = consultaSql.concat(" AND SC.ID_INSTITUCION = " + id_univ_estudio+" ");
                                }

                                //realizando la consulta
                                conexionbd = new ConexionBD();
                                rs = conexionbd.consultaSql(consultaSql);

                                //con el rs se llenara la tabla de resultados
                            } catch (Exception ex) {

                            }
                        %> 
                        <br>
                        <div class="row">
                           <table class="table">
                                <thead>
                                    <th>Usuario</th>
                                    <th>Nombre del becario</th>
                                    <th>Facultad</th>
                                    <th>Universidad</th>
                                    <th>Tipo de beca</th>
                                    <th>Estado</th>
                                    <th>Opcion</th>
                                </thead>
                                <tbody>
                                 <%       
                                    try {
                                        Integer i = 0;
                                        while (rs.next()) {
                                            out.write("<tr>");
                                            out.write("<td>" + rs.getString(1) + "</td>");
                                            out.write("<td>" + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4) + " " + rs.getString(5)+"</td>");
                                            out.write("<td>" + rs.getString(6) + "</td>");
                                            out.write("<td>" + rs.getString(7) + "</td>");
                                            out.write("<td>" + rs.getString(8) + "</td>");
                                            out.write("<td>" + rs.getString(9) + "</td>");
                                            out.write("<td>");
                                            out.write("<center>");
                                            out.write("<form style='display:inline;' action='' method='post'><input type='hidden'></form> ");
                                            out.write("<form style='display:inline;' action='203_1_suspender_becario.jsp' method='post'><input type='hidden' name='ID_USUARIO' value='" + rs.getString(1) + "'><input type='submit' class='btn btn-success' name='submit' value='Suspender'></form> ");
                                            out.write("</center>");
                                            out.write("</td>");
                                            out.write("</tr>");
                                            i = i + 1;
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
        <script src="js/scripts.js"></script>
    </body>
</html>
<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
--%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Facultad"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.TipoUsuario"%>
<%@page import="DAO.TipoUsuarioDao"%>
<%@page import="java.sql.ResultSet"%>
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



<p class="text-right">Rol: </p>
<p class="text-right">Usuario: </p>


<%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
<jsp:include page="menu.jsp"></jsp:include>

</head>
<body>

    <div class="container-fluid">
        <div class="row"><!-- TITULO DE LA PANTALLA -->
            <h2>
                <p class="text-center" style="color:#cf2a27">Consultar usuario</p>
            </h2>

            <br></br>

        </div><!-- TITULO DE LA PANTALLA -->  


        <div class="col-md-12">            
            <fieldset class="custom-border">  
                <legend class="custom-border">Consular usuario</legend> 


                <div class="row">   <!-- FILTROS -->

                    <div class="col-md-12">
                        <form class="form-horizontal" action="103_consultar_usuario.jsp" method="post">
                            <fieldset class="custom-border">  
                                <legend class="custom-border">Filtros</legend>                    
                                <div class="row"> 
                                    <div class="col-md-2 text-right">
                                        <label for="textinput">Nombre de Usuario : </label>                                
                                    </div>
                                    <div class="col-md-1">                                                                                    
                                        <input id="textinput" name="NOMBRE1" type="text" placeholder="primer nombre" class="form-control input-md">                                            
                                    </div> 
                                    <div class="col-md-1">    
                                        <input id="textinput" name="NOMBRE2" type="text" placeholder="segundo nombre" class="form-control input-md">                                            
                                    </div> 
                                    <div class="col-md-1">
                                        <input id="textinput" name="APELLIDO1" type="text" placeholder="primer apellido" class="form-control input-md">                                            
                                    </div> 
                                    <div class="col-md-1">
                                        <input id="textinput" name="APELLIDO2" type="text" placeholder="segundo apellido" class="form-control input-md">
                                    </div> 
                                    <div class="col-md-3 text-right">
                                        <label for="textinput">Facultad :</label>                                
                                    </div>
                                    <div class="col-md-3">                                

                                        <select id="selectbasic" name="ID_FACULTAD" class="form-control">
                                            <option value="0">TODOS</option>    
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
                                <div class="col-md-3 text-right">
                                    <label for="textinput">Codigo de Usuario : </label>                                
                                </div>
                                <div class="col-md-3">
                                    <input id="textinput" name="CARNET" type="text" placeholder="ingrese el carnet a buscar" class="form-control input-md">
                                </div>
                                <div class="col-md-3 text-right">
                                    <label for="textinput">Tipo de usuario :</label>                                
                                </div>
                                <div class="col-md-3">                                
                                    <select id="selectbasic" name="ID_TIPO_USUARIO" class="form-control">
                                        <option value="0">TODOS</option>
                                        <%
                                            TipoUsuarioDao tipoUsuarioDao = new TipoUsuarioDao();
                                            ArrayList<TipoUsuario> listaTiposDeUsuarios = new ArrayList<TipoUsuario>();
                                            listaTiposDeUsuarios = tipoUsuarioDao.consultarTodos();
                                            for (int i = 0; i < listaTiposDeUsuarios.size(); i++) {
                                                out.write("<option value=" + listaTiposDeUsuarios.get(i).getIdTipoUsuario() + ">" + listaTiposDeUsuarios.get(i).getTipoUsuario() + "</option>");
                                            }
                                        %>    
                                    </select> 
                                </div> 
                            </div>

                            <br>        

                            <div class="row">
                                <div class="col-md-12 text-center">
                                    <input type="submit" class="btn btn-primary" name="submit" value="Buscar">                       
                                </div>
                            </div>

                        </fieldset>
                    </form>                         
                </div>

            </div>


            <%
                String nombre1;
                String nombre2;
                String apellido1;
                String apellido2;
                String carnet;
                Integer id_facultad;
                Integer id_tipo_de_usuario;
                ConexionBD conexionbd = null;
                ResultSet rs = null;

                try {
                    nombre1 = request.getParameter("NOMBRE1");
                    nombre2 = request.getParameter("NOMBRE2");
                    apellido1 = request.getParameter("APELLIDO1");
                    apellido2 = request.getParameter("APELLIDO2");
                    carnet = request.getParameter("CARNET");
                    id_facultad = Integer.parseInt(request.getParameter("ID_FACULTAD"));
                    id_tipo_de_usuario = Integer.parseInt(request.getParameter("ID_TIPO_USUARIO"));

                    //formando la consulta
                    String consultaSql;

                    consultaSql = "SELECT DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, DU.CARNET, F.FACULTAD, TU.TIPO_USUARIO  FROM DETALLE_USUARIO DU NATURAL JOIN USUARIO U NATURAL JOIN FACULTAD F NATURAL JOIN TIPO_USUARIO TU WHERE DU.NOMBRE1_DU LIKE '%" + nombre1 + "%' AND DU.NOMBRE2_DU LIKE '%" + nombre2 + "%' AND DU.APELLIDO1_DU LIKE '%" + apellido1 + "%' AND DU.APELLIDO2_DU LIKE '%" + apellido2 + "%' AND DU.CARNET LIKE '%" + carnet + "%'";

                    if (id_tipo_de_usuario == 0) {

                    } else {
                        consultaSql = consultaSql.concat(" AND U.ID_TIPO_USUARIO = " + id_facultad + " ");
                    }
                    if (id_facultad == 0) {

                    } else {
                        consultaSql = consultaSql.concat(" AND DU.ID_FACULTAD = " + id_facultad);
                    }

                    //out.write(consultaSql);
                    
                    //realizando la consulta
                    conexionbd = new ConexionBD();
                    rs = conexionbd.consultaSql(consultaSql);

                    //con el rs se llenara la tabla de resultados
                } catch (Exception ex) {

                }
            %>                            

            <div class="row">   <!-- TABLA RESULTADOS -->

                <div class="col-md-12">

                    <table class="table table-bordered"></br>                        
                        <thead>
                            <tr class="success">
                                <th>No</th>
                                <th>Nombre de empleado</th>
                                <th>Codigo de usuario</th>
                                <th>Facultad</th>
                                <th>Tipo de empleado</th>
                                <th>Accion</th>
                            </tr>
                        </thead>
                        <tbody>                            
                            <%
                                try{
                                    Integer i = 0;
                                    while (rs.next()) {
                                        i=i+1;
                                        out.write("<tr class='info'>");
                                        out.write("<td>" + i + "</td>");
                                        out.write("<td>" + rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4) + "</td>");
                                        out.write("<td>" + rs.getString(5) + "</td>");
                                        out.write("<td>" + rs.getString(6) + "</td>");
                                        out.write("<td>" + rs.getString(7) + "</td>");
                                        out.write("<td>");
                                        out.write("<input type='submit' class='btn btn-success' name='submit' value='Editar'>");
                                        out.write("<input type='submit' class='btn btn-primary' name='submit' value='Modificar Rol'>");
                                        out.write("<input type='submit' class='btn btn-danger' name='submit' value='Dar de Baja'>");
                                        out.write("</td>");
                                        out.write("</tr>");
                                    }                                
                                }catch(Exception ex){
                                    System.out.println("error: "+ex);
                                }
                                    
                            %>                             
                        </tbody>
                    </table>
                </div>

            </div>


        </fieldset>                       
    </div>


</div>

<br></br>



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

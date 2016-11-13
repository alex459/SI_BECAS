<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
--%>

<%@page import="POJO.Facultad"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="POJO.TipoUsuario"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.TipoUsuarioDao"%>
<%@page import="DAO.ConexionBD"%>
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

    <%
        
        String id_usuario = request.getParameter("ID_USUARIO");
        String id_detalle_usuario = request.getParameter("ID_DETALLE_USUARIO");
        ConexionBD conexionBD = new ConexionBD();
        String consultaSql = "SELECT DU.CARNET, DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, U.CLAVE, U.ID_TIPO_USUARIO, TU.TIPO_USUARIO, DU.ID_FACULTAD, F.FACULTAD FROM DETALLE_USUARIO DU NATURAL JOIN USUARIO U NATURAL JOIN FACULTAD F NATURAL JOIN TIPO_USUARIO TU WHERE U.ID_USUARIO = "+id_usuario;
        ResultSet rs = null;
        out.write(consultaSql);
        String carnet=new String();
        String nombre1=new String();
        String nombre2=new String();
        String apellido1=new String();
        String apellido2=new String();
        String clave=new String();
        String id_tipo_usuario=new String();
        String tipo_usuario=new String();
        String id_facultad=new String();
        String facultad=new String();
        try{
            rs = conexionBD.consultaSql(consultaSql);  
            while(rs.next()){
                carnet = rs.getString(1);
                nombre1 = rs.getString(2);
                nombre2 = rs.getString(3);
                apellido1 = rs.getString(4);
                apellido2 = rs.getString(5);
                clave = rs.getString(6);
                id_tipo_usuario = rs.getString(7);
                tipo_usuario = rs.getString(8);
                id_facultad = rs.getString(9);
                facultad = rs.getString(10);
            }
        }catch(Exception ex){
            System.err.println("error: "+ex);
        }
        
        

        
        
    
    %>

    <div class="container-fluid">
        <div class="row"><!-- TITULO DE LA PANTALLA -->
            <h2>
                <p class="text-center" style="color:#cf2a27">Actualizar usuario</p>
            </h2>

            <br></br>

        </div><!-- TITULO DE LA PANTALLA -->  

        <div class="col-md-12">

            <form class="form-horizontal" action="ActualizarUsuarioServlet" method="post">
                <fieldset class="custom-border">  
                    <legend class="custom-border">Paso 2: Actualize los datos del usuario</legend>
                    <div class="row"> 
                        <div class="col-md-3 text-right">                                   
                            <label for="textinput">Codigo de usuario : </label>                                
                        </div>
                        <div class="col-md-3">                                                                                   
                            <input id="textinput" name="CARNET" type="text" value="<%=carnet%>" placeholder="ingrese el codigo de usuario" class="form-control input-md">
                        </div>
                        <div class="col-md-3 text-right">
                                                        
                        </div>
                        <div class="col-md-3">
                                                         
                        </div> 
                    </div> 

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Primer nombre : </label>                                
                        </div>
                        <div class="col-md-3">
                            <input id="textinput" name="NOMBRE1_DU" type="text" placeholder="ingrese el primer nombre" class="form-control input-md" value="<%=nombre1%>">                                                                
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="textinput">Segundo nombre :</label>                                
                        </div>
                        <div class="col-md-3">
                            <input id="textinput" name="NOMBRE2_DU" type="text" placeholder="ingrese el segundo nombre" class="form-control input-md" value="<%=nombre2%>">                                
                        </div>  
                    </div>

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Primer apellido :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <input id="textinput" name="APELLIDO1_DU" type="text" placeholder="ingrese el primer apellido" class="form-control input-md" value="<%=apellido1%>">
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="textinput">Segundo apellido :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <input id="textinput" name="APELLIDO2_DU" type="text" placeholder="ingrese el segundo apellido" class="form-control input-md" value="<%=apellido2%>">
                        </div>              
                    </div>                      

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Contraseña :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <input id="textinput" name="CLAVE" type="password" placeholder="ingrese una contraseña" class="form-control input-md" value="<%=clave%>">
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="textinput">Confirmar contraseña :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <input id="textinput" name="CLAVE2" type="password" placeholder="ingrese nuevamente la contraseña" class="form-control input-md" value="<%=clave%>">
                        </div>              
                    </div>

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="textinput">Rol del usuario :</label>                                
                        </div>
                        <div class="col-md-3">                                

                            <select id="selectbasic" name="ID_TIPO_USUARIO" class="form-control">
                            <%
                                TipoUsuarioDao tipoUsuarioDao = new TipoUsuarioDao();
                                ArrayList<TipoUsuario> listaTiposDeUsuarios = new ArrayList<TipoUsuario>();
                                listaTiposDeUsuarios = tipoUsuarioDao.consultarTodos();                                
                                out.write("<option value=" + id_tipo_usuario + ">" + tipo_usuario + "</option>");
                                for (int i = 0; i < listaTiposDeUsuarios.size(); i++) {
                                    out.write("<option value=" + listaTiposDeUsuarios.get(i).getIdTipoUsuario() + ">" + listaTiposDeUsuarios.get(i).getTipoUsuario() + "</option>");
                                }
                            %>    
                        </select> 

                    </div>
                    <div class="col-md-3 text-right">
                        <label for="textinput">Facultad :</label>                                
                    </div>
                    <div class="col-md-3">                                

                        <select id="selectbasic" name="ID_FACULTAD" class="form-control">
                            <%
                                FacultadDAO facultadDao = new FacultadDAO();
                                ArrayList<Facultad> listaFacultades = new ArrayList<Facultad>();
                                listaFacultades = facultadDao.consultarTodos();
                                out.write("<option value=" + id_facultad + ">" + facultad + "</option>");
                                for (int i = 0; i < listaFacultades.size(); i++) {
                                    out.write("<option value=" + listaFacultades.get(i).getIdFacultad() + ">" + listaFacultades.get(i).getFacultad() + "</option>");
                                }
                            %>                    
                        </select>
                    </div>              
                </div>

                <br>        

                <div class="row">
                    <div class="col-md-12 text-center">
                        <input type="hidden" name="ID_USUARIO" value="<%=id_usuario%>">
                        <input type="hidden" name="ID_DETALLE_USUARIO" value="<%=id_detalle_usuario%>">                        
                        <input type="submit" class="btn btn-primary" name="submit" value="Actualizar usuario">                        
                    </div>
                </div>

            </fieldset>
        </form>                    
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

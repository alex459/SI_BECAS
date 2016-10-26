<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
--%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="POJO.Facultad"%>
<%@page import="java.util.ArrayList"%>


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
                <p class="text-center" style="color:#cf2a27">Agregar usuario</p>
            </h2>

            <br></br> 
        </div><!-- TITULO DE LA PANTALLA -->  








        <div class="row"><!-- CONTENIDO DE LA PANTALLA -->

            <form action="" method="post">
                Codigo de empleado : <input type="text" name="CARNET" value="">
                <br></br>
                <input type="checkbox" name="ES_EMPLEADO" value=""> No es empleado.
                <br></br>
                Primer nombre : <input type="text" name="NOMBRE1_DU" value="">
                <br></br>
                Segundo nombre : <input type="text" name="NOMBRE2_DU" value="">
                <br></br>
                Segundo nombre : <input type="text" name="NOMBRE2_DU" value="">
                <br></br>
                Primer apellido : <input type="text" name="APELLIDO1_DU" value="">
                <br></br>
                Segundo apellido : <input type="text" name="APELLIDO2_DU" value="">
                <br></br>
                Contraseña : <input type="text" name="CLAVE" value="">
                <br></br>
                Confirmar contraseña : <input type="text" name="CLAVE" value="">
                <br></br>
                Rol del usuario :
                                
                <select name="ID_TIPO_USUARIO">
                    <option value="volvo">ADMINISTRADOR</option>
                    <option value="saab">DIRECTOR DEL CONSEJO DE BECAS</option>
                    <option value="opel">FISCALIA</option>
                    <option value="audi">CONSEJO SUPERIOR UNIVERSITARIO</option>
                </select> 
                
                <br></br>                
                Facultad : 
                                
                <select name="ID_FACULTAD">
                <% 
                    FacultadDAO facultadDao = new FacultadDAO();                    
                    ArrayList<Facultad> listaFacultades = new ArrayList<Facultad>();
                    listaFacultades = facultadDao.consultarTodos();
                    for(int i = 0; i <listaFacultades.size(); i++){                        
                        out.write("<option value="+listaFacultades.get(i).getIdFacultad()+">"+listaFacultades.get(i).getFacultad()+"</option>");
                    }
                %>                    
                </select>
                
                <br></br>
                <input type="submit" name="submit" value="Crear usuario">


            </form>

        </div><!-- CONTENIDO DE LA PANTALLA -->

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
    </div>

    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>
</body>
</html>

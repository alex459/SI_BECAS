<%-- 
    Document   : 501_Solicitudes_Asesoria_Contrato
    Created on : 26/10/2016, 10:48:48 AM
    Author     : adminPC
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Facultad"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.FacultadDAO"%>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>

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



<p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
<p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


<%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
<jsp:include page="menu_corto.jsp"></jsp:include>


</head>



<body ng-app="solicitudAsesoriaContratoApp" ng-controller="solicitudAsesoriaContratoCtrl">

    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Solicitudes de Asesoria de Contrato de Beca</H3>
        <fieldset class="custom-border">
            <legend class="custom-border">Solicitudes</legend>
            <div class="row">            


                <fieldset class="custom-border">
                    <legend class="custom-border">Filtros</legend>
                    <form name= "solicitudAsesoriaContrato" class="form-horizontal" action="501_Solicitudes_Asesoria_Contrato.jsp" method="post" novalidate>

                        <div class="row">
                            <div class="col-md-1 text-right">
                                <label for="textinput">Codigo de Usuario : </label>                                
                            </div>
                            <div class="col-md-2">
                                <input id="CARNET" name="CARNET" type="text" placeholder="ingrese el usuario a buscar" class="form-control input-md" ng-model="datos.codigo" ng-pattern="/^[A-Z0-9]*$/" minlength="7" maxlength="7">
                                <span class="text-danger" ng-show="solicitudAsesoriaContrato.CARNET.$error.minlength">Minimo 7 caracteres.</span>
                                <span class="text-danger" ng-show="solicitudAsesoriaContrato.CARNET.$error.pattern">Solo se permiten letras mayusculas y numeros. (A-Z, 0-9).</span>
                                <small id="help5"></small>
                            </div>
                            <div class="col-md-1 text-right">
                                <label for="textinput">Numero de Expediente : </label>                                
                            </div>
                            <div class="col-md-2">
                                <input id="ID_EXPEDIENTE" name="ID_EXPEDIENTE" type="text" placeholder="ingrese numero de expediente a buscar" class="form-control input-md" ng-model="datos.idexpediente" ng-pattern="/^[0-9]*$/" minlength="1" maxlength="4">
                                <span class="text-danger" ng-show="solicitudAsesoriaContrato.ID_EXPEDIENTE.$error.minlength">Minimo 1 caracteres.</span>
                                <span class="text-danger" ng-show="solicitudAsesoriaContrato.ID_EXPEDIENTE.$error.pattern">Solo se permiten numeros. (0-9).</span>
                                <small id="help5"></small>
                            </div>


                            <div class="col-md-1 text-right">
                                <label for="textinput">Fecha inicial : </label>
                            </div>
                            <div class="col-md-2">
                                <div class="input-group date">
                                    <input type="text" class="form-control" name="FECHA1" placeholder="MM/DD/AAAA"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                </div>
                            </div>  

                            <div class="col-md-1 text-right">
                                <label for="textinput">Fecha final : </label>
                            </div>
                            <div class="col-md-2">
                                <div class="input-group date">
                                    <input type="text" class="form-control" name="FECHA2" placeholder="MM/DD/AAAA"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                </div>
                            </div> 


                        </div>

                        <BR>

                        <div class="row">
                            <div class="col-md-1 text-right">
                                <label for="textinput">Nombres : </label>
                            </div>
                            <div class="col-md-7">

                                <div class="row">

                                    <div class="col-md-3">                                                                                    
                                        <input id="NOMBRE1" name="NOMBRE1" type="text" placeholder="primer nombre" class="form-control input-md" ng-model="datos.nombre1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                        <span class="text-danger" ng-show="solicitudAsesoriaContrato.NOMBRE1.$error.minlength">Minimo 3 caracteres.</span>
                                        <span class="text-danger" ng-show="solicitudAsesoriaContrato.NOMBRE1.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                                    </div>
                                    <div class="col-md-3">    
                                        <input id="NOMBRE2" name="NOMBRE2" type="text" placeholder="segundo nombre" class="form-control input-md" ng-model="datos.nombre2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                        <span class="text-danger" ng-show="solicitudAsesoriaContrato.NOMBRE2.$error.minlength">Minimo 3 caracteres.</span>
                                        <span class="text-danger" ng-show="solicitudAsesoriaContrato.NOMBRE2.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                                    </div> 
                                    <div class="col-md-3">
                                        <input id="APELLIDO1" name="APELLIDO1" type="text" placeholder="primer apellido" class="form-control input-md" ng-model="datos.apellido1" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">                                            
                                        <span class="text-danger" ng-show="solicitudAsesoriaContrato.APELLIDO1.$error.minlength">Minimo 3 caracteres.</span>
                                        <span class="text-danger" ng-show="solicitudAsesoriaContrato.APELLIDO1.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                                    </div> 
                                    <div class="col-md-3">
                                        <input id="APELLIDO2" name="APELLIDO2" type="text" placeholder="segundo apellido" class="form-control input-md" ng-model="datos.apellido2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">
                                        <span class="text-danger" ng-show="solicitudAsesoriaContrato.APELLIDO2.$error.minlength">Minimo 3 caracteres.</span>
                                        <span class="text-danger" ng-show="solicitudAsesoriaContrato.APELLIDO2.$error.pattern">Solo se permiten letras mayusculas. (A-Z).</span>
                                    </div>

                                </div>

                            </div>


                            <div class="col-md-1 text-right">
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
                        <div class="col-md-12 text-center">
                            <input type="submit" class="btn btn-primary" name="submit" value="Realizar busqueda">
                        </div>
                    </div>

                </form>

            </fieldset>              


        </div>


        <!---------------    TABLA DE RESULTADOS ----------------------->

        <%
            String CARNET;
            String ID_EXPEDIENTE;
            String ID_FACULTAD;
            String NOMBRE1;
            String NOMBRE2;
            String APELLIDO1;
            String APELLIDO2;
            String FECHA1;
            String FECHA2;
            ConexionBD conexionbd = null;
            ResultSet rs = null;

            try {
                CARNET = request.getParameter("CARNET");
                ID_EXPEDIENTE = request.getParameter("ID_EXPEDIENTE");
                ID_FACULTAD = request.getParameter("ID_FACULTAD");
                NOMBRE1 = request.getParameter("NOMBRE1");
                NOMBRE2 = request.getParameter("NOMBRE2");
                APELLIDO1 = request.getParameter("APELLIDO1");
                APELLIDO2 = request.getParameter("APELLIDO2");
                FECHA1 = request.getParameter("FECHA1");
                FECHA2 = request.getParameter("FECHA2");

                String consultaSql = "SELECT DU.CARNET, CONCAT(DU.NOMBRE1_DU, ' ', DU.NOMBRE2_DU, ' ', DU.APELLIDO1_DU, ' ', DU.APELLIDO2_DU) AS NOMBRES, F.FACULTAD, E.ID_EXPEDIENTE, SB.FECHA_SOLICITUD FROM EXPEDIENTE E NATURAL JOIN SOLICITUD_DE_BECA SB NATURAL JOIN USUARIO U NATURAL JOIN DETALLE_USUARIO DU NATURAL JOIN FACULTAD F WHERE DU.NOMBRE1_DU LIKE '%"+NOMBRE1+"%' AND DU.NOMBRE2_DU LIKE '%"+NOMBRE2+"%' AND DU.APELLIDO1_DU LIKE '%"+APELLIDO1+"%' AND DU.APELLIDO2_DU LIKE '%"+APELLIDO2+"%' AND U.NOMBRE_USUARIO LIKE '%"+CARNET+"%' AND E.ID_EXPEDIENTE LIKE '%"+ID_EXPEDIENTE+"%' AND ID_FACULTAD LIKE "+ID_FACULTAD+" AND SB.FECHA_SOLICITUD BETWEEN '2015-01-01' AND '2016-01-01' AND E.ID_PROGRESO = 8";
                out.write(consultaSql);
                
            } catch (Exception ex) {
                System.out.println();
            }

        %>


        <div class="row">
            <h5>Resultados</h5>
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <table class="table text-center">
                    <thead>
                        <tr>
                            <th>No.</th>
                            <th>Usuario</th>
                            <th>Nombre</th>
                            <th>Unidad</th>
                            <th>Expediente</th>
                            <th>Fecha Solicitud</th>
                            <th>Acción</th>
                        </tr>  
                    </thead>
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><input type="button" name="resolver" value="Resolver" class="btn btn-success"></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-md-1"></div>
        </div>
    </fieldset>
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
<script src="js/angular.min.js"></script>
<script src="js/scripts.js"></script>
<script src="js/solicitudAsesoriaContrato.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
                                            $(function () {
                                                $('.input-group.date').datepicker({
                                                    calendarWeeks: true,
                                                    todayHighlight: true,
                                                    autoclose: true
                                                });
                                            });
</script>

</body>
</html>
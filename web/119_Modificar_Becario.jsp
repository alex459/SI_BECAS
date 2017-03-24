<%-- 
    Document   : 119_Modificar_Becario
    Created on : 20/03/2017, 09:24:56 AM
    Author     : adminPC
--%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page import="POJO.Expediente"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="DAO.BecaDAO"%>
<%@page import="POJO.Beca"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="POJO.Institucion"%>
<%@page import="POJO.OfertaBeca"%>
<%@page import="DAO.OfertaBecaDAO"%>
<!-- inicio proceso de seguridad de login -->
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
    request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String id_usuario_login = (String) actual.getAttribute("id_user_login");
    String rol = (String) actual.getAttribute("rol");
    String user = (String) actual.getAttribute("user");
    Integer tipo_usuario_logeado = (Integer) actual.getAttribute("id_tipo_usuario");
    ArrayList<String> tipo_usuarios_permitidos = new ArrayList<String>();
    //AGREGAR SOLO LOS ID DE LOS USUARIOS AUTORIZADOS PARA ESTA PANTALLA------
    tipo_usuarios_permitidos.add("7");
    tipo_usuarios_permitidos.add("8");
    tipo_usuarios_permitidos.add("9");
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!-- fin de proceso de seguridad de login -->

<!--Recuperacion de datos -->
<%
    String nombre1 = "";
    String nombre2 = "";
    String apellido1 = "";
    String apellido2 = "";
    String nombreCompleto = "";
    String estado = "";
    ArrayList<OfertaBeca> ofertas = new ArrayList();
    int id_Expediente = 0;
    Institucion institucionEstudio = new Institucion();
    Institucion institucionOferente = new Institucion();
    String pais = "";
    OfertaBecaDAO ofertaDao = new OfertaBecaDAO();
    OfertaBeca oferta = new OfertaBeca();
    InstitucionDAO institucionDao = new InstitucionDAO();
    Beca beca = new Beca();
    BecaDAO becaDao = new BecaDAO();
    String consultaSql = "SELECT DU.NOMBRE1_DU, DU.NOMBRE2_DU, DU.APELLIDO1_DU, DU.APELLIDO2_DU, DU.CARNET, F.FACULTAD, TU.TIPO_USUARIO, U.ID_USUARIO, DU.ID_DETALLE_USUARIO  FROM DETALLE_USUARIO DU NATURAL JOIN USUARIO U NATURAL JOIN FACULTAD F NATURAL JOIN TIPO_USUARIO TU WHERE TU.TIPO_USUARIO IN ('CANDIDATO')";
    ConexionBD conexionbd = new ConexionBD();
    ResultSet rs = null;
    try {
        nombre1 = request.getParameter("nombre1");
        nombre2 = request.getParameter("nombre2");
        apellido1 = request.getParameter("apellido1");
        apellido2 = request.getParameter("apellido2");
        id_Expediente = Integer.parseInt(request.getParameter("id_Expediente"));
        if (nombre1.equals(null) || apellido1.equals(null)) {
            response.sendRedirect("Agregar_Becario_Consulta.jsp");
        }
        if (nombre2.equals(null)) {
            nombre2 = "";
        }
        if (apellido2.equals(null)) {
            apellido2 = "";
        }
        nombreCompleto = nombre1 + " " + nombre2 + " " + apellido1 + " " + apellido2;
        oferta = ofertaDao.consultarPorId(id_Expediente);
        institucionEstudio = institucionDao.consultarPorId(oferta.getIdInstitucionEstudio());
        institucionOferente = institucionDao.consultarPorId(oferta.getIdInstitucionFinanciera());
        beca = becaDao.consultarPorExpediente(id_Expediente);
        rs = conexionbd.consultaSql(consultaSql);
        ofertas = ofertaDao.consultarTodos();
        Expediente expediente = new Expediente();
        ExpedienteDAO expedienteDao = new ExpedienteDAO();
        expediente = expedienteDao.consultarPorId(id_Expediente);
        switch(expediente.getIdProgreso()){
            case 9:
                estado ="estudio";
                break;
            case 12:
                estado ="servicio";
                break;
            case 13:
                estado ="compromiso";
                break;
            case 14:
                estado ="liberacion";
                break;
            case 16:
                //Ver si es finalizada o reintegro
                break;
            case 23:
                estado ="reintegro";
                break;
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("118_Modificar_Becario_Consulta.jsp");
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
        <link href="css/menuSolicitudBeca.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker3.min.css" />
        <link href="css/customfieldset.css" rel="stylesheet">

        <jsp:include page="cabecera.jsp"></jsp:include>



        <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>

    </head>
    <body ng-app="ModificarBecaApp" ng-controller="ModificarBecaCtrl">
        <!--TITULO DE PANTALLA-->
        <h3 class="text-center" style="color:#cf2a27">
            Modificar Becario
        </h3>
        <!--FIN TITULO DE PANTALLA-->
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <fieldset class="custom-border">
                    <legend class="custom-border">Modificar Becario</legend>
                    <div class="row">
                        <!--Tabla-->
                        <div class="col-md-12">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td>Becario: </td>
                                        <td><%=nombreCompleto%></td>
                                    <td>Expediente: </td>
                                    <td><%=id_Expediente%></td>
                                </tr>

                                <tr>
                                    <td>Título de Beca: </td>
                                    <td><%=oferta.getNombreOferta()%></td>
                                    <td>País: </td>
                                    <td><%=institucionEstudio.getPais()%></td>
                                </tr>

                                <tr>
                                    <td>Institución de Estudio:</td>
                                    <td><%=institucionEstudio.getNombreInstitucion()%></td>
                                    <td>Institución Oferente: </td>
                                    <td><%=institucionOferente.getNombreInstitucion()%></td>
                                </tr>

                                <tr>
                                    <td>Fecha de Inicio:</td>
                                    <td><%=beca.getFechaInicio()%></td>
                                    <td>Fecha de Fin:</td>
                                    <td><%=beca.getFechaFin()%></td>
                                </tr>

                            </tbody>    
                        </table>
                    </div>
                    <!--Fin Tabla-->
                </div>

                <div class="row">
                    <!--Opciones-->
                    <div class="row">
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Seleccione Opción a Modificar</legend>
                                <div class="col-md-1"></div>
                                <div class="col-md-5">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-7">
                                        <label class="form-control-static">Becario</label>
                                    </div>
                                    <div class="col-md-1">
                                        <input type="radio" name="opcion" class="form-control" value="becario" ng-click="seleccionarBecario()" ng-model="accion">
                                    </div>
                                    <div class="col-md-1"></div>
                                </div>
                                <div class="col-md-5">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-7">
                                        <label class="form-control-static">Expediente</label>
                                    </div>
                                    <div class="col-md-1">
                                        <input type="radio" name="opcion" class="form-control" value="expediente" ng-click="seleccionarExpediente()" ng-model="accion">
                                    </div>
                                    <div class="col-md-1"></div>
                                </div>
                                <div class="col-md-1"></div>
                            </fieldset>
                        </div>
                        <div class="col-md-3"></div>                        
                    </div>
                    <!--Fin Opciones-->                   

                    <!--Editar Becario-->
                    <div class="row" ng-show="mostrarBecario">                        
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Seleccione el Candidato a Asignar la beca</legend>
                                <table id="tablaUsuarios" class="table table-bordered text-center">                      
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Nombre de Empleado</th>
                                            <th>Código de Usuario</th>
                                            <th>Facultad</th>
                                            <th>Tipo de Empleado</th>
                                            <th>Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>                            
                                        <%
                                            String usuarios_consultados = new String();
                                            try {

                                                Integer i = 0;
                                                while (rs.next()) {
                                                    i = i + 1;
                                                    out.write("<tr>");
                                                    out.write("<td>" + i + "</td>");
                                                    out.write("<td>" + rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4) + "</td>");
                                                    usuarios_consultados = usuarios_consultados.concat(rs.getString(5).toString() + ", ");
                                                    out.write("<td>" + rs.getString(5) + "</td>");
                                                    out.write("<td>" + rs.getString(6) + "</td>");
                                                    out.write("<td>" + rs.getString(7) + "</td>");
                                                    out.write("<td>");
                                                    out.write("<center>");
                                                    out.write("<form style='display:inline;' action='ModificarBecarioServlet' method='post'><input type='hidden' name='idExpediente' value='" + id_Expediente + "'><input type='hidden' name='ID_USUARIO' value='" + rs.getString(8) + "'><input type='hidden' name='accion' value='becario'><input type='submit' class='btn btn-success' name='submit' value='Cambiar Becario'></form> ");
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
                            </fieldset>
                        </div>
                        <div class="col-md-1"></div>                        
                    </div>
                    <!--Fin Editar Becario-->

                    <!--Editar Expediente-->
                    <div class="row" ng-show="mostrarExpediente">
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <fieldset class="custom-border">
                                <legend class="custom-border">Modificar Expediente</legend>
                                <form action="ModificarBecarioServlet" method="post" name="agregarBecario" enctype="multipart/form-data" novalidate>
                                    <div class="row" ng-init="fechaInicio = '<%=beca.getFechaInicio()%>'; fechaFin = '<%=beca.getFechaFin()%>'; oferta = '<%=oferta.getIdOfertaBeca()%>'; estado = '<%=estado%>';">

                                        <div class="row">                    
                                            <div class="col-md-12">
                                                <div class="col-md-2"></div>
                                                <div class="col-md-3">
                                                    <label>Seleccione la oferta de beca: </label><br>
                                                </div>
                                                <div class="col-md-5">

                                                    <select name="oferta" class="form-control" ng-model="oferta" ng-disabled="checkOferta" ng-required="!checkOferta">
                                                        <%                                                            for (int i = 0; i < ofertas.size(); i++) {
                                                                out.write("<option value=" + ofertas.get(i).getIdOfertaBeca() + ">" + ofertas.get(i).getNombreOferta() + "</option>");
                                                            }
                                                        %>    
                                                    </select> 
                                                    <span class="text-danger" ng-show="agregarBecario.oferta.$error.required">Seleccione una Oferta.</span>
                                                    <br>
                                                </div>
                                                <div class="col-md-2"></div>
                                            </div>                                            
                                        </div>  
                                        <div class="row">                    
                                            <div class="col-md-6">
                                                <div class="col-md-4">
                                                    <label>Fecha de Inicio de Beca: </label><br>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="input-group date">
                                                        <input type="text" name="fechaInicio" id="fechaInicio" class="form-control" ng-model="fechaInicio" ng-required="true"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="fechaInicio"></i></span>
                                                    </div> 
                                                    <span class="text-danger" ng-show="agregarBecario.fechaInicio.$error.required">Seleccione la Fecha de Inicio de Beca.</span><br>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="col-md-4">
                                                    <label>Fecha de Fin Beca: </label><br>
                                                </div>
                                                <div class="col-md-8">
                                                    <div class="input-group date">
                                                        <input type="text" name="fechaFin" id="fechaFin" class="form-control" ng-model="fechaFin" ng-required="true"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="fechaFin"></i></span>
                                                    </div>    
                                                    <span class="text-danger" ng-show="agregarBecario.fechaFin.$error.required">Seleccione la Fecha de Fin de Beca.</span><br>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-2"></div>
                                            <div class="col-md-8">
                                                <fieldset class="custom-border">
                                                    <legend class="custom-border">Estado de la Beca</legend>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Realización de Estudio</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="estudio" ng-click="activarEstudio()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Servicio Contractual</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="servicio" ng-click="activarContractual()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Gestión de Compromiso Contractual</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="compromiso" ng-click="activarCompromiso()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Gestión de Liberación</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="liberacion" ng-click="activarLiberacion()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Beca Finalizada</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="becaFinalizada" ng-click="activarBecaFinalizada()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Reintegro de Beca</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="reintegro" ng-click="activarEstudio()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-3"></div>
                                                        <div class="col-md-5">
                                                            <label class="form-control-static">Finalizada por Reintegro de Beca</label>
                                                        </div>
                                                        <div class="col-md-1">
                                                            <input type="radio" name="estado" class="form-control" value="finReintegro" ng-click="activarFinReintegro()" ng-required ="true" ng-model="estado">
                                                        </div>
                                                    </div>
                                                    <div class="row text-center">
                                                        <span class="text-danger" ng-show="agregarBecario.estado.$error.required">Seleccione el estado de la beca.</span><br>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div class="col-md-2"></div>
                                        </div> 
                                    </div>
                                                    
                                </form>
                            </fieldset>
                        </div>
                        <div class="col-md-1"></div>
                    </div>         
                    <!--Fin Editar Expediente-->

                </div>
            </fieldset>

        </div>
        <div class="col-md-1"></div>
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
    <script src="js/modificarBecario.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript">
                                                                    $(document).ready(function () {
                                                                        $('#tablaUsuarios').DataTable(
                                                                                {
                                                                                    "language":
                                                                                            {
                                                                                                "sProcessing": "Procesando...",
                                                                                                "sLengthMenu": "Mostrar _MENU_ registros",
                                                                                                "sZeroRecords": "No se encontraron resultados",
                                                                                                "sEmptyTable": "Ningún dato disponible en esta tabla",
                                                                                                "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                                                                                                "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                                                                                                "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                                                                                                "sInfoPostFix": "",
                                                                                                "sSearch": "Buscar:",
                                                                                                "sUrl": "",
                                                                                                "sInfoThousands": ",",
                                                                                                "sLoadingRecords": "Cargando...",
                                                                                                "oPaginate": {
                                                                                                    "sFirst": "Primero",
                                                                                                    "sLast": "Último",
                                                                                                    "sNext": "Siguiente",
                                                                                                    "sPrevious": "Anterior"
                                                                                                },
                                                                                                "oAria": {
                                                                                                    "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                                                                                                    "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                                                                                                }
                                                                                            }
                                                                                }
                                                                        );
                                                                    });

    </script>
</body>
</html>

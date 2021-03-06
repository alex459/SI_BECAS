<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
--%>


<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="java.util.Date"%>
<%@page import="POJO.Accion"%>
<%@page import="DAO.AccionDAO"%>

<!-- inicio proceso de seguridad de login -->
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
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


<%
    //variables para la tabla de resultados
    String nombre1 = new String();
    String nombre2 = new String();
    String apellido1 = new String();
    String apellido2 = new String();
    String nombre_usuario = new String();
    String accion = new String(); //tipo_operacion                
    String tabla_afectada = new String();; //descripcion

    String fecha1 = new String();
    String fecha2 = new String();
    String id_accion = new String();
    ConexionBD conexionBD = new ConexionBD();
    ResultSet rs = null;

    //otras variables para el reporte
    AccionDAO accionDao = new AccionDAO();
    Date date = new Date();
    String modifiedDate = new SimpleDateFormat("MM/dd/yyyy").format(date);
    String id_accion_menor = new String(); //tipo_operacion            
    String id_accion_mayor = new String(); //tipo_operacion            

    try { //intentando leer datos enviados desde la misma pagina.
        id_accion = request.getParameter("ID_ACCION");
        nombre1 = request.getParameter("NOMBRE1");
        nombre2 = request.getParameter("NOMBRE2");
        apellido1 = request.getParameter("APELLIDO1");
        apellido2 = request.getParameter("APELLIDO2");

        //formando la consulta
        String consultaSql = "select CONCAT(DU.NOMBRE1_DU, ' ', DU.NOMBRE2_DU, ' ', DU.APELLIDO1_DU, ' ', DU.APELLIDO2_DU) AS NOMBRES, U.NOMBRE_USUARIO, A.ACCION, B.DESCRIPCION, B.FECHA_BITACORA, B.ID_BITACORA from DETALLE_USUARIO DU NATURAL JOIN USUARIO U NATURAL JOIN BITACORA B NATURAL JOIN ACCION A WHERE DU.NOMBRE1_DU LIKE '%" + nombre1 + "%' AND DU.NOMBRE2_DU LIKE '%" + nombre2 + "%' AND DU.APELLIDO1_DU LIKE '%" + apellido1 + "%' AND DU.APELLIDO2_DU LIKE '%" + apellido2 + "%'";
        if (!request.getParameter("FECHA1").equals("") && !request.getParameter("FECHA2").equals("")) {
            fecha1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("FECHA1"))) + " 00:00:00";
            fecha2 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("FECHA2"))) + " 23:59:59";
            consultaSql = consultaSql.concat(" AND B.FECHA_BITACORA BETWEEN '" + fecha1 + "' AND '" + fecha2 + "'");
        } else {
            fecha1 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("MM/dd/yyyy").parse("01/01/2016")) + " 00:00:00";
            fecha2 = new SimpleDateFormat("yyyy-MM-dd").format(new SimpleDateFormat("MM/dd/yyyy").parse(modifiedDate)) + " 23:59:59";
            consultaSql = consultaSql.concat(" AND B.FECHA_BITACORA BETWEEN '" + fecha1 + "' AND '" + fecha2 + "'");
        }
        if (!id_accion.equals("0")) {
            id_accion_menor = id_accion;
            id_accion_mayor = id_accion;
            consultaSql = consultaSql.concat(" AND A.ID_ACCION BETWEEN " + id_accion_menor + " AND " + id_accion_mayor);
        } else {
            id_accion_menor = "0";
            id_accion_mayor = accionDao.getSiguienteId().toString();
            consultaSql = consultaSql.concat(" AND A.ID_ACCION BETWEEN " + id_accion_menor + " AND " + id_accion_mayor);

        }
        
        consultaSql = consultaSql.concat(" ORDER BY B.ID_BITACORA ASC");
        //out.write(consultaSql);
        //realizando la consulta
        rs = conexionBD.consultaSql(consultaSql);

    } catch (Exception ex) {
        System.out.print("Error: " + ex);
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
    <link href="css/customfieldset.css" rel="stylesheet">

<jsp:include page="cabecera.jsp"></jsp:include>



<p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
<p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


<%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
<jsp:include page="menu_corto.jsp"></jsp:include>

</head>
<body>

    <div class="container-fluid">

        <div class="row"><!-- TITULO DE LA PANTALLA -->

            <h3>
                <p class="text-center" style="color:#cf2a27">Bitácora</p>
            </h3>

            <br></br> 
        </div><!-- TITULO DE LA PANTALLA -->  


        <div class="col-md-12">            
            <fieldset class="custom-border">  
                <legend class="custom-border">Bitácora</legend> 


                <div class="row">   

                    <!-- FORMULARIO 1 PARA REALIZAR LA BUSQUEDA -->                    
                    <form class="form-horizontal" action="106_bitacora.jsp" method="post">
                        <div class="col-md-8"> <!-- FILTROS -->
                            <fieldset class="custom-border">
                                <legend class="custom-border">Filtros</legend>

                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="textinput" style="color:#cf2a27">Ingrese los filtros de busqueda</label>
                                    </div>
                                    <div class="col-md-6 text-center">
                                        <label for="textinput">Rango Para las fechas de Busqueda</label>
                                    </div>
                                </div>

                                <br>

                                <div class="row">
                                    <div class="col-md-3">
                                        <label for="textinput">Tipo de Operación</label>
                                    </div>
                                    <div class="col-md-3">
                                        <select id="selectbasic" name="ID_ACCION" class="form-control"> 
                                            <option value="0">TODOS</option>
                                        <%
                                            ArrayList<Accion> listaAccion = new ArrayList<Accion>();
                                            listaAccion = accionDao.consultarTodos();
                                            for (int i = 0; i < listaAccion.size(); i++) {
                                                out.write("<option value=" + listaAccion.get(i).getIdAccion() + ">" + listaAccion.get(i).getAccion() + "</option>");
                                            }
                                        %>                                                                 
                                    </select>
                                </div>
                                <div class="col-md-1">
                                    <label for="textinput">Inicio: </label>
                                </div>
                                <div class="col-md-2">
                                    <div class="input-group date">
                                        <input type="text" class="form-control" name="FECHA1" placeholder="MM/DD/AAAA"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                    </div>
                                </div> 
                                <div class="col-md-1">
                                    <label for="textinput">Fin: </label>
                                </div>
                                <div class="col-md-2">
                                    <div class="input-group date">
                                        <input type="text" class="form-control" name="FECHA2" placeholder="MM/DD/AAAA"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>                                    </div>
                                </div>
                            </div>

                            <br>

                            <div class="row">
                                <div class="col-md-3">
                                    <label for="textinput">Nombre de Usuario</label>
                                </div>
                                <div class="col-md-9">
                                    <div class="row">
                                        <div class="col-md-3">                                            
                                            <input id="NOMBRE1" name="NOMBRE1" type="text" onFocus="mostrarMensaje('help1', 'Ingrese solo letras. Maximo 15')" onBlur="ocultarMensaje('help1')" onkeypress="return validarTexto('NOMBRE1', event, 15)" placeholder="primer nombre" class="form-control input-md">                                                                                            
                                            <small id="help1"></small>
                                        </div>
                                        <div class="col-md-3">                                            
                                            <input id="NOMBRE2" name="NOMBRE2" type="text" onFocus="mostrarMensaje('help2', 'Ingrese solo letras. Maximo 15')" onBlur="ocultarMensaje('help2')" onkeypress="return validarTexto('NOMBRE2', event, 15)" placeholder="segundo nombre" class="form-control input-md">                                                                                            
                                            <small id="help2"></small>
                                        </div>
                                        <div class="col-md-3">                                            
                                            <input id="APELLIDO1" name="APELLIDO1" type="text" onFocus="mostrarMensaje('help3', 'Ingrese solo letras. Maximo 15')" onBlur="ocultarMensaje('help3')" onkeypress="return validarTexto('APELLIDO1', event, 15)" placeholder="primer apellido" class="form-control input-md">                                                                                            
                                            <small id="help3"></small>
                                        </div>
                                        <div class="col-md-3">                                            
                                            <input id="APELLIDO2" name="APELLIDO2" type="text" onFocus="mostrarMensaje('help4', 'Ingrese solo letras. Maximo 15')" onBlur="ocultarMensaje('help4')" onkeypress="return validarTexto('APELLIDO2', event, 15)" placeholder="segundo apellido" class="form-control input-md">                                                                                            
                                            <small id="help4"></small>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <br>

                            <div class="row">
                                <div class="col-md-12 text-center">
                                    <input type="submit" class="btn btn-primary" name="submit" value="Realizar Busqueda">
                                </div>
                            </div>                                
                        </fieldset>
                    </div>
                </form> 


                <!-- FORMULARIO 2 PARA GENERAR EL REPORTE -->                                   

                <div class="col-md-4"> <!-- ACCIONES -->
                    <fieldset class="custom-border">
                        <legend class="custom-border">Acciones</legend>
                        <div class="row">

                            <div class="col-md-6 text-center">
                                <label for="textinput">PDF</label>
                            </div>                                                                        
                            <div class="col-md-6 text-center">
                                <label for="textinput">Hoja de Cálculo</label>
                            </div>
                        </div>

                        <br>

                        <div class="row">
                            <div class="col-md-6 text-center">
                                <form class="form-horizontal" action="ReporteBitacoraServlet" method="post">
                                    <input type="hidden" name="REPORTE_NOMBRE1" value="<%=nombre1%>">
                                    <input type="hidden" name="REPORTE_NOMBRE2" value="<%=nombre2%>">
                                    <input type="hidden" name="REPORTE_APELLIDO1" value="<%=apellido1%>">
                                    <input type="hidden" name="REPORTE_APELLIDO2" value="<%=apellido2%>">
                                    <input type="hidden" name="REPORTE_FECHA1" value="<%=fecha1%>">
                                    <input type="hidden" name="REPORTE_FECHA2" value="<%=fecha2%>">
                                    <input type="hidden" name="REPORTE_ID_ACCION_MENOR" value="<%=id_accion_menor%>">
                                    <input type="hidden" name="REPORTE_ID_ACCION_MAYOR" value="<%=id_accion_mayor%>">
                                    <input type="hidden" name="REPORTE_NOMBRE_USUARIO" value="JOSE ALEXIS BELTRAN SERRANO">
                                    <input type="hidden" name="REPORTE_ROL_USUARIO" value="ADMINISTRADOR">
                                    <input type="hidden" name="OPCION_DE_SALIDA" value="1">
                                    <input type="submit" class="btn btn-primary" name="submit" value=" " style="background-image: url(img/106_icono_de_pdf.png); background-repeat: no-repeat; background-size: 100%; background-size: 25px 25px;">
                                </form>                                    
                            </div>

                            <div class="col-md-6">                            
                            <div style="border:1px solid; background-color: #32B232; padding:6px; color:white; " id="buttons"></div>
                            <br>
                        </div>  
                        </div>

                        <br>                    

                    </fieldset>
                </div>




            </div>

            <!-- TABLA RESULTADOS -->

            <div class="row">
                <div class="col-md-12">
                    <label for="textinput">Resultados de la Busqueda</label>
                </div>                    
            </div>           
            <div class="row">   

                <div class="col-md-12">

                    <table id="tablaResultados" class="table table-bordered"></br>                        
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Nombre de Usuario</th>
                                <th>Código de Usuario</th>
                                <th>Tipo de Operación</th>
                                <th>Operación Realizada</th>
                                <th>Fecha</th>
                                <th>Hora</th>
                            </tr>
                        </thead>
                        <tbody>

                            <%                                try {
                                    Integer i = 0;
                                    if (rs != null) {
                                        while (rs.next()) {
                                            i = i + 1;
                                            out.write("<tr>");
                                            out.write("<td>" + i + "</td>");
                                            out.write("<td>" + rs.getString(1) + "</td>");
                                            out.write("<td>" + rs.getString(2) + "</td>");
                                            out.write("<td>" + rs.getString(3) + "</td>");
                                            out.write("<td>" + rs.getString(4) + "</td>");
                                            DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
                                            String data = df.format(rs.getDate(5));
                                            out.write("<td>" + data + "</td>");
                                            out.write("<td>" + rs.getTimestamp(5).getHours() + ":" + rs.getTimestamp(5).getMinutes() + ":" + rs.getTimestamp(5).getSeconds() + "</td>");
                                            out.write("</tr>");
                                        }

                                    }
                                } catch (Exception ex) {
                                    System.out.println("Error: " + ex);
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


<script src="js/angular.min.js"></script>
<script src="js/angular-route.min.js"></script>
<script src="js/solicitudbeca.js"></script>
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.js"></script>
<script type="text/javascript">
                                                $(function () {
                                                    $('.input-group.date').datepicker({
                                                        calendarWeeks: true,
                                                        todayHighlight: true,
                                                        autoclose: true
                                                    });
                                                });
</script>


<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="js/buttons.html5.min.js"></script>
<script type="text/javascript" src="js/buttons.print.min.js"></script>
<script type="text/javascript" src="js/dataTables.buttons.min.js"></script>



<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">
   $(document).ready(function() {
    var tabla= $('#tablaResultados').DataTable(
            {
                 "language": 
{
	"sProcessing":     "Procesando...",
	"sLengthMenu":     "Mostrar _MENU_ registros",
	"sZeroRecords":    "No se encontraron resultados",
	"sEmptyTable":     "Ningún dato disponible en esta tabla",
	"sInfo":           "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
	"sInfoEmpty":      "Mostrando registros del 0 al 0 de un total de 0 registros",
	"sInfoFiltered":   "(filtrado de un total de _MAX_ registros)",
	"sInfoPostFix":    "",
	"sSearch":         "Buscar:",
	"sUrl":            "",
	"sInfoThousands":  ",",
	"sLoadingRecords": "Cargando...",
	"oPaginate": {
		"sFirst":    "Primero",
		"sLast":     "Último",
		"sNext":     "Siguiente",
		"sPrevious": "Anterior"
	},
	"oAria": {
		"sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
		"sSortDescending": ": Activar para ordenar la columna de manera descendente"
	}
}
             }
                   
                );
         var buttons = new $.fn.dataTable.Buttons(tabla, {
     buttons: [
        'csv', 'excel'
    ]
}).container().appendTo($('#buttons'));
        
} );
    

    $.validator.setDefaults({
        submitHandler: function () {
            alert("submitted!");
        }
    });

    $().ready(function () {
        // validate the comment form when it is submitted
        $("#formulario").validate();

        // validate signup form on keyup and submit
        $("#signupForm").validate({
            rules: {
                primernombre: "required",
                lastname: "required",
                username: {
                    required: true,
                    minlength: 2
                },
                password: {
                    required: true,
                    minlength: 5
                },
                confirm_password: {
                    required: true,
                    minlength: 5,
                    equalTo: "#password"
                },
                email: {
                    required: true,
                    email: true
                },
                topic: {
                    required: "#newsletter:checked",
                    minlength: 2
                },
                agree: "required"
            },
            messages: {
                primernombre: "Please enter your firstname",
                lastname: "Please enter your lastname",
                username: {
                    required: "Please enter a username",
                    minlength: "Your username must consist of at least 2 characters"
                },
                password: {
                    required: "Please provide a password",
                    minlength: "Your password must be at least 5 characters long"
                },
                confirm_password: {
                    required: "Please provide a password",
                    minlength: "Your password must be at least 5 characters long",
                    equalTo: "Please enter the same password as above"
                },
                email: "Please enter a valid email address",
                agree: "Please accept our policy",
                topic: "Please select at least 2 topics"
            }
        });

        // propose username by combining first- and lastname
        $("#username").focus(function () {
            var firstname = $("#firstname").val();
            var lastname = $("#lastname").val();
            if (firstname && lastname && !this.value) {
                this.value = firstname + "." + lastname;
            }
        });

        //code to hide topic selection, disable for demo
        var newsletter = $("#newsletter");
        // newsletter topics are optional, hide at first
        var inital = newsletter.is(":checked");
        var topics = $("#newsletter_topics")[inital ? "removeClass" : "addClass"]("gray");
        var topicInputs = topics.find("input").attr("disabled", !inital);
        // show when newsletter is checked
        newsletter.click(function () {
            topics[this.checked ? "removeClass" : "addClass"]("gray");
            topicInputs.attr("disabled", !this.checked);
        });
    });
</script>
</body>
<script src="js/validaciones.js"></script> <!-- para hacer funcionar las validaciones javascript -->
</html>

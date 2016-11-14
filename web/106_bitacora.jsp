<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
--%>

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
                <p class="text-center" style="color:#cf2a27">Bitacora</p>
            </h2>

            <br></br> 
        </div><!-- TITULO DE LA PANTALLA -->  


        <div class="col-md-12">            
            <fieldset class="custom-border">  
                <legend class="custom-border">Bitacora</legend> 


                <div class="row">   

                    <form class="form-horizontal" action="" method="post">

                        <div class="col-md-8"> <!-- FILTROS -->
                            <fieldset class="custom-border">
                                <legend class="custom-border">Filtros</legend>
                                
                                <div class="row">
                                    <div class="col-md-12">
                                        <label for="textinput" style="color:#cf2a27">Ingrese los filtros de busqueda</label>
                                    </div>
                                </div>
                                
                                <br>
                                
                                <div class="row">
                                    <div class="col-md-3">
                                        <label for="textinput">Tipo de operacion</label>
                                    </div>
                                    <div class="col-md-3">
                                        <select id="selectbasic" name="ID_FACULTAD" class="form-control">                                        
                                            <option value="">Ingresar</option>                                                               
                                        </select>
                                    </div>
                                    <div class="col-md-6 text-center">
                                        <label for="textinput">Rango para las fechas de busqueda</label>
                                    </div>
                                </div>
                                
                                <br>
                                
                                <div class="row">
                                    <div class="col-md-3">
                                        <label for="textinput">Nombre de usuario</label>
                                    </div>
                                    <div class="col-md-3">
                                        <input id="textinput" name="NOMBRE_USUARIO" type="text" placeholder="ingrese el nombre del usuario" class="form-control input-md">
                                    </div>
                                    <div class="col-md-1">
                                        <label for="textinput">Inicio: </label>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="input-group date">
                                            <input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </div> 
                                    <div class="col-md-1">
                                        <label for="textinput">Fin: </label>
                                    </div>
                                    <div class="col-md-2">
                                        <div class="input-group date">
                                            <input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                                        </div>
                                    </div>     
                                </div>
                                
                                <br>
                                
                                <div class="row">
                                    <div class="col-md-12 text-center">
                                        <input type="submit" class="btn btn-primary" name="submit" value="Realizar busqueda">
                                    </div>
                                </div>                                
                            </fieldset>
                        </div>
                        <div class="col-md-4"> <!-- ACCIONES -->
                            <fieldset class="custom-border">
                                <legend class="custom-border">Acciones</legend>
                                <div class="row">
                                    
                                    <div class="col-md-6 text-center">
                                        <label for="textinput">PDF</label>
                                    </div>                                                                        
                                    <div class="col-md-6 text-center">
                                        <label for="textinput">Hoja de calculo</label>
                                    </div>
                                </div>
                                
                                <br>
                                
                                <div class="row">
                                    <div class="col-md-6 text-center">
                                        <img src="img/106_icono_de_pdf.png" alt="Obtener en PDF" width="30" height="30">
                                    </div>
                                    <div class="col-md-6 text-center">
                                        <img src="img/106_icono_de_excel.png" alt="Obtener en Excel" width="30" height="30">
                                    </div>
                                </div>
                                
                                <br>
                                
                                <div class="row">
                                    <div class="col-md-6 text-center">
                                        <label for="textinput">Enviar por correo</label>
                                    </div>
                                    <div class="col-md-6 text-center">
                                        <label for="textinput">Imprimir</label>
                                    </div>
                                </div>
                                
                                <br>
                                
                                <div class="row">
                                    <div class="col-md-6 text-center">
                                        <img src="img/106_icono_de_correo.png" alt="Enviar por correo" width="30" height="30">
                                    </div>
                                    <div class="col-md-6 text-center">
                                        <img src="img/106_icono_de_imprimir.png" alt="Imprimir" width="30" height="30">
                                    </div>
                                </div>
                                
                                <br>
                                
                            </fieldset>
                        </div>

                    </form>    


                </div>


                <div class="row">
                    <div class="col-md-12">
                        <label for="textinput">Resultados de la busqueda</label>
                    </div>                    
                </div>
                
                
                

                <div class="row">   <!-- TABLA RESULTADOS -->

                    <div class="col-md-12">

                        <table class="table table-bordered"></br>                        
                            <thead>
                                <tr class="success">
                                    <th>No</th>
                                    <th>Nombre de empleado</th>
                                    <th>Codigo de empleado</th>
                                    <th>Facultad</th>
                                    <th>Tipo de empleado</th>
                                    <th>Accion</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="info">
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td>
                                        <input type="submit" class="btn btn-success" name="submit" value="Editar">
                                        <input type="submit" class="btn btn-primary" name="submit" value="Modificar Rol">
                                        <input type="submit" class="btn btn-danger" name="submit" value="Dar de Baja">                                
                                    </td>
                                </tr>
                                <tr class="info">
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td>
                                        <input type="submit" class="btn btn-success" name="submit" value="Editar">
                                        <input type="submit" class="btn btn-primary" name="submit" value="Modificar Rol">
                                        <input type="submit" class="btn btn-danger" name="submit" value="Dar de Baja">                                
                                    </td>
                                </tr>
                                <tr class="info">
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td> </td>
                                    <td>
                                        <input type="submit" class="btn btn-success" name="submit" value="Editar">
                                        <input type="submit" class="btn btn-primary" name="submit" value="Modificar Rol">
                                        <input type="submit" class="btn btn-danger" name="submit" value="Dar de Baja">                                
                                    </td>
                                </tr>
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
<script>
	$.validator.setDefaults({
		submitHandler: function() {
			alert("submitted!");
		}
	});

	$().ready(function() {
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
		$("#username").focus(function() {
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
		newsletter.click(function() {
			topics[this.checked ? "removeClass" : "addClass"]("gray");
			topicInputs.attr("disabled", !this.checked);
		});
	});
	</script>
</body>
</html>

<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="MODEL.variablesDeSesion"%>
<% 
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
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
    <link href="css/menuSolicitudBeca.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker3.min.css" />
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
<jsp:include page="menuCandidato.jsp"></jsp:include>
</head>


<body>
    <div>
    <form id="formulario" method="get" action=""> 
    <div class="col-md-2">
                <ul id="sidebar" class="nav nav-pills nav-stacked" style="max-width: 200px;">
                    <li class="active"><a href="#/">Datos personales</a></li>
                    <li><a href="#/laboral">Información laboral</a></li>
                    <li><a href="#/educacion">Educación</a></li>
                    <li><a href="#/cargos">Cargos desempeñados</a></li>
                    <li><a href="#/oferta">Información de beca</a></li>
                    <li><a href="#/referencias">Referencias personales</a></li>
                    <li><a href="#/documentos">Adjuntar documentos</a></li>
                </ul>
            </div>  
            <div class="col-md-10">
                    <fieldset class="custom-border">
                <legend class="custom-border">Datos personales</legend>
                            <div class="row">                                   
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <label for="textinput">Primer nombre</label>
                                    <input id="nombre1" name="nombre1" placeholder="ingrese su primer nombre" class="form-control input-md" ng-model = "data.nombre" required>
                                </div>
                                <div class="col-md-3">
                                    <label for="textinput">Segundo nombre</label>
                                    <input id="textinput" name="nombre2"  placeholder="ingrese su segundo nombre" class="form-control input-md" ng-model = "data.nombre2">
                                </div>
                                <div class="col-md-3">
                                    <label for="textinput">Primer apellido</label>
                                    <input id="textinput" name="textinput" type="text" placeholder="ingrese su primer apellido" class="form-control input-md" ng-model ="data.apellido1">
                                </div>
                                <div class="col-md-3">
                                    <label for="textinput">Segundo apellido</label>
                                    <input id="textinput" name="textinput" type="text" placeholder="ingrese su segundo apellido" class="form-control input-md" ng-model ="data.apellido2">
                                </div>  
                            </div></br>
                            <div class="row">
                                <div class="col-md-4">
                                    <label for="textinput">Fecha de nacimiento</label>
                                    <div class="input-group date">
                                        <input type="text" class="form-control"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="data.fecha_nacimiento"></i></span>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="textinput">Lugar de nacimiento, Departamento</label>
                                    <select id="selectbasic" name="selectbasic" class="form-control" ng-model ="data.departamento_nacimiento">
                                        <option value="1">Option one</option>
                                        <option value="2">Option two</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="textinput">Municipio</label>
                                    <select id="selectbasic" name="selectbasic" class="form-control" ng-model ="data.municipio_nacimiento">
                                        <option value="1">Option one</option>
                                        <option value="2">Option two</option>
                                    </select>
                                </div>  
                            </div></br>
                            <div class="row">
                                <div class="col-md-12">        
                                    <div class="col-md-2">
                                        <label class="control-label" for="radios">Género</label>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="radio-inline" for="radios-0">
                                            <input type="radio" name="radios" id="radios-0" value="1" checked="checked" ng-model ="data.genero">
                                            Masculino
                                        </label> 
                                        <label class="radio-inline" for="radios-1">
                                            <input type="radio" name="radios" id="radios-1" value="2" ng-model ="data.genero">
                                            Femenino
                                        </label> 
                                    </div>    

                                </div>
                            </div></br>
                            <legend></legend>
                            <div class="row">
                                <div class="col-md-2">
                                    <h4>Domicilio</h4>
                                </div>
                            </div>
                            <div class="row">                                
                                <div class="col-md-12">
                                    <label class="control-label" for="textarea">Dirección</label>                    
                                    <textarea class="form-control" id="textarea" name="textarea" ng-model ="data.direccion"></textarea>
                                </div>
                            </div></br>
                            <div class="row">
                                <div class="col-md-4">
                                    <label for="textinput">Lugar de nacimiento, Departamento</label>
                                    <select id="selectbasic" name="selectbasic" class="form-control" ng-model ="data.departamento_direccion">
                                        <option value="1">Option one</option>
                                        <option value="2">Option two</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="textinput">Municipio</label>
                                    <select id="selectbasic" name="selectbasic" class="form-control" ng-model ="data.municipio_direccion">
                                        <option value="1">Option one</option>
                                        <option value="2">Option two</option>
                                    </select>
                                </div>   
                            </div></br>
                            <div class="row">
                                <div class="col-md-2">
                                    <h5>Teléfono</h5>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3">
                                    <label for="textinput">Casa</label>
                                    <input id="textinput" name="textinput" type="text" placeholder="ingrese el número de teléfono de casa" class="form-control input-md" ng-model = "data.tel_casa">
                                </div>
                                <div class="col-md-3">
                                    <label for="textinput">Móvil</label>
                                    <input id="textinput" name="textinput" type="text" placeholder="ingrese el número de teléfono móvil" class="form-control input-md" ng-model = "data.tel_movil">
                                </div>
                                <div class="col-md-3">
                                    <label for="textinput">Oficina</label>
                                    <input id="textinput" name="textinput" type="text" placeholder="ingrese el número de teléfono de oficina" class="form-control input-md" ng-model = "data.tel_oficina">
                                </div>
                            </div></br>
                            <div class="row"></div>
                        </fieldset>              
                <div class="row">
                    <div class="col-md-4 col-lg-offset-4">
                    
                        <input class="submit" type="submit" value="Continuar">
                        <a href=""><button id="button2id" name="cancelar" class="btn btn-danger">Cancelar</button></a>
                    </div>
                </div></br>
            </div> 
            </br>
            </form>
</div>
</body>    

    <div class="container-fluid">
        <H3 class="text-center" style="color:#E42217;">Solicitud de beca</H3>
        <fieldset class="custom-border">
                <legend class="custom-border">Solicitud de beca de postgrado</legend>
        <form class="form-horizontal" name="solicitud" action="" method="POST">
        <div class="row" ng-view>            
            
        </div>
        </form>
        </fieldset>
    </div>  









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

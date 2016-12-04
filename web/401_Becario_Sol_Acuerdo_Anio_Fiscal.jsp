<%-- 
    Document   : 401_Becario_Sol_Acuerdo_Anio_Fiscal
    Created on : 11-16-2016, 04:05:00 PM
    Author     : aquel
--%>
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
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
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
<p class="text-right">Rol: <%= rol%></p>
<p class="text-right">Usuario: <%= user%></p>
<jsp:include page="menu.jsp"></jsp:include>
</head>
<body>

    <div class="container-fluid">        
        <H3 class="text-center" style="color:#E42217;">Solicitar Acuerdo de Año Fiscal</H3>
        <fieldset class="custom-border">
            <legend class="custom-border">Solicitar Acuerdo de Año Fiscal</legend>
            <div class="row">
                <div class="col-md-12">                
                    <fieldset class="custom-border">
                        <legend class="custom-border">Adjuntar documentación necesaria</legend>
                        <form class="form-horizontal"  name="SolAnioFiscal" action="SolAcuerdoAnioFiscalServlet" method="post" enctype="multipart/form-data">
                            <div class="row">                       
                                <div class="row">
                                    <div class="col-md-12 col-md-offset-2">
                                        <label>Seleccione la carta de solicitud del acuerdo de año fiscal</label>
                                    </div>
                                </div></br>
                                <div class="col-md-12 col-md-offset-2">
                                    <div class="col-md-2">
                                        <div class="form-group">
                                           <label>Carta de Solicitud del Becario-</label>  <p class="help-block"></p>
                                        </div>
                                    </div>
                                    <div class="col-md-6">    
                                        <div class="form-group">
                                                <div class="col-md-3 text-right">
                                                    <label for="textinput">Archivo de la oferta :</label>                                
                                                </div>
                                                <div class="col-md-3">      
                                                    <input type="file" name="doc_digital" accept="application/pdf">
                                                </div> 
                                        </div>
                                    </div> 
                                </div>
                            </div>



                            </br></br>
                            <div class="row">   
                                <div class="col-md-2 col-md-offset-5">
                                    <form style='display:inline;' action='SolAcuerdoAnioFiscalServlet.jsp' method='post'>
                                                        <input type='hidden' name='user' value='<%=user%>'>
                                    <input type='submit' class='btn btn-success' name='submit' value='Enviar Solicitud'></form>
                                </div>    
                            </div> </br>
                        </form></fieldset>
                </div> 
            </div></fieldset>

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

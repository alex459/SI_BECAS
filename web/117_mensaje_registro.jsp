<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema informático para la administración de becas de postgrado</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/customfieldset.css" rel="stylesheet">
        <jsp:include page="cabecera.jsp"></jsp:include>
    </head>
    <body bgcolor="gray">
        <%

            int tipo_mensaje = 2;
            String titulo = "Mensaje";
            String mensaje = "";
            String var1 = new String();

            try {
                tipo_mensaje = Integer.parseInt(request.getParameter("TIPO_MENSAJE"));
                titulo = request.getParameter("TITULO");
                mensaje = request.getParameter("MENSAJE");
            } catch (Exception ex) {

            }

            switch (tipo_mensaje) {
                case 1:
                    var1 = "success";
                    break;
                case 2:
                    var1 = "info";
                    break;
                case 3:
                    var1 = "warning";
                    break;
                case 4:
                    var1 = "danger";
                    break;
                default:
                    var1 = "info";
                    break;
            }


        %>

        <div class="container">
            <br>
            <br>
            <br>
            <form class="form-horizontal" action="login.jsp" method="post">
                <fieldset class="custom-border">
                    <br>
                    <br>
                    <br>
                    <div class="row">
                        <div class="col-md-3"></div>                        
                        <div class="col-md-6 text-center"><h2><%=titulo%></h2></div>
                        <div class="col-md-3"></div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-3"></div>                        
                        <div class="col-md-6 text-center">
                            <div class="alert alert-<%=var1%>">                                
                                <strong><%=mensaje%></strong>
                            </div>                            
                        </div>
                        <div class="col-md-3"></div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="row">
                            <div class="col-md-3"></div>                        
                            <div class="col-md-6 text-center">
                                <input type="submit" class="btn btn-primary" name="submit" value="Regresar">                                
                            </div>
                            <div class="col-md-3"></div>
                        </div>
                    </div>
                </fieldset>                    
            </form>
        </div>
    </body>
</html>
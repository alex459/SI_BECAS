<%-- 
    Document   : menu_corto
    Created on : 10-17-2016, 06:49:53 AM
    Author     : next
--%>

<%@page import="MODEL.Utilidades"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>


    <nav class="navbar navbar-custom" role="navigation">                
        

            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                </button> <a class="navbar-brand active" href="principal.jsp">Regresar</a>
            </div>            
            <ul class="nav navbar-nav navbar-right">	
                <li>                    
                    <a href="<%=Utilidades.ObtenerAyuda()%>">Ayuda</a>
                </li>
                <li>
                    <a href="logout.jsp">Salir</a>
                </li>                            
            </ul>
        
    </nav>


</head>

</html>

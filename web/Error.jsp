<%-- 
    Document   : Error
    Created on : 02-23-2017, 12:26:37 PM
    Author     : jose
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <% 
            request.getSession().invalidate();
            response.sendRedirect("login.jsp");
        %>;
    </body>
</html>

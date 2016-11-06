<%-- 
    Document   : logout
    Created on : 11-04-2016, 09:21:46 PM
    Author     : MauricioBC
--%>
<%
session.invalidate();
response.sendRedirect("login.jsp");
%>

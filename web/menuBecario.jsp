<%-- 
    Document   : menuBecario
    Created on : 11-16-2016, 04:12:47 PM
    Author     : alex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       <nav class="navbar navbar-custom" role="navigation">
    <div class="navbar-header">

        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
        </button> <a class="navbar-brand active" href="index.html">Inicio</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Información pública<strong class="caret"></strong></a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="315_candidato_ofertas_beca.jsp">Ofertas de beca</a>
                        <a href="316_candidatos_documentos.jsp">Documentos</a>
                        <a href="317_candidatos_acercade.jsp">Acerca de</a>
                        <a href="#">Login/Logout</a>
                    </li>								
                </ul>
            </li>
        </ul>
        <ul class="nav navbar-nav">
            </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">Becarios<strong class="caret"></strong></a>
                <ul class="dropdown-menu">
                    <li>
                        <a href="401_Becario_Sol_Acuerdo_Anio_Fiscal.jsp">Solicitar acuerdo de año fiscal</a>
                        <a href="402_Becario_Sol_Prorroga.jsp">Solicitar prórroga</a>
                        <a href="403_Becario_Agregar_Documento_Finalizacion_Beca.jsp">Agregar documentos de finalización de beca</a>
                        <a href="404_Becario_Sol_Inicio_Servicio_Contractual.jsp">Solicitar inicio de servicio contractual</a>
                        <a href="405_Becario_Sol_Acuerdo_Gestion_Compromiso_Contractual.jsp">Solicitar acuerdo de de gestión de compromiso contractual</a>
                        <a href="406_Becario_Sol_Acuerdo_Gestion_Liberacion.jsp">Solicitar acuerdo de gestión de liberación</a>
                    </li>								
                </ul>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">						
            <li>
                <a href="#">Ayuda</a>
            </li>
            
            <li>
                 <a href="logout.jsp">Salir</a>
            </li>
        </ul>
    </div>
</nav>        
    </head> 
</html>

<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="POJO.OfertaBeca"%>
<%@page import="DAO.BecaDAO"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="DAO.OfertaBecaDAO"%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.IdiomaDAO"%>
<%@page import="POJO.Idioma"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
%>
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
    <link rel="stylesheet" type="text/css" href="css/bootstrap-datepicker3.min.css" />

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


<%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
<jsp:include page="menu_corto.jsp"></jsp:include>

</head>
<body>


    <div class="container-fluid">
        <div class="row"><!-- TITULO DE LA PANTALLA -->
            <h2>
                <p class="text-center" style="color:#cf2a27">Modificar Oferta de Beca</p>
            </h2>

            <br></br>

        </div><!-- TITULO DE LA PANTALLA -->  

        <div class="col-md-12">

            <form class="form-horizontal" action="ModificarOfertaBecaServlet" method="post" enctype="multipart/form-data">
            <% OfertaBeca ofertaActual = new OfertaBeca();
                OfertaBecaDAO ofertaBecaDAO = new OfertaBecaDAO();
                String id_oferta = request.getParameter("ID_OFERTA_BECA");
                System.out.println("ID RECIBIDO PARA MODIFICAR: " + id_oferta);
                ofertaActual = ofertaBecaDAO.consultarPorId(Integer.parseInt(id_oferta));
                InstitucionDAO InstitucionDAO3 = new InstitucionDAO();
                DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
                String idDoc = request.getParameter("ID_DOC");
                System.out.println("ID DE DOCUMENTO " + idDoc);
            %>
            <input value="<%=id_oferta%>" id="idOferta" name="idOferta" hidden>
            <fieldset class="custom-border">  
                <legend class="custom-border">Modificar oferta de beca</legend>
                <div class="row"> 
                    <div class="col-md-3 text-right">                                   
                        <label for="nombreOferta">Nombre de la oferta : </label>                                
                    </div>
                    <div class="col-md-3">
                        <input id="nombreOferta" name="nombreOferta" value="<%= ofertaActual.getNombreOferta()%>" type="text" maxlength="100" placeholder="ingrese el nombre de la oferta" required class="form-control input-md">                                                                
                    </div>
                    <div class="col-md-3 text-right">
                        <label for="duracion">Duracion (Meses) : </label>                                
                    </div>
                    <div class="col-md-3 text-right">
                        <input id="duracion" name="duracion" value="<%= ofertaActual.getDuracion()%>" type="number" min="1" max="60" placeholder="cambiar" required class="form-control input-md">                                                                
                    </div>                        
                </div> 
                <br>
                <div class="row">
                    <div class="col-md-3 text-right">
                        <label for="institucionOfertante">Institucion ofertante : </label>                                
                    </div>
                    <div class="col-md-3">
                        <select id="institucionOferente" name="institucionOferente" class="form-control">
                            <%
                                InstitucionDAO institucionDAO2 = new InstitucionDAO();
                                String instEstAct = institucionDAO2.consultarPorId(ofertaActual.getIdInstitucionFinanciera()).getNombreInstitucion();
                                ArrayList<Institucion> listaInstitucion2 = new ArrayList();
                                listaInstitucion2 = institucionDAO2.consultarPorTipo("OFERTANTE");
                                for (int i = 0; i < listaInstitucion2.size(); i++) {
                                    String valActual = listaInstitucion2.get(i).getNombreInstitucion();
                                    if (instEstAct.trim().equals(valActual.trim())) {
                            %> <option selected value="<%=listaInstitucion2.get(i).getNombreInstitucion()%>"><%=listaInstitucion2.get(i).getNombreInstitucion()%></option> <%
                            } else {
                            %> <option value="<%=listaInstitucion2.get(i).getNombreInstitucion()%>"><%=listaInstitucion2.get(i).getNombreInstitucion()%></option>
                            <%     }

                                }
                            %>   
                        </select>     
                    </div>
                    <div class="col-md-3 text-right">
                        <label for="modalidad">Modalidad  :</label>                                
                    </div>
                    <div class="col-md-3">                        
                        <select id="modalidad" name="modalidad" class="form-control">
                            <%
                                String tipoModAct = ofertaActual.getModalidad();
                                if (tipoModAct.trim().equals("PRESENCIAL")) {
                            %><option selected value="PRESENCIAL">PRESENCIAL</option>
                            <option value="SEMIPRESENCIAL">SEMIPRESENCIAL</option>
                            <option value="VIRTUAL">VIRTUAL</option> <%
                            } else if (tipoModAct.trim().equals("SEMIPRESENCIAL")) {
                            %><option value="PRESENCIAL">PRESENCIAL</option>
                            <option selected value="SEMIPRESENCIAL">Semipresencial</option>
                            <option value="VIRTUAL">VIRTUAL</option><%
                            } else {
                            %><option value="PRESENCIAL">PRESENCIAL</option>
                            <option value="SEMIPRESENCIAL">SEMIPRESENCIAL</option>
                            <option selected value="VIRTUAL">VIRTUAL</option><%
                                }
                            %> 
                        </select>  
                    </div>  
                </div>

                <br>

                <div class="row">
                    <div class="col-md-3 text-right">
                        <label for="textinput">Institucion de estudio :</label>                                
                    </div>
                    <div class="col-md-3">                                

                        <select id="institucionEstudio" name="institucionEstudio" class="form-control">
                            <%  //InstitucionDAO institucionDAO2 = new InstitucionDAO();
                                instEstAct = institucionDAO2.consultarPorId(ofertaActual.getIdInstitucionEstudio()).getNombreInstitucion();
                                //ArrayList<Institucion> listaInstitucion2 = new ArrayList();
                                listaInstitucion2 = institucionDAO2.consultarPorTipo("ESTUDIO");
                                for (int i = 0; i < listaInstitucion2.size(); i++) {
                                    String valActual = listaInstitucion2.get(i).getNombreInstitucion();
                                    if (instEstAct.trim().equals(valActual.trim())) {
                            %><option selected value="<%=listaInstitucion2.get(i).getNombreInstitucion()%>"><%=listaInstitucion2.get(i).getNombreInstitucion()%></option>
                            <%     } else {
                            %><option value="<%=listaInstitucion2.get(i).getNombreInstitucion()%>"><%=listaInstitucion2.get(i).getNombreInstitucion()%></option>
                            <%
                                    }

                                }
                            %>    
                        </select>

                    </div>
                    <div class="col-md-3 text-right">
                        <label for="textinput">Fecha inicio de estudio :</label>                                
                    </div>
                    <div class="col-md-3">                                                            
                        <div class="input-group date">
                            <input type="text" class="form-control" id="fechaInicio" name="fechaInicio" value="<%=df.format(ofertaActual.getFechaInicio())%>"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                        </div>
                    </div>              
                </div>   
                <br>
                <div class="row">
                    <div class="col-md-3 text-right">
                        <label for="tipoEstudio">Tipo de estudio :</label>                                
                    </div>
                    <div class="col-md-3"> 
                        <select id="tipoEstudio" name="tipoEstudio" class="form-control">
                            <%
                                String tipoEstAct = ofertaActual.getTipoEstudio();
                                if (tipoEstAct.trim().equals("MAESTRIA")) {
                            %><option selected value="MAESTRIA">MAESTRIA</option>
                            <option value="DOCTORADO">DOCTORADO</option>
                            <option value="ESPECIALIZACIÓN">ESPECIALIZACIÓN</option> <%
                            } else if (tipoEstAct.trim().equals("DOCTORADO")) {
                            %>   <option value="MAESTRIA">MAESTRIA</option>
                            <option selected value="DOCTORADO">DOCTORADO</option>
                            <option value="ESPECIALIZACIÓN">ESPECIALIZACIÓN</option> <%
                            } else {
                            %>   <option value="MAESTRIA">MAESTRIA</option>
                            <option value="DOCTORADO">DOCTORADO</option>
                            <option selected value="ESPECIALIZACIÓN">ESPECIALIZACIÓN</option> <%
                                }
                            %>  
                        </select>
                    </div>
                    <div class="col-md-3 text-right">
                        <label for="fechaCierre">Fecha limite para aplicar :</label>                                
                    </div>
                    <div class="col-md-3">                                
                        <div class="input-group date">
                            <input type="text" name="fechaCierre" id="fechaCierre" class="form-control" value="<%=df.format(ofertaActual.getFechaCierre())%>"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="data.fecha_nacimiento"></i></span>
                        </div>
                    </div>              
                </div>
                <br>
                <div class="row">
                    <div class="col-md-3 text-right">    
                        <label for="tipoBeca">Tipo de beca: </label>      
                    </div>
                    <div class="col-md-3">                                
                        <select id="tipoBeca" name="tipoBeca" class="form-control">
                            <%
                                String tipoBecaAct = ofertaActual.getTipoOfertaBeca();
                                if (tipoBecaAct.trim().equals("INTERNA")) {
                            %> <option selected value="INTERNA">INTERNA</option>
                            <option value="EXTERNA">EXTERNA</option> <%
                            } else {
                            %>  <option value="INTERNA">INTERNA</option>
                            <option selected value="EXTERNA">EXTERNA</option>
                            <% }
                            %>                    
                        </select>
                    </div>
                    <div class="col-md-3 text-right">
                        <label for="textinput">Idioma :</label>                                
                    </div>
                    <div class="col-md-3">                                
                        <select id="idioma" name="idioma" class="form-control">
                            <%
                                String idiomaActual = ofertaActual.getIdioma();
                                IdiomaDAO idiomaDAO = new IdiomaDAO();
                                ArrayList<Idioma> listaIdioma = new ArrayList<Idioma>();
                                listaIdioma = idiomaDAO.consultarTodos();
                                for (int i = 0; i < listaIdioma.size(); i++) {
                                    if (idiomaActual.equals(listaIdioma.get(i).getIdioma())) {
                            %><option selected value="<%=listaIdioma.get(i).getIdioma()%>"><%=listaIdioma.get(i).getIdioma()%></option><%
                            } else {
                            %><option value="<%=listaIdioma.get(i).getIdioma()%>"><%=listaIdioma.get(i).getIdioma()%></option><%
                                    }
                                }
                                %>                              
                        </select>

                    </div>              
                </div>
                <br> 
                <div class="row">
                    <div class="col-md-3 text-right">
                        <label for="financiamiento">Financiamiento: </label>                                
                    </div>
                    <div class="col-md-3">         
                        <select id="financiamiento" name="financiamiento" class="form-control">
                            <%
                                String tipoFin = ofertaActual.getFinanciamiento();
                                if (tipoFin.trim().equals("BECA COMPLETA")) {
                            %> <option selected value="BECA COMPLETA">BECA COMPLETA</option>
                            <option value="MEDIA BECA">MEDIA BECA</option>
                            <option value="CUARTO DE BECA">CUARTO DE BECA</option> <%
                            } else if (tipoFin.trim().equals("MEDIA BECA")) {
                            %> <option value="BECA COMPLETA">BECA COMPLETA</option>
                            <option selected value="MEDIA BECA">MEDIA BECA</option>
                            <option value="CUARTO DE BECA">CUARTO DE BECA</option><%
                            } else {
                            %>  <option value="BECA COMPLETA">BECA COMPLETA</option>
                            <option value="MEDIA BECA">MEDIA BECA</option>
                            <option selected value="CUARTO DE BECA">CUARTO DE BECA</option> <%
                                }
                            %>  
                        </select>
                    </div>
                    <div class="row"> 
                            <div class="col-md-3 text-right">
                                <label for="textinput">Seleccione un nuevo archivo si desea modificar:</label>                                
                            </div>
                            <div class="col-md-3">      
                                <input type="file" name="doc_digital" accept="application/pdf" >
                                   <input id="ID_DOCUMENTO" name="ID_DOCUMENTO" value="<%=idDoc%>" type="hidden" class="form-control input-md">                                                                
                
                            </div>                          
                    </div>

                </div>
                <br>
                <div class="row">
                    <div class="col-md-3 text-right">
                        <label for="perfilBeca">Perfil de la beca: </label>                                
                    </div>
                    <div class="col-md-9">                                
                        <textarea class="form-control" id="perfilBeca" name="perfilBeca" maxlength="2000" value="" required>
                            <%= ofertaActual.getPerfil()%>
                        </textarea>
                    </div>                                    
                </div>
                <br>
                <div class="row">
                    <div class="col-md-12 text-center">
                        <input type="submit" class="btn btn-primary" name="submit" value="Modificar oferta">
                        <input type="submit" class="btn btn-danger" name="submit" value="Cancelar">
                    </div>
                </div>
            </fieldset>
        </form>                    
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

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
                                $(function () {
                                    $('.input-group.date').datepicker({
                                        format: 'yyyy-mm-dd',
                                        calendarWeeks: true,
                                        todayHighlight: true,
                                        autoclose: true,
                                        startDate: new Date()
                                    });
                                });
</script>
</body>
</html>

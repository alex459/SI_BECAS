<%-- 
    Document   : principal
    Created on : 10-17-2016, 06:14:37 AM
    Author     : next
--%>
<%@page import="MODEL.Utilidades"%>
<%@page import="POJO.OfertaBeca"%>
<%@page import="DAO.BecaDAO"%>
<%@page import="DAO.InstitucionDAO"%>
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
    String id_usuario_login = (String) actual.getAttribute("id_user_login");
    String rol=(String)actual.getAttribute("rol");
    String user=(String)actual.getAttribute("user");
    Integer tipo_usuario_logeado = (Integer) actual.getAttribute("id_tipo_usuario");
    ArrayList<String> tipo_usuarios_permitidos = new ArrayList<String>();
    //AGREGAR SOLO LOS ID DE LOS USUARIOS AUTORIZADOS PARA ESTA PANTALLA------
    tipo_usuarios_permitidos.add("7");
    tipo_usuarios_permitidos.add("8");
    tipo_usuarios_permitidos.add("9");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user==null) {
        response.sendRedirect("logout.jsp");        
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

<jsp:include page="cabecera.jsp"></jsp:include>



<p class="text-right">Rol: <%= rol %></p>
<p class="text-right">Usuario: <%= user %></p>


<%-- todo el menu esta contenido en la siguiente linea
     el menu puede ser cambiado en la pagina menu.jsp --%>
<jsp:include page="menu_corto.jsp"></jsp:include>

</head>
<body>


    <div class="container-fluid">
        <div class="row"><!-- TITULO DE LA PANTALLA -->
            <h3>
                <p class="text-center" style="color:#cf2a27">Agregar Oferta de Beca</p>
            </h3>
            <br></br>
        </div><!-- TITULO DE LA PANTALLA -->  

        <div class="col-md-12" ng-app="AgregarModificarOfertaApp" ng-controller="AgregarModificarOfertaCtrl">

            <form  class="form-horizontal" name="AgregarOfertaBeca" action="AgregarOfertaBecaServlet" method="post" enctype="multipart/form-data" novalidate>
                <input id="userlog" value=<%=id_usuario_login %> type="hidden" />
                <fieldset class="custom-border">  
                    <legend class="custom-border">Agregar Oferta de Beca</legend>
                    <div class="row"> 
                        <div class="col-md-3 text-right">                                   
                            <label for="nombreOferta">Nombre de la Oferta : </label>                                
                        </div>
                        <div class="col-md-3">
                            <input id="nombreOferta" name="nombreOferta" type="text" ng-pattern="/^[0-9A-ZÁÉÍÓÚÑ ]*$/" minlength="10" maxlength="100" placeholder="Ingrese el Nombre de la Oferta" class="form-control input-md" ng-model="datos.nombreOferta" ng-required="true">                                                                
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.nombreOferta.$error.required">Debe Ingresar un Nombre para la Oferta de Beca.</span>
                            <span class="text-danger" ng-show="AgregarOfertaBeca.nombreOferta.$error.minlength">Mínimo 10 Caracteres</span>
                            <span class="text-danger" ng-show="AgregarOfertaBeca.nombreOferta.$error.pattern">Solo se Permiten Letras Mayúscular y Números (A-Z y 0-9).</span>
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="duracion">Duracion (Meses) : </label>                                
                        </div>
                        <div class="col-md-3 text-right">
                            <input id="duracion" name="duracion" type="number" placeholder="Cambiar" min="1" max="60" class="form-control input-md" ng-model="datos.dur" ng-pattern="/^[0-9]*$/" ng-required="true">    
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.duracion.$error.required">Debe Ingresar la Duración de la Oferta.</span>
                            <span class="text-danger" ng-show="AgregarOfertaBeca.duracion.$error.pattern">Solo se permiten números enteros.</span>
                        </div>                        
                    </div> 
                    <br>
                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="institucionOfertante">Institución Ofertante : </label>                                
                        </div>
                        <div class="col-md-3">
                        <select id="institucionOferente" name="institucionOferente" class="form-control" ng-model="datos.instOfer" ng-required="true">
                            <%
                                InstitucionDAO institucionDAO = new InstitucionDAO();
                                ArrayList<Institucion> listaInstitucion = new ArrayList();
                                listaInstitucion = institucionDAO.consultarActivosPorTipo("OFERTANTE");
                                 %><option value="" disabled selected required>Seleccione una Institución</option><%  
                                for (int i = 0; i < listaInstitucion.size(); i++) { %>
                                    <option value="<%=listaInstitucion.get(i).getNombreInstitucion()%>"> <%=listaInstitucion.get(i).getNombreInstitucion()%></option>
                                    <%   }
                            %>    
                        </select>    
                        <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.institucionOferente.$error.required">Seleccione una Institución Oferente.</span>
                        </div>
                        <div class="col-md-3 text-right">
                            <label for="modalidad">Modalidad :</label>                                
                        </div>
                        <div class="col-md-3">
                         <select id="modalidad" name="modalidad" class="form-control" ng-model="datos.mod" ng-required="true">
                                <option value="">Seleccione una Opción</option>
                                <option value="PRESENCIAL">PRESENCIAL</option>  
                                <option value="SEMIPRESENCIAL">SEMIPRESENCIAL</option>
                                <option value="VIRTUAL">VIRTUAL</option>
                         </select>  
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.modalidad.$error.required">Seleccione una Modalidad.</span>

                        </div>  
                    </div>

                    <br>

                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="institucionEstudio">Institución de Estudio :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <select id="institucionEstudio" name="institucionEstudio" class="form-control" ng-model="datos.instEst" ng-required="true">
                            <%
                                InstitucionDAO institucionDAO2 = new InstitucionDAO();
                                ArrayList<Institucion> listaInstitucion2 = new ArrayList();
                                listaInstitucion2 = institucionDAO2.consultarActivosPorTipo("ESTUDIO");
                                 %><option value="" disabled selected required>Seleccione una Opción</option><% 
                                for (int i = 0; i < listaInstitucion2.size(); i++) {  %>
                                    <option value="<%=listaInstitucion2.get(i).getNombreInstitucion()%>"> <%= listaInstitucion2.get(i).getNombreInstitucion()%> </option>
                                    <option  name="pais" style="display:none;" id="pais" value="<%=listaInstitucion2.get(i).getPais() %>"><%=listaInstitucion2.get(i).getPais() %></option>
                                    
                             <%
                                 
                              }
                            %>   
                            </select>
                                
                                    <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.institucionEstudio.$error.required">Seleccione una Institución de Estudio.</span>
  
                        </div>
                              
                        <div class="col-md-3 text-right">
                            <label for="fechaInicio">Fecha Inicio de Estudio :</label>                                
                        </div>
                        <div class="col-md-3">                                                            
                            <div class="input-group date">
                                        <input type="text" name="fechaInicio" id="fechaInicio" class="form-control" ng-model="datos.fechaIni" ng-required="true"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="data.fecha_nacimiento"></i></span>
                                             </div>
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.fechaInicio.$error.required">Ingrese Fecha de Inicio de Estudio.</span>

                        </div>              
                    </div>   
                    <br>
                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="tipoEstudio">Tipo de Estudio :</label>                                
                        </div>
                        <div class="col-md-3"> 
                            <select id="tipoEstudio" name="tipoEstudio" class="form-control" ng-model="datos.tipoEst" ng-required="true">
                                <option value="">Seleccione una Opción</option>
                               <option value="MAESTRIA">MAESTRIA</option>
                               <option value="DOCTORADO">DOCTORADO</option>
                               <option value="ESPECIALIZACIÓN">ESPECIALIZACIÓN</option>
                            </select>
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.tipoEstudio.$error.required">Seleccione un Tipo de Estudio.</span>

                        </div>
                        <div class="col-md-3 text-right">
                            <label for="fechaCierre">Fecha Límite Para Aplicar :</label>                                
                        </div>
                        <div class="col-md-3">                                
                            <div class="input-group date">
                                <input type="text" name="fechaCierre" id="fechaCierre" class="form-control" ng-model="datos.fechaC" ng-required="true"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="data.fecha_nacimiento"></i></span>
                               </div>
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.fechaCierre.$error.required">Ingrese una Fecha de Cierre.</span>
    
                        </div>              
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="tipoBeca">Tipo de Beca: </label>                                
                        </div>
                        <div class="col-md-3">    
                            <select id="tipoBeca" name="tipoBeca" class="form-control" ng-model="datos.tipoB" ng-required="false" ng-disabled="true">
                                <option value="">Seleccione una Opción</option>
                                <option value="INTERNA">INTERNA</option>
                                <option value="EXTERNA">EXTERNA</option>                                
                            </select>
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.tipoBeca.$error.required">Seleccione un Tipo de Beca.</span>

                        </div>
                        <div class="col-md-3 text-right">
                            <label for="idioma">Idioma :</label>                                
                        </div>
                        <div class="col-md-3"> 
                            <select id="idioma" name="idioma" class="form-control" ng-model="datos.idi" ng-required="true">
                                <option value="">Seleccione Idioma</option> 
                                 <%
                                IdiomaDAO idiomaDAO = new IdiomaDAO();
                                ArrayList<Idioma> listaIdioma = new ArrayList<Idioma>();
                                listaIdioma = idiomaDAO.consultarTodos();
                                for (int i = 0; i < listaIdioma.size(); i++) {
                                        %><option value="<%=listaIdioma.get(i).getIdioma()%>"><%=listaIdioma.get(i).getIdioma()%></option><%
                                    
                                }
                            %>
                            </select>
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.idioma.$error.required">Seleccione un Idioma.</span>

                        </div>              
                    </div>
                    <br> 
                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="financiamiento">Financiamiento: </label>                                
                        </div>
                        <div class="col-md-3">         
                            <select id="financiamiento" name="financiamiento" class="form-control" ng-model="datos.finan" ng-required="true">
                                <option value="">Seleccione una Opción</option>
                                <option value="BECA COMPLETA">BECA COMPLETA</option>
                                <option value="MEDIA BECA">MEDIA BECA</option>
                                <option value="CUARTO DE BECA">CUARTO DE BECA</option>
                            </select>
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.financiamiento.$error.required">Seleccione un Tipo de Financiamiento.</span>

                        </div>
                        <div class="col-md-3 text-right">
                            <label for="textinput">Archivo de la Oferta :</label>                                
                        </div>
                        <div class="col-md-3">      
                            <input type="file" name="doc_digital" accept="application/pdf" ng-model="doc_digital" valid-file ng-required="true">
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.doc_digital.$error.required">Debe Agregar un Documento PDF.</span>
                      
                        </div>              
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-3 text-right">
                            <label for="perfil">Requerimientos: </label>                                
                        </div>
                        <div class="col-md-9">                                
                            <textarea class="form-control" id="perfilBeca" maxlength="2000" name="perfilBeca" ng-model="datos.Perfil" ng-required="true"></textarea>
                            <span class="text-danger" ng-show="!AgregarOfertaBeca.$pristine && AgregarOfertaBeca.perfilBeca.$error.required">Ingrese Información para el Perfil de la Oferta.</span>

                        </div>                                    
                    </div>
                    <br>
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <input type="submit" class="btn btn-primary" name="submit" value="Agregar oferta" ng-disabled="!AgregarOfertaBeca.$valid">
                            <a href="principal.jsp" type="submit" class="btn btn-danger" name="submit">Cancelar</a>
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
    <script src="js/angular.min.js"></script>
        <script src="js/agregarModificarOferta.js"></script>
<script type="text/javascript">
    $(function () {
        $('.input-group.date').datepicker({            
            format: 'yyyy-mm-dd',
            calendarWeeks: true,
            todayHighlight: true,
            autoclose: true,
            startDate: new Date()
        });
         $('#institucionEstudio').on('change', function(){
          //  $('#tipoBeca option[value="EXTERNA"]').prop('selected', true);
            var selectPais= document.getElementById("#pais");
            var selected2 = $("#pais").find("option:selected").text();
            var univ="universidad de el salvador";
    var selected = $(this).find("option:selected").val();
    if (selected.toUpperCase() === univ.toUpperCase()) {
          document.getElementById('tipoBeca').value="INTERNA";
            //alert("equal");
        }else{
            document.getElementById('tipoBeca').value="EXTERNA";
        }
  });
        $('#fechaCierre').datepicker({
            format: 'yyyy-mm-dd',
            calendarWeeks: true,
            todayHighlight: true,
            autoclose: true
        }).on('change.dp', function (e) {
            $('#fechaInicio').datepicker('setStartDate', new Date($(this).val()));
        });
        $('#fechaInicio').datepicker({
            format: 'yyyy-mm-dd',
            calendarWeeks: true,
            todayHighlight: true,
            autoclose: true
        }).on('change.dp', function (e) {
            $('#fechaCierre').datepicker('setEndDate', new Date($(this).val()));
        });
    
    });
 
</script>
</body>
</html>

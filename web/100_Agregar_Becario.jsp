<%-- 
    Document   : 100_Agregar_Becario
    Created on : 6/03/2017, 11:06:47 AM
    Author     : adminPC
--%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="DAO.OfertaBecaDAO"%>
<%@page import="POJO.OfertaBeca"%>
<!-- inicio proceso de seguridad de login -->
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<%
    response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
    request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Cache-Control", "must-revalidate");
    response.setHeader("Cache-Control", "no-cache");
    HttpSession actual = request.getSession();
    String id_usuario_login = (String) actual.getAttribute("id_user_login");
    String rol = (String) actual.getAttribute("rol");
    String user = (String) actual.getAttribute("user");
    Integer tipo_usuario_logeado = (Integer) actual.getAttribute("id_tipo_usuario");
    ArrayList<String> tipo_usuarios_permitidos = new ArrayList<String>();
    //AGREGAR SOLO LOS ID DE LOS USUARIOS AUTORIZADOS PARA ESTA PANTALLA------
    tipo_usuarios_permitidos.add("7");
    tipo_usuarios_permitidos.add("8");
    tipo_usuarios_permitidos.add("9");
    boolean autorizacion = Utilidades.verificarPermisos(tipo_usuario_logeado, tipo_usuarios_permitidos);
    if (!autorizacion || user == null) {
        response.sendRedirect("logout.jsp");
    }
%>
<!-- fin de proceso de seguridad de login -->

<!--Recuperacion de datos y llenado de listas-->
<%
    String nombre1 = "";
    String nombre2 = "";
    String apellido1 = "";
    String apellido2 = "";
    int ID_USUARIO = 0;
    ArrayList<OfertaBeca> ofertas = new ArrayList();
    ArrayList<Institucion> listaInstitucionOferta = new ArrayList();
    ArrayList<Institucion> listaInstitucion2 = new ArrayList();
    try {
        nombre1 = request.getParameter("nombre1");
        nombre2 = request.getParameter("nombre2");
        apellido1 = request.getParameter("apellido1");
        apellido2 = request.getParameter("apellido2");
        ID_USUARIO = Integer.parseInt(request.getParameter("ID_USUARIO"));
        if (nombre1.equals(null) || apellido1.equals(null)) {
            response.sendRedirect("Agregar_Becario_Consulta.jsp");
        }
        OfertaBecaDAO ofertaDao = new OfertaBecaDAO();
        ofertas = ofertaDao.consultarTodos();
        InstitucionDAO institucionDAO = new InstitucionDAO();
        listaInstitucionOferta = institucionDAO.consultarActivosPorTipo("OFERTANTE");
        listaInstitucion2 = institucionDAO.consultarActivosPorTipo("ESTUDIO");
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("Agregar_Becario_Consulta.jsp");
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

        <jsp:include page="cabecera.jsp"></jsp:include>



        <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>

    </head>
    
<body ng-app="AgregarBecaApp" ng-controller="AgregarBecaCtrl">
    <!--TITULO DE PANTALLA-->
    <h3 class="text-center" style="color:#cf2a27">
        Agregar Becario
    </h3>
    <div class="row" ng-init="nombre1 = '<%=nombre1%>'; nombre2 = '<%=nombre2%>';">
    <form action="AgregarBecarioServlet" name="agregarBecario" method="post" enctype="multipart/form-data" novalidate>
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <fieldset class="custom-border">
                <legend class="custom-border">Datos de Beca</legend>
                <div class="row">                    
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Primer Nombre: </label><br>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="nombre1" class="form-control" ng-model="nombre1" ng-disabled="true" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">
                            <span class="text-danger" ng-show="!agregarBecario.$pristine && agregarBecario.nombre1.$error.required">El Primer Nombre es Requerido.</span>
                            <span class="text-danger" ng-show="agregarBecario.nombre1.$error.minlength">Mínimo 3 Caracteres.</span>
                            <span class="text-danger" ng-show="agregarBecario.nombre1.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span><br><br>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Segundo Nombre: </label><br>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="nombre2" class="form-control" ng-model="nombre2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3" ng-disabled="true">
                            <span class="text-danger" ng-show="agregarBecario.nombre2.$error.minlength">Mínimo 3 Caracteres</span>
                            <span class="text-danger" ng-show="agregarBecario.nombre2.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span><br><br>
                        </div>
                    </div>
                </div>
                <div class="row" ng-init="apellido1 = '<%=apellido1%>'; apellido2 = '<%=apellido2%>';">                    
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Primer Apellido: </label><br>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="apellido1" class="form-control" ng-model="apellido1" ng-disabled="true" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3">
                            <span class="text-danger" ng-show="!agregarBecario.$pristine && agregarBecario.apellido1.$error.required">El Primer Apellido es Requerido.</span>
                            <span class="text-danger" ng-show="agregarBecario.apellido1.$error.minlength">Mínimo 3 Caracteres.</span>
                            <span class="text-danger" ng-show="agregarBecario.apellido1.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span><br><br>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Segundo Apellido: </label><br>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="apellido2" class="form-control" ng-model="apellido2" ng-pattern="/^[A-ZÑÁÉÍÓÚ]*$/" maxlength="15" minlength="3" ng-disabled="true">
                            <span class="text-danger" ng-show="agregarBecario.apellido2.$error.minlength">Mínimo 3 Caracteres.</span>
                            <span class="text-danger" ng-show="agregarBecario.apellido2.$error.pattern">Solo se Permiten Letras Mayúsculas. (A-Z).</span><br><br>
                        </div>
                    </div>
                </div>
                <div class="row">                    
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Seleccione la oferta de beca: </label><br>
                        </div>
                        <div class="col-md-8">

                            <select name="oferta" class="form-control" ng-model="oferta" ng-disabled="checkOferta" ng-required="!checkOferta">
                                <%
                                    for (int i = 0; i < ofertas.size(); i++) {
                                        out.write("<option value=" + ofertas.get(i).getIdOfertaBeca() + ">" + ofertas.get(i).getNombreOferta() + "</option>");
                                    }
                                %>    
                            </select> 
                            <span class="text-danger" ng-show="agregarBecario.oferta.$error.required">Seleccione una Oferta.</span>
                            <br>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Ingresar manualmente Oferta </label><br>
                        </div>   
                        <div class="col-md-1">{{valorcheck}}
                            <input type="checkBox" name="checkOferta" class="form-control" ng-model="checkOferta" ng-click="mostrarFormularioOferta()"><br> 
                            <input type="hidden" name="valorcheck" ng-value = "{{valorcheck}}" >

                        </div>                                                     
                    </div>
                </div>
                <!--Agregar informacion de oferta-->
                <div class="row" ng-show="checkOferta">                    
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Nombre de la Oferta : </label><br>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="nombreOferta" class="form-control" ng-model="nombreOferta" ng-required="checkOferta" ng-pattern="/^[0-9A-ZÁÉÍÓÚÑ ]*$/" minlength="10" maxlength="100">
                            <span class="text-danger" ng-show="agregarBecario.nombreOferta.$error.required">Ingrese el nombre de la Oferta.</span>
                            <span class="text-danger" ng-show="agregarBecario.nombreOferta.$error.minlength">Mínimo 10 Caracteres</span>
                            <span class="text-danger" ng-show="agregarBecario.nombreOferta.$error.pattern">Solo se Permiten Letras Mayúscular y Números (A-Z y 0-9).</span><br>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Tipo de Estudio: </label><br>
                        </div>
                        <div class="col-md-8">
                            <select id="tipoEstudio" name="tipoEstudio" class="form-control" ng-model="tipoEstudio" ng-required="checkOferta">
                                <option value="">Seleccione una Opción</option>
                                <option value="MAESTRIA">MAESTRIA</option>
                                <option value="DOCTORADO">DOCTORADO</option>
                                <option value="ESPECIALIZACIÓN">ESPECIALIZACIÓN</option>
                            </select>  
                            <span class="text-danger" ng-show="agregarBecario.tipoEstudio.$error.required">Seleccione un Tipo de Estudio.</span><br>
                        </div>
                    </div>
                </div>
                <div class="row" ng-show="checkOferta">                    
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Institución de Estudio: </label><br>
                        </div>
                        <div class="col-md-8">
                            <select id="institucionEstudio" name="institucionEstudio" class="form-control" ng-model="institucionEstudio" ng-required="checkOferta">
                                <option value="" disabled selected required>Seleccione una Opción</option><%
                                        for (int i = 0; i < listaInstitucion2.size(); i++) {%>
                                <option value="<%=listaInstitucion2.get(i).getNombreInstitucion()%>"> <%= listaInstitucion2.get(i).getNombreInstitucion()%> </option>
                                <option  name="pais" style="display:none;" id="pais" value="<%=listaInstitucion2.get(i).getPais()%>"><%=listaInstitucion2.get(i).getPais()%></option>

                                <%
                                    }
                                %>   
                            </select>
                            <span class="text-danger" ng-show="agregarBecario.institucionEstudio.$error.required">Seleccione una Institución de Estudio.</span><br>  
                            <input id="tipoBeca" name="tipoBeca" type="hidden" ng-model="tipoBeca">
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Institución Ofertante: </label><br>
                        </div>
                        <div class="col-md-8">
                            <select id="institucionOferente" name="institucionOferente" class="form-control" ng-model="institucionOferente" ng-required="checkOferta">
                                <option value="" disabled selected required>Seleccione una Institución</option><%
                                        for (int i = 0; i < listaInstitucionOferta.size(); i++) {%>
                                <option value="<%=listaInstitucionOferta.get(i).getNombreInstitucion()%>"> <%=listaInstitucionOferta.get(i).getNombreInstitucion()%></option>
                                <%   }
                                %>
                            </select>
                            <span class="text-danger" ng-show="agregarBecario.institucionOferente.$error.required">Seleccione una Institución Ofertante.</span><br>  
                        </div>
                    </div>
                </div>
                <!--Fin informacion de oferta-->
                <div class="row">                    
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Fecha de Inicio de Beca: </label><br>
                        </div>
                        <div class="col-md-8">
                            <div class="input-group date">
                                <input type="text" name="fechaInicio" id="fechaInicio" class="form-control" ng-model="fechaInicio" ng-required="true"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="fechaInicio"></i></span>
                            </div> 
                            <span class="text-danger" ng-show="agregarBecario.fechaInicio.$error.required">Seleccione la Fecha de Inicio de Beca.</span><br>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="col-md-4">
                            <label>Fecha de Fin Beca: </label><br>
                        </div>
                        <div class="col-md-8">
                            <div class="input-group date">
                                <input type="text" name="fechaFin" id="fechaFin" class="form-control" ng-model="fechaFin" ng-required="true"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" ng-model ="fechaFin"></i></span>
                            </div>    
                            <span class="text-danger" ng-show="agregarBecario.fechaFin.$error.required">Seleccione la Fecha de Fin de Beca.</span><br>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <fieldset class="custom-border">
                            <legend class="custom-border">Estado de la Beca</legend>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-5">
                                    <label class="form-control-static">Realización de Estudio</label>
                                </div>
                                <div class="col-md-1">
                                    <input type="radio" name="estado" class="form-control" value="estudio" ng-click="activarEstudio()" ng-required ="true" ng-model="estado">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-5">
                                    <label class="form-control-static">Servicio Contractual</label>
                                </div>
                                <div class="col-md-1">
                                    <input type="radio" name="estado" class="form-control" value="servicio" ng-click="activarContractual()" ng-required ="true" ng-model="estado">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-5">
                                    <label class="form-control-static">Gestión de Compromiso Contractual</label>
                                </div>
                                <div class="col-md-1">
                                    <input type="radio" name="estado" class="form-control" value="compromiso" ng-click="activarCompromiso()" ng-required ="true" ng-model="estado">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-5">
                                    <label class="form-control-static">Gestión de Liberación</label>
                                </div>
                                <div class="col-md-1">
                                    <input type="radio" name="estado" class="form-control" value="liberacion" ng-click="activarLiberacion()" ng-required ="true" ng-model="estado">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-5">
                                    <label class="form-control-static">Beca Finalizada</label>
                                </div>
                                <div class="col-md-1">
                                    <input type="radio" name="estado" class="form-control" value="becaFinalizada" ng-click="activarBecaFinalizada()" ng-required ="true" ng-model="estado">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-5">
                                    <label class="form-control-static">Reintegro de Beca</label>
                                </div>
                                <div class="col-md-1">
                                    <input type="radio" name="estado" class="form-control" value="reintegro" ng-click="activarEstudio()" ng-required ="true" ng-model="estado">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-5">
                                    <label class="form-control-static">Finalizada por Reintegro de Beca</label>
                                </div>
                                <div class="col-md-1">
                                    <input type="radio" name="estado" class="form-control" value="finReintegro" ng-click="activarFinReintegro()" ng-required ="true" ng-model="estado">
                                </div>
                            </div>
                            <div class="row text-center">
                                <span class="text-danger" ng-show="agregarBecario.estado.$error.required">Seleccione el estado de la beca.</span><br>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-md-3"></div>
                </div>                    

                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                        <fieldset class="custom-border">
                            <legend class="custom-border">Adjuntar Documentos</legend>
                            <div class="row">
                                <div class="col-md-7">
                                    <label>Acuerdo de Permiso de Gestion de Beca:</label><br>
                                </div>
                                <div class="col-md-5">
                                    <input type="file" name="permisoGestion" accept="application/pdf" ng-model="permisoGestion" valid-file ng-required="true">
                                    <span class="text-danger" ng-show="agregarBecario.permisoGestion.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-7">
                                    <label>Acuerdo de Autorización inicial:</label><br>
                                </div>
                                <div class="col-md-5">
                                    <input type="file" name="autorizacionInicial" accept="application/pdf" ng-model="autorizacionInicial" valid-file ng-required="true">
                                    <span class="text-danger" ng-show="agregarBecario.autorizacionInicial.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-7">
                                    <label>Dictamen de Propuesta ante Junta Directiva:</label><br>
                                </div>
                                <div class="col-md-5">
                                    <input type="file" name="dictamen" accept="application/pdf" ng-model="dictamen" valid-file ng-required="true">
                                    <span class="text-danger" ng-show="agregarBecario.dictamen.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-7">
                                    <label>Acuerdo de Permiso de Beca de Junta Directiva</label><br>
                                </div>
                                <div class="col-md-5">
                                    <input type="file" name="acuerdoBecaJD" accept="application/pdf" ng-model="acuerdoBecaJD" valid-file ng-required="true">
                                    <span class="text-danger" ng-show="agregarBecario.acuerdoBecaJD.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                </div>
                            </div>                                                                
                            <div class="row">
                                <div class="col-md-7">
                                    <label>Acuerdo de Otorgamiento de Beca:</label><br>
                                </div>
                                <div class="col-md-5">
                                    <input type="file" name="acuerdoBecaCNB" accept="application/pdf" ng-model="acuerdoBecaCNB" valid-file ng-required="true">
                                    <span class="text-danger" ng-show="agregarBecario.acuerdoBecaCNB.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-7">
                                    <label>Acuerdo de Permiso de Beca (CSU):</label><br>
                                </div>
                                <div class="col-md-5">
                                    <input type="file" name="acuerdoBecaCSU" accept="application/pdf" ng-model="acuerdoBecaCSU" valid-file ng-required="true">
                                    <span class="text-danger" ng-show="agregarBecario.acuerdoBecaCSU.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                </div>
                            </div>                                
                            <div class="row">
                                <div class="col-md-7">
                                    <label>Contrato de Beca:</label><br>
                                </div>
                                <div class="col-md-5">
                                    <input type="file" name="contrato" accept="application/pdf" ng-model="contrato" valid-file ng-required="true">
                                    <span class="text-danger" ng-show="agregarBecario.contrato.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                </div>
                            </div>

                            <!--Anexos-->
                            <div class="row">
                                <div class="row text-right">
                                    <div class="col-md-10">
                                        <a ng-click="agregar()" ng-show="verAgregar">Agregar Otro Documento</a><br><br>
                                    </div>
                                    <div class="col-md-2"></div>                    
                                </div>

                                <div class="row text-left" ng-repeat="x in anexos">
                                    <div class="col-md-1"></div>  
                                    <div class="col-md-2">
                                        <label>Tipo de Documento: </label><br>
                                    </div>
                                    <div class="col-md-4">
                                        <select  name="{{x.tipo}}" class="form-control" ng-required="true">
                                            <option ng-repeat="option in tipos" value="{{option.id}}">{{option.tipoDocumento}}</option>
                                        </select>
                                        <span class="text-danger" ng-show="!agregarBecario.$pristine && agregarBecario.{{x.tipo}}.$error.required">Debe de Seleccionar un Tipo de Documento.</span><br><br>
                                    </div>
                                    <div class="col-md-3">
                                        <input type="file" name="{{x.nombre}}" accept="application/pdf" ng-model="docAnexo" valid-file ng-required="true"><br>
                                        <span class="text-danger" ng-show="agregarBecario.{{x.nombre}}.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                    </div>
                                    <div class="col-md-1">
                                        <a class="btn btn-danger" ng-click="eliminar(item)">Eliminar</a><br>
                                    </div>
                                    <div class="col-md-1"></div>  
                                </div>   
                            </div>

                            <!--Documentos de Inicio de Servicio Contractual-->
                            <div ng-show="verContractual">
                                <fieldset class="custom-border">
                                    <legend class="custom-border">Documentos de Finalización de Estudios</legend>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Titulo Obtenido:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="tituloObtenido" accept="application/pdf" ng-model="tituloObtenido" valid-file ng-required="verContractual">
                                            <span class="text-danger" ng-show="agregarBecario.tituloObtenido.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Certificación De Notas:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="certificacionNotasFin" accept="application/pdf" ng-model="certificacionNotasFin" valid-file ng-required="verContractual">
                                            <span class="text-danger" ng-show="agregarBecario.certificacionNotasFin.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Acta De Evaluación De Tesis:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="actaEvaluacion" accept="application/pdf" ng-model="actaEvaluacion" valid-file ng-required="verContractual">
                                            <span class="text-danger" ng-show="agregarBecario.actaEvaluacion.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Constancia de Egresado:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="constanciaEgresado" accept="application/pdf" ng-model="constanciaEgresado" valid-file ng-required="verContractual">
                                            <span class="text-danger" ng-show="agregarBecario.constanciaEgresado.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Acta De Toma De Posesión:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="tomaPosesion" accept="application/pdf" ng-model="tomaPosesion" valid-file ng-required="verContractual">
                                            <span class="text-danger" ng-show="agregarBecario.tomaPosesion.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Proyecto en que Apoyara:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="proyecto" accept="application/pdf" ng-model="proyecto" valid-file ng-required="verContractual">
                                            <span class="text-danger" ng-show="agregarBecario.proyecto.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>

                            <!--Documentos de Gestión de Compromiso Contractual -->
                            <div ng-show="verCompromiso">
                                <fieldset class="custom-border">
                                    <legend class="custom-border">Documentos de Gestión de Compromiso Contractual </legend>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Carta De Oficina De RRHH que cumplió con el tiempo acordado:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="cartaRRHH" accept="application/pdf" ng-model="cartaRRHH" valid-file ng-required="verCompromiso">
                                            <span class="text-danger" ng-show="agregarBecario.cartaRRHH.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>                                        
                                </fieldset>
                            </div>

                            <!--Documentos de Gestión de Liberación -->
                            <div ng-show="verLiberacion">
                                <fieldset class="custom-border">
                                    <legend class="custom-border">Documentos de Gestión de Liberación </legend>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Acuerdo de Gestión de Compromiso Contractual:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="acuerdoGestionContractual" accept="application/pdf" ng-model="acuerdoGestionContractual" valid-file ng-required="verLiberacion">
                                            <span class="text-danger" ng-show="agregarBecario.acuerdoGestionContractual.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>                                        
                                </fieldset>
                            </div>

                            <!--Documentos de Beca Finalizada por Reintegro -->
                            <div ng-show="verFinReintegro">
                                <fieldset class="custom-border">
                                    <legend class="custom-border">Documentos de Finalización de Beca por Reintegro</legend>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Acta de Reintegro de Beca:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="actaReintegro" accept="application/pdf" ng-model="actaReintegro" valid-file ng-required="verFinReintegro">
                                            <span class="text-danger" ng-show="agregarBecario.actaReintegro.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Acuerdo de Gestión de Liberación:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="acuerdoGestionLiberacion2" accept="application/pdf" ng-model="acuerdoGestionLiberacion" valid-file ng-required="verFinReintegro">
                                            <span class="text-danger" ng-show="agregarBecario.acuerdoGestionLiberacion2.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Acuerdo de Liberacion del Compromiso Contractual:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="acuerdoLiberacion2" accept="application/pdf" ng-model="acuerdoLiberacion" valid-file ng-required="verFinReintegro">
                                            <span class="text-danger" ng-show="agregarBecario.acuerdoLiberacion2.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>

                            <!--Documentos de Beca Finalizada -->
                            <div ng-show="verBecaFinalizada">
                                <fieldset class="custom-border">
                                    <legend class="custom-border">Documentos de Finalización de Beca </legend>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Acuerdo de Gestión de Liberación:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="acuerdoGestionLiberacion" accept="application/pdf" ng-model="acuerdoGestionLiberacion" valid-file ng-required="verBecaFinalizada">
                                            <span class="text-danger" ng-show="agregarBecario.acuerdoGestionLiberacion.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <label>Acuerdo de Liberacion del Compromiso Contractual:</label><br>
                                        </div>
                                        <div class="col-md-5">
                                            <input type="file" name="acuerdoLiberacion" accept="application/pdf" ng-model="acuerdoLiberacion" valid-file ng-required="verBecaFinalizada"><br>
                                            <span class="text-danger" ng-show="agregarBecario.acuerdoLiberacion.$invalid">Debe ingresar un documento en formato PDF.</span><br><br>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>


                        </fieldset>
                    </div>
                    <div class="col-md-1"></div>
                </div>

                <div class="row text-center">
                    <input type="hidden" name="ID_USUARIO" value="<%=ID_USUARIO%>">
                    <input type="submit" name="guardar" value="Guardar" class="btn btn-success" ng-disabled="!agregarBecario.$valid">
                </div>
            </fieldset>
        </div>
        <div class="col-md-1"></div>   
    </form>
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

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/angular.min.js"></script>
<script src="js/agregarBeca.js"></script>
<script src="js/scripts.js"></script>
<script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
<script type="text/javascript">
                        $(function () {
                        $('.input-group.date').datepicker({
                        format: 'yyyy-mm-dd',
                                calendarWeeks: true,
                                todayHighlight: true,
                                autoclose: true,
                        });
                        $('#institucionEstudio').on('change', function () {
                        //  $('#tipoBeca option[value="EXTERNA"]').prop('selected', true);
                        var selectPais = document.getElementById("#pais");
                        var selected2 = $("#pais").find("option:selected").text();
                        var univ = "universidad de el salvador";
                        var selected = $(this).find("option:selected").val();
                        if (selected.toUpperCase() === univ.toUpperCase()) {
                        document.getElementById('tipoBeca').value = "INTERNA";
                        //alert("equal");
                        } else {
                        document.getElementById('tipoBeca').value = "EXTERNA";
                        }
                        });
                        });
</script>
</body>
</html>

<%-- 
    Document   : 321_Modificar_Solicitud_Beca
    Created on : 15/01/2017, 11:26:18 AM
    Author     : adminPC
--%>
<%@page import="POJO.Referencias"%>
<%@page import="DAO.ReferenciasDAO"%>
<%@page import="POJO.ProgramaEstudio"%>
<%@page import="DAO.ProgramaEstudioDAO"%>
<%@page import="POJO.SolicitudDeBeca"%>
<%@page import="DAO.SolocitudBecaDAO"%>
<%@page import="POJO.Idioma"%>
<%@page import="DAO.IdiomaDAO"%>
<%@page import="POJO.Investigaciones"%>
<%@page import="DAO.InvestigacionesDAO"%>
<%@page import="POJO.Asociaciones"%>
<%@page import="DAO.AsociacionesDAO"%>
<%@page import="DAO.EducacionDao"%>
<%@page import="POJO.Educacion"%>
<%@page import="POJO.Cargo"%>
<%@page import="DAO.CargoDAO"%>
<%@page import="POJO.DetalleUsuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="POJO.Expediente"%>
<%@page import="DAO.ExpedienteDAO"%>
<%@page import="POJO.Facultad"%>
<%@page import="DAO.DetalleUsuarioDAO"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="POJO.Municipio"%>
<%@page import="DAO.MunicipioDAO"%>
<%@page import="POJO.Departamento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.DepartamentoDAO"%>
<%@page import="POJO.Usuario"%>
<%@page import="DAO.UsuarioDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.ConexionBD"%>
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

    boolean expedienteAbierto = false;
    try {
        // Comprobando si tiene un proceso de beca abierto
        ExpedienteDAO expDao = new ExpedienteDAO();
        expedienteAbierto = expDao.expedienteAbierto(user);
    } catch (Exception e) {
        e.printStackTrace();
    }
    //Si no ha iniciado un proceso de beca lo reenvia a la pagina de las ofertas
    if (expedienteAbierto == false) {
        response.sendRedirect("301_inf_publica_ofertas_beca.jsp");
        return;
    }
    //obtener el expediente
    ExpedienteDAO expDao = new ExpedienteDAO();
    Expediente expediente = expDao.obtenerExpedienteAbierto(user);

    //Obtener usuario completo
    String nombreOferta = "";
    String nombreInstitucion = "";
    int duracion = 0;
    int idFacultad = 0;
    Facultad facultad = new Facultad();
    String pais = "";
    String tipoBeca = "";
    ArrayList<Departamento> departamentos = new ArrayList<Departamento>();
    ArrayList<Municipio> municipios = new ArrayList<Municipio>();
    String departamentosJSON = "";
    String municipiosJSON = "";
    DetalleUsuarioDAO detDao = new DetalleUsuarioDAO();
    DepartamentoDAO depDao = new DepartamentoDAO();
    UsuarioDAO usDao = new UsuarioDAO();
    EducacionDao eduDao = new EducacionDao();
    AsociacionesDAO asoDao = new AsociacionesDAO();
    InvestigacionesDAO invDao = new InvestigacionesDAO();
    IdiomaDAO idiomaDao = new IdiomaDAO();
    CargoDAO cargoDao = new CargoDAO();
    SolocitudBecaDAO solicitudDao = new SolocitudBecaDAO();
    ProgramaEstudioDAO programaDao = new ProgramaEstudioDAO();
    ReferenciasDAO referenciaDao = new ReferenciasDAO();
    try {
        Usuario usuario = usDao.consultarPorNombreUsuario(user);
        //Obteniendo su facultad        
        idFacultad = detDao.obtenerFacultad(user);
        FacultadDAO facDao = new FacultadDAO();
        facultad = facDao.consultarPorId(idFacultad);

        //Obteniendo oferta solicitada
        ConexionBD conexionBD = new ConexionBD();
        String consultaSql = "SELECT NOMBRE_OFERTA,NOMBRE_INSTITUCION,DURACION,PAIS,TIPO_OFERTA_BECA FROM EXPEDIENTE EX JOIN SOLICITUD_DE_BECA SB ON EX.ID_EXPEDIENTE = SB.ID_EXPEDIENTE JOIN OFERTA_BECA OF ON OF.ID_OFERTA_BECA = SB.ID_OFERTA_BECA JOIN INSTITUCION I ON I.ID_INSTITUCION = OF.ID_INSTITUCION_ESTUDIO JOIN USUARIO US ON US.ID_USUARIO = SB.ID_USUARIO WHERE US.NOMBRE_USUARIO = '" + user + "'";
        ResultSet rs = conexionBD.consultaSql(consultaSql);
        while (rs.next()) {
            nombreOferta = rs.getString("NOMBRE_OFERTA");
            nombreInstitucion = rs.getString("NOMBRE_INSTITUCION");
            duracion = rs.getInt("DURACION");
            pais = rs.getString("PAIS");
            tipoBeca = rs.getString("TIPO_OFERTA_BECA");
        }
        conexionBD.cerrarConexion();

        departamentos = depDao.consultarTodos();
        MunicipioDAO munDao = new MunicipioDAO();
        municipios = munDao.consultarTodos();
        Gson gson = new Gson();
        String departamentosJSON1 = gson.toJson(departamentos);
        departamentosJSON = departamentosJSON1.replace("\"", "'");
        String municipiosJSON1 = gson.toJson(municipios);
        municipiosJSON = municipiosJSON1.replace("\"", "'");
    } catch (Exception e) {
        e.printStackTrace();
    }

    //Obteniendo Datos registrados
    DetalleUsuario detalle = detDao.consultarPorUser(user);

    int idDepartamento = 0;
    int idDepartamentoD = 0;
    idDepartamento = depDao.consultarPorIdMunicipio(detalle.getIdMunicipioNacimiento());
    idDepartamentoD = depDao.consultarPorIdMunicipio(detalle.getIdMunicipio());
    ArrayList<Educacion> educacion = new ArrayList<Educacion>();
    educacion = eduDao.consultarPorIdDetalle(detalle.getIdDetalleUsuario());
    ArrayList<Investigaciones> investigacion = new ArrayList<Investigaciones>();
    investigacion = invDao.consultarPorIdDetalle(detalle.getIdDetalleUsuario());
    ArrayList<Idioma> idioma = new ArrayList<Idioma>();
    idioma = idiomaDao.consultarPorIdDetalle(detalle.getIdDetalleUsuario());
    ArrayList<Asociaciones> asociacion = new ArrayList<Asociaciones>();
    asociacion = asoDao.consultarPorIdDetalle(detalle.getIdDetalleUsuario());
    ArrayList<Cargo> cargo = new ArrayList<Cargo>();
    cargo = cargoDao.consultarPorIdDetalle(detalle.getIdDetalleUsuario());
    SolicitudDeBeca solicitud = new SolicitudDeBeca();
    solicitud = solicitudDao.consultarPorIdExpediente(expediente.getIdExpediente());
    ArrayList<ProgramaEstudio> programa = new ArrayList<ProgramaEstudio>();
    programa = programaDao.consultarPorIdSolicitud(solicitud.getIdSolicitud());
    ArrayList<Referencias> referencia = new ArrayList<Referencias>();
    referencia = referenciaDao.consultarPorIdSolicitud(solicitud.getIdSolicitud());
    
    boolean listaMunicipiosActivar = true;
    boolean listaMunicipiosDomActivar = true;
    CargoDAO carDao = new CargoDAO();
    Cargo cargoActual = carDao.obtenerCargoActual(user);

    if (idDepartamento != 0) {
        //Activar
        listaMunicipiosActivar = false;
    }

    if (idDepartamentoD != 0) {
        //Activar
        listaMunicipiosDomActivar = false;
    }

    String educaciones = "[";
    String auxTipoEdu = "[";
    String auxGradoEdu = "[";
    String auxInstitucionEdu = "[";
    String auxAnyoEdu = "[";
    for (int i = 0; i < educacion.size(); i++) {
        int n = i + 1;
        educaciones = educaciones + "{id:" + n + ", tipo: 'tipoEducacion" + n + "', grado:'grado" + n + "', institucion: 'institucion" + n + "', anyo: 'anyo" + n + "'}";
        auxTipoEdu = auxTipoEdu + "'" + educacion.get(i).getTipoEducacion() + "'";
        auxGradoEdu = auxGradoEdu + "'" + educacion.get(i).getGradoAlcanzado() + "'";
        auxInstitucionEdu = auxInstitucionEdu + "'" + educacion.get(i).getNombreInstitucion() + "'";
        auxAnyoEdu = auxAnyoEdu + "" + educacion.get(i).getAnio();
        if (i != educacion.size() - 1) {
            educaciones = educaciones + ",";
            auxTipoEdu = auxTipoEdu + ",";
            auxGradoEdu = auxGradoEdu + ",";
            auxInstitucionEdu = auxInstitucionEdu + ",";
            auxAnyoEdu = auxAnyoEdu + ",";
        }
    }
    educaciones = educaciones + "]";
    auxTipoEdu = auxTipoEdu + "]";
    auxGradoEdu = auxGradoEdu + "]";
    auxInstitucionEdu = auxInstitucionEdu + "]";
    auxAnyoEdu = auxAnyoEdu + "]";
    
    
    String proyectos = "[";
    String auxTituloProy = "[";
    String auxPublicado = "[";

    for (int i = 0; i < investigacion.size(); i++) {
        int n = i + 1;
        proyectos = proyectos + "{id:" + n + ", titulo: 'tituloProyecto" + n + "', publicado:'publicado" +  n + "'}";
        auxTituloProy = auxTituloProy + "'" + investigacion.get(i).getTituloInvestigacion()+ "'";
        auxPublicado = auxPublicado + "" + investigacion.get(i).getPublicado()+ "";
        if (i != investigacion.size() - 1) {
            proyectos = proyectos + ",";
            auxTituloProy = auxTituloProy + ",";
            auxPublicado = auxPublicado + ",";
        }
    }
    proyectos = proyectos + "]";
    auxTituloProy = auxTituloProy + "]";
    auxPublicado = auxPublicado + "]";
    boolean checkProyecto =false;
    if(investigacion.size() == 0){
        checkProyecto = !false;
        proyectos = "[{id: 1, titulo: 'tituloProyecto1', publicado:'publicado1'}]";
    }else{        
        checkProyecto =false;
    }        
     
    
    
    String idiomas = "[";
    String auxIdioma = "[";
    String auxNivelHabla = "[";
    String auxNivelEscritura = "[";
    String auxNivelLectura = "[";
    for (int i = 0; i < idioma.size(); i++) {
        int n = i + 1;
        idiomas = idiomas + "{id:" + n + ", idioma: 'idioma" + n + "', nivelHabla: 'nivelHabla" + n + "', nivelEscritura: 'nivelEscritura" + n + "', nivelLectura: 'nivelLectura" + n + "'}";
        auxIdioma = auxIdioma + "'" + idioma.get(i).getIdioma()+ "'";
        auxNivelHabla = auxNivelHabla + "'" + idioma.get(i).getNivelHabla()+ "'";
        auxNivelEscritura = auxNivelEscritura + "'" + idioma.get(i).getNivelEscrito()+ "'";
        auxNivelLectura = auxNivelLectura + "'" + idioma.get(i).getNivelLectura()+ "'";
        if (i != idioma.size() - 1) {
            idiomas = idiomas + ",";
            auxIdioma = auxIdioma + ",";
            auxNivelHabla = auxNivelHabla + ",";
            auxNivelEscritura = auxNivelEscritura + ",";
            auxNivelLectura = auxNivelLectura + ",";
        }
    }
    idiomas = idiomas + "]";
    auxIdioma = auxIdioma + "]";
    auxNivelHabla = auxNivelHabla + "]";
    auxNivelEscritura = auxNivelEscritura + "]";
    auxNivelLectura = auxNivelLectura + "]";
    
    
    String asociaciones = "[";
    String auxAsociacion = "[";    
    for (int i = 0; i < asociacion.size(); i++) {
        int n = i + 1;
        asociaciones = asociaciones + "{id:" + n + ", asociacion: 'asociacion" + n + "'}";
        auxAsociacion = auxAsociacion + "'" + asociacion.get(i).getNombreAsociacion() + "'";        
        if (i != asociacion.size() - 1) {
            asociaciones = asociaciones + ",";
            auxAsociacion = auxAsociacion + ",";            
        }
    }
    asociaciones = asociaciones + "]";
    auxAsociacion = auxAsociacion + "]";
    boolean checkAsociacion = false;
    if(asociacion.size() == 0){
        checkAsociacion = !false;
        asociaciones = "[{id: 1, asociacion: 'asociacion1'}]";
    }else{        
        checkAsociacion =false;
    } 
    
    
    String cargos = "[";
    String auxLugar = "[";
    String auxCargo = "[";
    String auxFechaInicio = "[";
    String auxFechaFin = "[";
    String auxResponsabilidades = "[";
    for (int i = 0; i < cargo.size(); i++) {
        int n = i + 1;
        cargos = cargos + "{id:" + n + ", lugar: 'lugarCargo" + n + "', cargo:'cargoAnterior" + n + "', fechaInicio: 'fechaInicioCargo" + n + "', fechaFin:'fechaFinCargo" + n + "', responsabilidades: 'responsabilidad" + n + "'}";
        auxLugar = auxLugar + "'" + cargo.get(i).getLugar()+ "'";
        auxCargo = auxCargo + "'" + cargo.get(i).getNombreCargo()+ "'";
        auxFechaInicio = auxFechaInicio + "'" + cargo.get(i).getFechaInicio()+ "'";
        auxFechaFin = auxFechaFin + "'" + cargo.get(i).getFechaFin() + "'";
        auxResponsabilidades = auxResponsabilidades + "'" + cargo.get(i).getResponsabilidades() + "'";
        if (i != cargo.size() - 1) {
            cargos = cargos + ",";
            auxLugar = auxLugar + ",";
            auxCargo = auxCargo + ",";
            auxFechaInicio = auxFechaInicio + ",";
            auxFechaFin = auxFechaFin + ",";
            auxResponsabilidades = auxResponsabilidades + ",";
        }
    }
    cargos = cargos + "]";
    auxLugar = auxLugar + "]";
    auxCargo = auxCargo + "]";
    auxFechaInicio = auxFechaInicio + "]";
    auxFechaFin = auxFechaFin + "]";
    auxResponsabilidades = auxResponsabilidades + "]";
    
    
    String programas = "[";
    String auxSemestre = "[";
    String auxPrograma = "[";
    
    for (int i = 0; i < programa.size(); i++) {
        int n = i + 1;
        programas = programas + "{semestre: 'semestre" + n + "', programa:'programa" + n + "'}";
        auxSemestre = auxSemestre + "" + programa.get(i).getSemestre()+ "";
        auxPrograma = auxPrograma + "'" + programa.get(i).getProgramaEstudio()+ "'";
        
        if (i != programa.size() - 1) {
            programas = programas + ",";
            auxSemestre = auxSemestre + ",";
            auxPrograma = auxPrograma + ",";            
        }
    }
    programas = programas + "]";
    auxSemestre = auxSemestre + "]";
    auxPrograma = auxPrograma + "]";
    
    Referencias ref1 = referencia.get(0);
    Referencias ref2 = referencia.get(1);
    Referencias ref3 = referencia.get(2);
    int idDepartamentoR1 = 0;
    int idDepartamentoR2 = 0;
    int idDepartamentoR3 = 0;
    idDepartamentoR1 = depDao.consultarPorIdMunicipio(ref1.getIdMunicipio());
    idDepartamentoR2 = depDao.consultarPorIdMunicipio(ref2.getIdMunicipio());
    idDepartamentoR3 = depDao.consultarPorIdMunicipio(ref3.getIdMunicipio());
    
    boolean listaMunicipiosR1activar = true;   
    if (idDepartamentoR1 != 0) {
        //Activar
        listaMunicipiosR1activar = false;
    }
    boolean listaMunicipiosR2activar = true;   
    if (idDepartamentoR2 != 0) {
        //Activar
        listaMunicipiosR2activar = false;
    }
    boolean listaMunicipiosR3activar = true;   
    if (idDepartamentoR3 != 0) {
        //Activar
        listaMunicipiosR3activar = false;
    }

%>
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
            <h3 class="text-center text-danger" >
                Universidad De El Salvador
            </h3>
        </div>
        <div class="col-md-8">
            <div class="col-xs-12" style="height:50px;"></div>
            <h2 class="text-center text-danger" style="text-shadow:3px 3px 3px #666;">
                Consejo de Becas y de Investigaciones Científicas <br> Universidad de El Salvador
            </h2>
            <h3 class="text-center text-danger" style="text-shadow:3px 3px 3px #666;">
                Sistema informático para la administración de becas de postgrado
            </h3>
        </div>
    </div>

    <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>


    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>
    </head>


    <body ng-app = "solicitudbecaApp" ng-controller="solicitudCtrl" ng-init="departamentos =<%=departamentosJSON%>; municipios =<%=municipiosJSON%>; facultad = '<%=facultad.getFacultad()%>'; user = '<%=user%>'; nombreOferta = '<%=nombreOferta%>'; nombreInstitucion = '<%=nombreInstitucion%>'; duracion = '<%=duracion%>'; pais = '<%=pais%>'; tipoBeca = '<%=tipoBeca%>'; data.nombre = '<%=detalle.getNombre1Du()%>'; data.nombre2 = '<%=detalle.getNombre2Du()%>'; data.apellido1 = '<%=detalle.getApellido1Du()%>'; data.apellido2 = '<%=detalle.getApellido2Du()%>'; data.municipio_nacimiento = '<%=detalle.getIdMunicipioNacimiento()%>'; data.departamento_nacimiento = '<%=idDepartamento%>'; data.fecha_nacimiento = '<%=detalle.getFechaNacimiento()%>'; data.genero = '<%=detalle.getGenero()%>'; activarMunicipios =<%=listaMunicipiosActivar%>; data.direccion = '<%=detalle.getDireccion()%>'; data.municipio_direccion = '<%=detalle.getIdMunicipio()%>'; data.departamento_direccion = '<%=idDepartamentoD%>'; activarMunicipiosDomicilio =<%=listaMunicipiosDomActivar%>; data.tel_casa = '<%=detalle.getTelefonoCasa()%>'; data.tel_movil = '<%=detalle.getTelefonoMovil()%>'; data.tel_oficina = '<%=detalle.getTelefonoOficina()%>'; data.profesion = '<%=detalle.getProfesion()%>'; data.unidad = '<%=detalle.getDepartamento()%>'; data.cargo = '<%=cargoActual.getNombreCargo()%>'; data.fecha_contratacion = '<%=detalle.getFechaContratacion()%>'; data.educacion = <%=educaciones%>; aux.auxTipoEdu = <%=auxTipoEdu%>; aux.auxGradoEdu =<%=auxGradoEdu%>; aux.auxInstitucionEdu =<%=auxInstitucionEdu%>; aux.auxAnyoEdu =<%=auxAnyoEdu%>; data.proyectos = <%=proyectos%>; aux.auxTituloProy =<%=auxTituloProy%>; aux.auxPublicado =<%=auxPublicado%>; data.idiomas = <%=idiomas%>; aux.auxIdioma =<%=auxIdioma%>; aux.auxNivelEscritura =<%=auxNivelEscritura%>; aux.auxNivelHabla =<%=auxNivelHabla%>; aux.auxNivelLectura =<%=auxNivelLectura%>; data.asociaciones = <%=asociaciones%>; aux.auxAsociacion =<%=auxAsociacion%>; data.cargos = <%=cargos%>; aux.auxLugar =<%=auxLugar%>; aux.auxCargo =<%=auxCargo%>; aux.auxFechaInicio =<%=auxFechaInicio%>; aux.auxFechaFin =<%=auxFechaFin%>; aux.auxResponsabilidades =<%=auxResponsabilidades%>; checkProyecto = <%=checkProyecto%>; Nedu = <%=educacion.size()+1%>; Nproy = <%=investigacion.size()+1%>; Nidi = <%=idioma.size()+1%>; Naso = <%=asociacion.size()+1%>; Ncar = <%=cargo.size()+1%>; data.beneficios = '<%=solicitud.getBeneficios()%>'; checkAsociacion = <%=checkAsociacion%>; data.programas = <%=programas%>; aux.auxSemestre =<%=auxSemestre%>; aux.auxPrograma =<%=auxPrograma%>; Npro = <%=programa.size()+1%>; data.nombre1R1 = '<%=ref1.getNombre1Du()%>'; data.nombre2R1 = '<%=ref1.getNombre2Du()%>'; data.apellido1R1 = '<%=ref1.getApellido1Du()%>'; data.apellido2R1 = '<%=ref1.getApellido2Du()%>'; data.direccionR1 = '<%=ref1.getDomicilio()%>'; data.municipioR1 = '<%=ref1.getIdMunicipio()%>'; data.departamentoR1 = '<%=idDepartamentoR1%>'; data.telefonoR1 = '<%=ref1.getTelefonoMovil()%>'; activarMunicipiosR1 =<%=listaMunicipiosR1activar%>; data.nombre1R2 = '<%=ref2.getNombre1Du()%>'; data.nombre2R2 = '<%=ref2.getNombre2Du()%>'; data.apellido1R2 = '<%=ref2.getApellido1Du()%>'; data.apellido2R2 = '<%=ref2.getApellido2Du()%>'; data.direccionR2 = '<%=ref2.getDomicilio()%>'; data.municipioR2 = '<%=ref2.getIdMunicipio()%>'; data.departamentoR2 = '<%=idDepartamentoR2%>'; data.telefonoR2 = '<%=ref2.getTelefonoMovil()%>'; activarMunicipiosR2 =<%=listaMunicipiosR2activar%>; data.nombre1R3 = '<%=ref3.getNombre1Du()%>'; data.nombre2R3 = '<%=ref3.getNombre2Du()%>'; data.apellido1R3 = '<%=ref3.getApellido1Du()%>'; data.apellido2R3 = '<%=ref3.getApellido2Du()%>'; data.direccionR3 = '<%=ref3.getDomicilio()%>'; data.municipioR3 = '<%=ref3.getIdMunicipio()%>'; data.departamentoR3 = '<%=idDepartamentoR3%>'; data.telefonoR3 = '<%=ref3.getTelefonoMovil()%>'; activarMunicipiosR3 =<%=listaMunicipiosR3activar%>;">

    <div class="container-fluid" ng-init="oferta={nombre:'<%=nombreOferta%>',institucion: '<%=nombreInstitucion%>'}" >
        <h3 class="text-center" style="color:#E42217;">Solicitud de Beca</h3>
        <fieldset class="custom-border">
            <legend class="custom-border">Solicitud de Beca de postgrado</legend>

            <form class="form-horizontal" name="solicitud" action="{{url}}" method="POST" enctype="multipart/form-data" target="{{pestana}}" novalidate>            
                <div class="row" ng-view>            

                </div>
            </form>                
        </fieldset>
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
    <script src="js/scripts.js"></script>
    <script type="text/javascript" src="js/bootstrap-datepicker.min.js"></script>
    <script src="js/angular.min.js"></script>
    <script src="js/angular-route.min.js"></script>
    <script src="js/solicitudbeca.js"></script>
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

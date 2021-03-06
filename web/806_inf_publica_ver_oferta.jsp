<%-- 
    Document   : acercaDe
    Created on : 10-16-2016, 05:09:17 PM
    Author     : MauricioBC
--%>
<%@page import="POJO.Documento"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="POJO.OfertaBeca"%>
<%@page import="DAO.BecaDAO"%>
<%@page import="DAO.InstitucionDAO"%>
<%@page import="DAO.OfertaBecaDAO"%>
<%@page import="POJO.Institucion"%>
<%@page import="DAO.IdiomaDAO"%>
<%@page import="POJO.Idioma"%>
<%@page import="DAO.ConexionBD"%>
<%@page import="POJO.Facultad"%>
<%@page import="DAO.FacultadDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.TipoUsuario"%>
<%@page import="DAO.TipoUsuarioDao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>


<!-- inicio proceso de seguridad de login -->
<%@page import="MODEL.Utilidades"%>
<%@page import="java.util.ArrayList"%>
<%@page import="MODEL.variablesDeSesion"%>
<!-- fin de proceso de seguridad de login -->


<%
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    String idOferta = request.getParameter("ID_OFERTA_BECA");
    String idDoc = request.getParameter("ID_DOC");
    System.out.println(idOferta + " SSSSS");
    ////////////////////////////////////////////////////////
    //////////CONSULTA OFERTA DE BECA
    ConexionBD conexionbd = null;
    ResultSet rs = null;
    OfertaBeca temp = new OfertaBeca();
    Institucion temp2 = new Institucion();
    Institucion temp3 = new Institucion();
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
    try {
        //formando la consulta
        String consultaSql = "";
        consultaSql = "SELECT NOMBRE_OFERTA,IDIOMA,TIPO_OFERTA_BECA,TIPO_ESTUDIO,FECHA_CIERRE,MODALIDAD, "
                + " FECHA_INICIO, DURACION,FINANCIAMIENTO,PERFIL, ID_INSTITUCION_ESTUDIO, ID_INSTITUCION_FINANCIERA "
                + " FROM OFERTA_BECA, INSTITUCION WHERE "
                + " OFERTA_BECA.ID_INSTITUCION_ESTUDIO=INSTITUCION.ID_INSTITUCION "
                + " AND OFERTA_BECA_ACTIVA=1 "
                + "AND ID_OFERTA_BECA=" + idOferta + ";";
        System.out.println(consultaSql);
        //realizando la consulta
        conexionbd = new ConexionBD();
        rs = conexionbd.consultaSql(consultaSql);
        if (rs.next()) {
            temp.setNombreOferta(rs.getString("NOMBRE_OFERTA"));
            temp.setTipoOfertaBeca(rs.getString("TIPO_OFERTA_BECA"));
            temp.setTipoEstudio(rs.getString("TIPO_ESTUDIO"));
            temp.setFechaInicio(rs.getDate("FECHA_INICIO"));
            temp.setDuracion(rs.getInt("DURACION"));
            temp.setFinanciamiento(rs.getString("FINANCIAMIENTO"));
            temp.setModalidad(rs.getString("MODALIDAD"));
            temp.setPerfil(rs.getString("PERFIL"));
            temp.setFechaCierre(rs.getDate("FECHA_CIERRE"));
            temp.setIdInstitucionEstudio(rs.getInt("ID_INSTITUCION_ESTUDIO"));
            temp.setIdInstitucionFinanciera(rs.getInt("ID_INSTITUCION_FINANCIERA"));
            temp.setIdioma(rs.getString("IDIOMA"));
            System.out.println(temp.getNombreOferta());
        }
        //con el rs se llenara la tabla de resultados
    } catch (Exception ex) {
        System.out.println(ex);
    }
    int instEst = temp.getIdInstitucionEstudio();
    int instFin = temp.getIdInstitucionFinanciera();
    String nombreOferta = temp.getNombreOferta();
    String tipoOferta = temp.getTipoOfertaBeca();
    String tipoEstudio = temp.getTipoEstudio();
    int duracion = temp.getDuracion();
    String financiamiento = temp.getFinanciamiento();
    String modalidad = temp.getModalidad();
    String perfil = temp.getPerfil();
    String idioma = temp.getIdioma();
    ////////////////////////////////////////////////////////
    //////////CONSULTA INSTITUCION ESTUDIO
    conexionbd = null;
    rs = null;
    try {
        //formando la consulta
        String consultaSql = "";
        consultaSql = "SELECT NOMBRE_INSTITUCION, PAIS, PAGINA_WEB, EMAIL FROM INSTITUCION WHERE "
                + " ID_INSTITUCION=" + instEst + ";";
        System.out.println(consultaSql);
        //realizando la consulta
        conexionbd = new ConexionBD();
        rs = conexionbd.consultaSql(consultaSql);
        if (rs.next()) {
            temp2.setNombreInstitucion(rs.getString("NOMBRE_INSTITUCION"));
            temp2.setPais(rs.getString("PAIS"));
            temp2.setPaginaWeb(rs.getString("PAGINA_WEB"));
            temp2.setEmail(rs.getString("EMAIL"));
        }
        //con el rs se llenara la tabla de resultados
    } catch (Exception ex) {
        System.out.println(ex);
    }
    String nombreInstEst = temp2.getNombreInstitucion();
    String pais = temp2.getPais();
    String pagina = temp2.getPaginaWeb();
    String email = temp2.getEmail();
    ////////////////////////////////////////////////////////
    //////////CONSULTA INSTITUCION OFERTANTE
    conexionbd = null;
    rs = null;
    try {
        //formando la consulta
        String consultaSql = "";
        consultaSql = "SELECT NOMBRE_INSTITUCION FROM INSTITUCION WHERE "
                + " ID_INSTITUCION=" + instFin + ";";
        System.out.println(consultaSql);
        //realizando la consulta
        conexionbd = new ConexionBD();
        rs = conexionbd.consultaSql(consultaSql);
        if (rs.next()) {
            temp3.setNombreInstitucion(rs.getString("NOMBRE_INSTITUCION"));
        }
        //con el rs se llenara la tabla de resultados
    } catch (Exception ex) {
        System.out.println(ex);
    }
    String nombreInstOfer = temp3.getNombreInstitucion();
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
    
    <jsp:include page="cabecera.jsp"></jsp:include>

<nav class="navbar navbar-custom" role="navigation">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
        </button> <a class="navbar-brand active" href="index.jsp">Inicio</a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

        <ul class="nav navbar-nav">
            <li>
                <a href="documentos.jsp">Documentos</a>                                   
            </li>
            <li>
                <a href="805_inf_publica_oferta_de_beca.jsp">Ofertas de beca</a>                                   
            </li>
        </ul>

        <ul class="nav navbar-nav navbar-right">						

            <li>
                <a href="login.jsp">Iniciar Sesión</a>
            </li>
        </ul>
    </div>

</nav>
</head>
<body>

    <div class="container-fluid">
        <fieldset class="custom-border">
            <legend class="custom-border">Detalle de oferta de Beca</legend>
            <div class="row">
                <div class="col-md-12">
                    <div class="container">
                        <h3 class="text-center" style="color:#E42217;">Información de la Beca</h3>
                        <div class="bootstrap-iso">
                            <form class="form-horizontal">
                                <div class="row no-gutter">
                                    <div class="col-md-12">
                                        <div class="col-md-3">
                                            <input type="text" class="form-control" id="labeltitulo" value="Título del Proyecto:" disabled style="font-weight: bold; background-color:#728FCE; color:white">    
                                        </div>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="titulo" value="<%=nombreOferta%>" disabled>    
                                    </div>
                                </div>
                            </div>   

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelinstofer" value="Institución Ofertante:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="instOferente" value="<%=nombreInstOfer%>" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelinstestu" value="Institución de Estudio:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="instEstudio" value="<%=nombreInstEst%>" disabled>    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelPais" value="País:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="pais" value="<%=pais%>" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelTipoBeca" value="Tipo de Beca:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="tipoBeca" value="<%=tipoOferta%>" disabled>    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelmodalidad" value="Modalidad:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="modalidad" value="<%=modalidad%>" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelDuracion" value="Duración:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="duracion" value='<%=duracion + " meses"%>' disabled>    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelFechainicio" value="Fecha de Inicio:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="fechaInicio" value="<%=df.format(temp.getFechaInicio())%>" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelIdioma" value="Idioma" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="idioma" value="<%=idioma%>" disabled>    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelFinanciamiento" value="Financiamiento:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="financiamiento" value="<%=financiamiento%>" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelPerfil" value="Requisitos Participantes:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="perfil" value="<%=perfil%>" disabled>    
                                    </div>
                                </div>
                            </div>  

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelpagina" value="Página Web:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="pagina" value="<%=pagina%>" disabled>    
                                    </div>
                                </div>
                            </div>  

                            <div class="row no-gutter">
                                <div class="col-md-12">
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelemail" value="Correo Electrónico:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="correo" value="<%=email%>" disabled>    
                                    </div>
                                </div>
                            </div> 

                            <div class="row no-gutter">
                                <div class="col-md-12">                                       
                                    <div class="col-md-3">
                                        <input type="text" class="form-control" id="labelCierre" value="Cierre Convocatoria:" disabled style="font-weight: bold;background-color:#728FCE; color:white">    
                                    </div>
                                    <div class="col-md-9">
                                        <input type="text" class="form-control" id="cierre" value="<%=df.format(temp.getFechaCierre())%>" disabled>    
                                    </div>
                                </div>
                            </div></br> 
                        </form>
                        <div class="row"><center>                                    
                                <form action="DocumentoOferta" method="post"  target="_blank"> 
                                    <input type="hidden" name="id" value="<%=idDoc%>">
                                    <button type="submit" class="btn btn-primary">
                                        <span class="glyphicon glyphicon-cloud-download"></span> 
                                        Descargar prospecto
                                    </button>
                                </form>
                            </center>   
                        </div>
                    </div>          
                </div>
            </div>
        </div> 
</div></fieldset>
</br></br>

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

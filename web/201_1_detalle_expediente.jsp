<%-- 
    Document   : 201_1_detalle_expediente
    Created on : 11-15-2016, 04:22:24 AM
    Author     : Manuel Miranda
--%>

<%@page import="DAO.ObservacionesDAO"%>
<%@page import="POJO.Observaciones"%>
<%@page import="java.util.ArrayList"%>
<%@page import="POJO.Documento"%>
<%@page import="DAO.DocumentoDAO"%>
<%@page import="DAO.OfertaBecaDAO"%>
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
    int idExpediente = 0;
    String nombre = "";
    String facultad = "";
    String estado = "";
    String carnet = "";
    String oferta = "";
    ArrayList<Documento> documentos = new ArrayList<Documento>();
    ArrayList<Observaciones> observaciones = new ArrayList<Observaciones>();

    try {
        OfertaBecaDAO ofertaDao = new OfertaBecaDAO();
        idExpediente = Integer.parseInt(request.getParameter("idExpediente"));
        nombre = request.getParameter("nombre");
        facultad = request.getParameter("facultad");
        estado = request.getParameter("estado");
        carnet = request.getParameter("carnet");
        oferta = ofertaDao.obtenerTituloBeca(idExpediente);
        DocumentoDAO documentoDao = new DocumentoDAO();
        documentos = documentoDao.documentosExpediente(idExpediente);
        ObservacionesDAO observacionDao = new ObservacionesDAO();
        observaciones = observacionDao.consultarPorExpediente(idExpediente);
    } catch (Exception e) {
        e.printStackTrace();
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
        <link href="css/customfieldset.css" rel="stylesheet">
    
        <jsp:include page="cabecera.jsp"></jsp:include>

    <p class="text-right" style="font-weight:bold;">Rol: <%= rol%></p>
    <p class="text-right" style="font-weight:bold;">Usuario: <%= user%></p>

    <%-- todo el menu esta contenido en la siguiente linea
         el menu puede ser cambiado en la pagina menu.jsp --%>
    <jsp:include page="menu_corto.jsp"></jsp:include>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row"><!-- TITULO DE LA PANTALLA -->
                <h3>
                    <p class="text-center" style="color:#cf2a27">Detalle de Expediente</p>
                </h3>
                <br></br> 
            </div><!-- TITULO DE LA PANTALLA -->  

            <!-- CONTENIDO DE LA PANTALLA -->
            <div class="row">
                <fieldset class="custom-border">
                    <legend class="custom-border">Detalles de expediente</legend>
                    <div class="row">
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td>Nombre</td>
                                        <td><%=nombre%></td>
                                    <td>Usuario</td>
                                    <td><%=carnet%></td>
                                </tr>
                                <tr>
                                    <td>Oferta</td>
                                    <td><%=oferta%></td>
                                    <td>Expediente</td>
                                    <td><%=idExpediente%></td>
                                </tr>
                                <tr>
                                    <td>Facultad</td>
                                    <td><%=facultad%></td>
                                    <td>Estado</td>
                                    <td><%=estado%></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-1"></div>
                </div>

                <div class="row">
                    <br>
                    <br>
                </div>

                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                        <fieldset class="custom-border">
                            <legend class="custom-border">Documentos</legend>
                            <table id="Documentos" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>Documento</th>
                                        <th>Estado</th>
                                        <th>Observación</th>
                                        <th>Documento Digital</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% int nu =0;
                                        for (int i = 0; i < documentos.size(); i++) {
                                            nu=nu+1;
                                            out.write("<tr>");
                                            out.write("<td>" + nu + "</td>");
                                            out.write("<td>" + documentos.get(i).getIdTipoDocumento().getTipoDocumento() + "</td>");
                                            out.write("<td>" + documentos.get(i).getEstadoDocumento() + "</td>");
                                            out.write("<td>" + documentos.get(i).getObservacion() + "</td>");
                                            out.write("<td>");
                                            out.write("<form style='display:inline;' action='verDocumentoConsejo' method='post'><input type='hidden' name='id' value='" + documentos.get(i).getIdDocumento() + "'><input type='submit' class='btn btn-success' name='submit' value='Ver Documento'></form> ");
                                            out.write("</td>");
                                            out.write("</tr>");
                                        }%>

                                </tbody>
                            </table>
                        </fieldset>
                    </div>
                    <div class="col-md-1"></div>
                </div>

                <div class="row">
                    <div class="col-md-1"></div>
                    <div class="col-md-10">
                        <fieldset class="custom-border">
                            <legend class="custom-border">Observaciones</legend>
                            <!-- Formularios de ingreso de observacion-->
                            <div class="row">
                                <form action="AgregarObservacionExpedienteServlet" method="post">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-10">
                                        <div class="col-md-2">
                                            <label>Observación:</label>
                                        </div>
                                        <div class="col-md-8">
                                            <textarea name="observacion" class="form-control"></textarea>
                                        </div>
                                        <div class="col-md-2">
                                            <input type="hidden" name="idExpediente" value="<%=idExpediente%>">
                                            <input type="submit" value="Guardar" class="btn btn-success">
                                        </div>
                                    </div>
                                    <div class="col-md-1"></div>
                                </form>
                            </div>
                            <!-- Tabla de observaciones-->
                            <div class="row">
                                <br><br>
                                <table id="Observaciones" class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>Observación</th>
                                            <th>Acción</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                    <% int n =0;
                                        for (int i = 0; i < observaciones.size(); i++) {
                                            n=n+1;
                                            out.write("<tr>");
                                            out.write("<td>" + n + "</td>");
                                            out.write("<td>" + observaciones.get(i).getObservacion() + "</td>");                                            
                                            out.write("<td>");
                                            out.write("<form style='display:inline;' action='EliminarObservacionExpedienteServlet' method='post'><input type='hidden' name='idObservacion' value='" + observaciones.get(i).getIdObservacion() + "'><input type='submit' class='btn btn-danger' name='submit' value='Eliminar'></form> ");
                                            out.write("</td>");
                                            out.write("</tr>");
                                        }%>

                                </tbody>
                                </table>
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-md-1"></div>
                </div>

            </fieldset>


        </div><!-- CONTENIDO DE LA PANTALLA -->
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
    <script src="js/angular.min.js"></script>
    <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#Documentos').DataTable(
                    {
                        "language":
                                {
                                    "sProcessing": "Procesando...",
                                    "sLengthMenu": "Mostrar _MENU_ registros",
                                    "sZeroRecords": "No se encontraron resultados",
                                    "sEmptyTable": "Ningún dato disponible en esta tabla",
                                    "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                                    "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                                    "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                                    "sInfoPostFix": "",
                                    "sSearch": "Buscar:",
                                    "sUrl": "",
                                    "sInfoThousands": ",",
                                    "sLoadingRecords": "Cargando...",
                                    "oPaginate": {
                                        "sFirst": "Primero",
                                        "sLast": "Último",
                                        "sNext": "Siguiente",
                                        "sPrevious": "Anterior"
                                    },
                                    "oAria": {
                                        "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                                        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                                    }
                                }
                    }
            );
        });


    </script>  
        <script type="text/javascript">
        $(document).ready(function () {
            $('#Observaciones').DataTable(
                    {
                        "language":
                                {
                                    "sProcessing": "Procesando...",
                                    "sLengthMenu": "Mostrar _MENU_ registros",
                                    "sZeroRecords": "No se encontraron resultados",
                                    "sEmptyTable": "Ningún dato disponible en esta tabla",
                                    "sInfo": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                                    "sInfoEmpty": "Mostrando registros del 0 al 0 de un total de 0 registros",
                                    "sInfoFiltered": "(filtrado de un total de _MAX_ registros)",
                                    "sInfoPostFix": "",
                                    "sSearch": "Buscar:",
                                    "sUrl": "",
                                    "sInfoThousands": ",",
                                    "sLoadingRecords": "Cargando...",
                                    "oPaginate": {
                                        "sFirst": "Primero",
                                        "sLast": "Último",
                                        "sNext": "Siguiente",
                                        "sPrevious": "Anterior"
                                    },
                                    "oAria": {
                                        "sSortAscending": ": Activar para ordenar la columna de manera ascendente",
                                        "sSortDescending": ": Activar para ordenar la columna de manera descendente"
                                    }
                                }
                    }
            );
        });


    </script> 
</body>
</html>

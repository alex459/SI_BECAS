/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.BecaDAO;
import DAO.DocumentoDAO;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.ExpedienteDAO;
import DAO.OfertaBecaDAO;
import POJO.Expediente;
import POJO.OfertaBeca;
import DAO.InstitucionDAO;
import DAO.SolocitudBecaDAO;
import DAO.TipoDocumentoDAO;
import DAO.UsuarioDAO;
import POJO.Beca;
import POJO.Documento;
import POJO.SolicitudDeBeca;
import POJO.TipoDocumento;
import java.io.InputStream;
import java.util.ArrayList;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "AgregarBecarioServlet", urlPatterns = {"/AgregarBecarioServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class AgregarBecarioServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        //LEER DATOS DEL JSP
        try {
            boolean checkOferta = Boolean.parseBoolean(request.getParameter("checkOferta"));
            String valorcheck = request.getParameter("valorcheck");
            int ID_USUARIO = Integer.parseInt(request.getParameter("ID_USUARIO"));            
            
            String fechaInicioBeca = request.getParameter("fechaInicio");
            String fechaFinBeca = request.getParameter("fechaFin");

            if (ID_USUARIO != 0) {
                //Crear el expediente
                ExpedienteDAO expedienteDao = new ExpedienteDAO();
                int idExpediente = expedienteDao.getSiguienteId();
                Expediente expediente = new Expediente();
                expediente.setIdExpediente(idExpediente);
                expediente.setIdProgreso(9);
                String estadoExpediente = "ABIERTO";
                expediente.setEstadoExpediente(estadoExpediente);
                expediente.setEstadoProgreso("PENDIENTE");
                boolean expedienteCreado = expedienteDao.ingresar(expediente);
                if (expedienteCreado == true) {
                    //Obtener o crear oferta de beca
                    int idOferta = 0;
                    OfertaBeca ofertaBeca = new OfertaBeca();
                    OfertaBecaDAO ofertaDao = new OfertaBecaDAO();
                    if (checkOferta == true) {
                        //Crear la oferta                          
                        InstitucionDAO institucionDAO = new InstitucionDAO();
                        //obtener los datos del jsp
                        String nombreOferta = request.getParameter("nombreOferta");
                        String tipoEstudio = request.getParameter("tipoEstudio");
                        ofertaBeca.setNombreOferta(nombreOferta);
                        ofertaBeca.setTipoEstudio(tipoEstudio);
                        ofertaBeca.setIdInstitucionEstudio(institucionDAO.consultarIdPorNombre(request.getParameter("institucionEstudio")));
                        ofertaBeca.setIdInstitucionFinanciera(institucionDAO.consultarIdPorNombre(request.getParameter("institucionOferente")));
                        String TipoOferta = ofertaDao.ObtenerTipoOfertaBeca(ofertaBeca.getIdInstitucionEstudio());
                        ofertaBeca.setTipoOfertaBeca(TipoOferta);
                        idOferta = ofertaDao.getSiguienteId();
                        ofertaBeca.setIdOfertaBeca(idOferta);
                        boolean checkOfertaIngresada = ofertaDao.ingresarOfertaMigracion(ofertaBeca);
                    } else {
                        //Obtener el id de la oferta
                        idOferta = Integer.parseInt(request.getParameter("oferta"));
                        ofertaBeca = ofertaDao.consultarPorId(idOferta);
                    }

                    //Crear solicitud de Beca
                    if (idOferta != 0) {
                        //Realizar solicitud de Beca
                        SolocitudBecaDAO solDao = new SolocitudBecaDAO();
                        SolicitudDeBeca solicitud = new SolicitudDeBeca();
                        int idSolicitud = solDao.getSiguienteId();
                        Date fechaHoy = new Date();
                        java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
                        solicitud.setIdSolicitud(idSolicitud);
                        solicitud.setIdExpediente(idExpediente);
                        solicitud.setIdUsuario(ID_USUARIO);
                        solicitud.setIdOfertaBeca(idOferta);
                        solicitud.setFechaSolicitud(sqlDate);
                        boolean ingresarSolicitud = solDao.ingresar(solicitud);

                        if (ingresarSolicitud == true) {
                            //Ingresar documentos obligatorios                            
                            //documentos
                            ArrayList<String> documentos = new ArrayList<>();
                            documentos.add("permisoGestion");
                            documentos.add("autorizacionInicial");
                            documentos.add("dictamen");
                            documentos.add("acuerdoBecaJD");
                            documentos.add("acuerdoBecaCNB");
                            documentos.add("acuerdoBecaCSU");
                            documentos.add("contrato");
                            //Id de tipos de documentos
                            ArrayList<Integer> tipos = new ArrayList<>();
                            tipos.add(103);
                            tipos.add(105);
                            tipos.add(112);
                            if (ofertaBeca.getTipoOfertaBeca().equals("INTERNA")) {
                                tipos.add(120);
                            } else {
                                tipos.add(121);
                            }
                            tipos.add(131);
                            if (ofertaBeca.getTipoOfertaBeca().equals("INTERNA")) {
                                tipos.add(132);
                            } else {
                                tipos.add(133);
                            }
                            tipos.add(134);

                            //documentos segun proceso
                            String estado = request.getParameter("estado");
                            int idProgreso = 9;
                            DocumentoDAO documentoDao = new DocumentoDAO();
                            TipoDocumento tipoDocumento = new TipoDocumento();
                            TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
                            switch (estado) {
                                case "estudio":
                                    idProgreso = 9;
                                    break;
                                case "servicio":
                                    idProgreso = 12;
                                    //Agregando documentos del proceso
                                    documentos.add("tituloObtenido");
                                    tipos.add(143);
                                    documentos.add("certificacionNotasFin");
                                    tipos.add(144);
                                    documentos.add("actaEvaluacion");
                                    tipos.add(145);
                                    documentos.add("constanciaEgresado");
                                    tipos.add(146);
                                    documentos.add("tomaPosesion");
                                    tipos.add(147);
                                    documentos.add("proyecto");
                                    tipos.add(148);
                                    break;
                                case "compromiso":
                                    idProgreso = 13;
                                    //Agregando documentos del proceso
                                    documentos.add("tituloObtenido");
                                    tipos.add(143);
                                    documentos.add("certificacionNotasFin");
                                    tipos.add(144);
                                    documentos.add("actaEvaluacion");
                                    tipos.add(145);
                                    documentos.add("constanciaEgresado");
                                    tipos.add(146);
                                    documentos.add("tomaPosesion");
                                    tipos.add(147);
                                    documentos.add("proyecto");
                                    tipos.add(148);
                                    documentos.add("cartaRRHH");
                                    tipos.add(154);
                                    break;
                                case "liberacion":
                                    idProgreso = 14;
                                    //Agregando documentos del proceso
                                    documentos.add("tituloObtenido");
                                    tipos.add(143);
                                    documentos.add("certificacionNotasFin");
                                    tipos.add(144);
                                    documentos.add("actaEvaluacion");
                                    tipos.add(145);
                                    documentos.add("constanciaEgresado");
                                    tipos.add(146);
                                    documentos.add("tomaPosesion");
                                    tipos.add(147);
                                    documentos.add("proyecto");
                                    tipos.add(148);
                                    documentos.add("cartaRRHH");
                                    tipos.add(154);
                                    documentos.add("acuerdoGestionContractual");
                                    tipos.add(155);
                                    break;
                                case "becaFinalizada":
                                    idProgreso = 16;
                                    //Agregando documentos del proceso
                                    documentos.add("tituloObtenido");
                                    tipos.add(143);
                                    documentos.add("certificacionNotasFin");
                                    tipos.add(144);
                                    documentos.add("actaEvaluacion");
                                    tipos.add(145);
                                    documentos.add("constanciaEgresado");
                                    tipos.add(146);
                                    documentos.add("tomaPosesion");
                                    tipos.add(147);
                                    documentos.add("proyecto");
                                    tipos.add(148);
                                    documentos.add("cartaRRHH");
                                    tipos.add(154);
                                    documentos.add("acuerdoGestionContractual");
                                    tipos.add(155);
                                    documentos.add("acuerdoGestionLiberacion");
                                    tipos.add(157);
                                    documentos.add("acuerdoLiberacion");
                                    tipos.add(158);
                                    estadoExpediente = "CERRADO";
                                    break;
                                case "reintegro":
                                    idProgreso = 23;
                                    //Solicitar Reintegro
                                    Documento acuerdoSolicitar = new Documento();
                                    String obs = "LA BECA HA EXPIRADO";
                                    tipoDocumento = tipoDao.consultarPorId(159);
                                    int idDoc = documentoDao.getSiguienteId();
                                    Date fechaActual = new Date();
                                    java.sql.Date hoy = new java.sql.Date(fechaActual.getTime());
                                    int idActa = documentoDao.ExisteDocumento(idExpediente, 159);
                                    if (idActa == 0) {
                                        acuerdoSolicitar.setIdDocumento(idDoc);
                                        acuerdoSolicitar.setIdExpediente(expediente);
                                        acuerdoSolicitar.setFechaSolicitud(hoy);
                                        acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                        acuerdoSolicitar.setObservacion(obs);
                                        acuerdoSolicitar.setIdTipoDocumento(tipoDocumento);
                                        documentoDao.solicitarDocumento(acuerdoSolicitar);
                                    } else {
                                        acuerdoSolicitar = documentoDao.obtenerInformacionDocumentoPorId(idActa);
                                        acuerdoSolicitar.setFechaSolicitud(sqlDate);
                                        acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                        acuerdoSolicitar.setObservacion(obs);
                                        documentoDao.ActualizarResolverCorreccion(acuerdoSolicitar);
                                    }

                                    break;
                                case "finReintegro":
                                    idProgreso = 16;
                                    documentos.add("actaReintegro");
                                    tipos.add(159);
                                    documentos.add("acuerdoGestionLiberacion2");
                                    tipos.add(157);
                                    documentos.add("acuerdoLiberacion2");
                                    tipos.add(158);
                                    estadoExpediente = "CERRADO";
                                    break;
                            }
                            //Recuperando datos del formulario                        
                            InputStream documentoAdjunto = null;
                            String obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";                            
                            //Ingresando documentos al Expediente                                                        
                            for (int i = 0; i < documentos.size(); i++) {
                                Documento anexo = new Documento();
                                //Comparando si exite documento
                                Integer idTipo = tipos.get(i);
                                Integer idDocumento = documentoDao.ExisteDocumento(idExpediente, idTipo);
                                Part filePart = null;
                                filePart = request.getPart(documentos.get(i));
                                if (filePart != null) {
                                    documentoAdjunto = filePart.getInputStream();
                                }

                                if (idDocumento == 0) {
                                    //Ingresar Documento
                                    idDocumento = documentoDao.getSiguienteId();
                                    tipoDocumento = tipoDao.consultarPorId(idTipo);
                                    anexo.setIdDocumento(idDocumento);
                                    anexo.setIdTipoDocumento(tipoDocumento);
                                    anexo.setIdExpediente(expediente);
                                    anexo.setDocumentoDigital(documentoAdjunto);
                                    anexo.setObservacion(obs);
                                    anexo.setEstadoDocumento("APROBADO");
                                    documentoDao.Ingresar(anexo);
                                } else {
                                    //Actualizar Documento
                                    anexo = documentoDao.ObtenerPorId(idDocumento);
                                    anexo.setDocumentoDigital(documentoAdjunto);
                                    documentoDao.ActualizarDocumentoObservacion(anexo);
                                }
                            }

                            //Crear Beca
                            java.sql.Date fechaInicio = new java.sql.Date(StringAFecha(fechaInicioBeca).getTime());
                            java.sql.Date fechaFin = new java.sql.Date(StringAFecha(fechaFinBeca).getTime());
                            BecaDAO becaDao = new BecaDAO();
                            Beca beca = new Beca();
                            beca.setIdExpediente(idExpediente);
                            beca.setFechaInicio(fechaInicio);
                            beca.setFechaFin(fechaFin);
                            beca.setIdBeca(becaDao.getSiguienteId());
                            boolean ingresoBeca = becaDao.ingresar(beca);

                            if (ingresoBeca == true) {
                                //Actualizar Expediente
                                expediente.setIdProgreso(idProgreso);
                                expediente.setEstadoExpediente(estadoExpediente);
                                expedienteDao.actualizarExpediente(expediente);
                                if (estadoExpediente.equals("ABIERTO")){
                                    //Actualizar de candidato a becario
                                    UsuarioDAO usuarioDao = new UsuarioDAO();
                                    usuarioDao.actualizarRolPorIdUsuario(ID_USUARIO, 2);
                                }
                                 Utilidades.mostrarMensaje(response, 1, "Exito", "Se ingresó el becario satisfactoriamente.");
                            } else {
                                //Eliminar Documentos, Oferta y Expediente y solicitud
                                documentoDao.eliminarDocumentosExpediente(idExpediente);
                                solDao.eliminarDocumentosExpediente(idExpediente);
                                expedienteDao.eliminarPermanentemente(idExpediente);
                                Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo ingresar el becario.");
                            }
                        } else {
                            //Eliminar Expediente
                            expedienteDao.eliminarPermanentemente(idExpediente);
                            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo ingresar el becario.");
                        }

                    } else {
                        //Eliminar el expediente
                        expedienteDao.eliminarPermanentemente(idExpediente);
                        Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo ingresar el becario.");
                    }

                } else {
                    //Mostrar mensaje de error
                    expedienteDao.eliminarPermanentemente(idExpediente);
                    Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo ingresar el becario.");
                }
            } else {
                //No se puede crear el becario, mostrar mensaje de error
                Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo ingresar el becario.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            //No se pudieron leer los datos, mostrar mensaje de error
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo ingresar el becario.");
        }        
    }

    //Metodo que permite convertir un texto en fecha
    public Date StringAFecha(String Sfecha) {
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
        Date fecha = null;
        try {
            fecha = formatoDelTexto.parse(Sfecha);
        } catch (ParseException ex) {

            ex.printStackTrace();

        }
        System.out.println("fechanice!");
        return fecha;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

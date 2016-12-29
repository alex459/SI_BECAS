/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import DAO.OfertaBecaDAO;
import DAO.TipoDocumentoDAO;
import POJO.Documento;
import POJO.Expediente;
import POJO.TipoDocumento;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "ResolverAcuerdoCSU", urlPatterns = {"/ResolverAcuerdoCSU"})
@MultipartConfig(maxFileSize = 16177215)
public class ResolverAcuerdoCSU extends HttpServlet {

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
        try {
            //Recuperando informacion
            String resolucion = request.getParameter("resolucion");
            String observacion = request.getParameter("observacion");
            Integer idProgreso = Integer.parseInt(request.getParameter("id_p"));
            String accion = request.getParameter("accion");
            String estado = "";
            Integer id_documento = Integer.parseInt(request.getParameter("id_documento"));
            InputStream archivo = null;
            Part filePart = request.getPart("doc_digital");
            if (filePart != null) {
                archivo = filePart.getInputStream();
            }

            Documento documento = new Documento();
            DocumentoDAO documentoDao = new DocumentoDAO();
            TipoDocumento tipoDoc = new TipoDocumento();
            TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
            ExpedienteDAO expDao = new ExpedienteDAO();
            OfertaBecaDAO ofertaDao = new OfertaBecaDAO();

            //Obteniendo el id del expediente y el tipo de beca
            Integer idExpediente = documentoDao.ObtenerIdExpedientePorIdDocumento(id_documento);
            String TipoBeca = ofertaDao.ObtenerTipoBeca(idExpediente);
            Expediente expediente = expDao.consultarPorId(idExpediente);
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());

            //Obteniendo Documento a resolver
            documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
            documento.setEstadoDocumento(resolucion);
            documento.setObservacion(observacion);
            String obs = documento.getObservacion();
            if (filePart.getSize() >0){
                //Actualizar Documento a resolver
                    documento.setDocumentoDigital(archivo);
                    documentoDao.ActualizarResolver(documento);
            }else{
                    boolean exitoActDoc= documentoDao.ActualizarEstadoDocumento(documento);
            }
            switch (resolucion) {
                case "APROBADO":
                    
                    //Insercion o Actualizacion
                    Documento acuerdoSolicitar = new Documento();
                    if (accion.equals("insertar")) {
                        //Al insertar se debe solicitar el nuevo documento y cambiar el progreso
                        switch (idProgreso) {
                            case 7:
                                //ACUERDO DE BECA DEL CONSEJO SUPERIOR UNIVERSITARIO
                                idProgreso = 8;
                                estado = "PENDIENTE";
                                //SOLICITAR CONTRATO DE BECA
                                acuerdoSolicitar.setIdDocumento(documentoDao.getSiguienteId());
                                acuerdoSolicitar.setIdExpediente(expediente);
                                acuerdoSolicitar.setFechaSolicitud(sqlDate);
                                acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                acuerdoSolicitar.setObservacion(obs);
                                tipoDoc = tipoDao.consultarPorId(134);
                                acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                                documentoDao.solicitarDocumento(acuerdoSolicitar);
                                break;
                            case 15:
                                //ACUERDO DE LIBERACION DEL COMPROMISO CONTRACTUAL
                                idProgreso = 16;
                                estado = "FINALIZADO";
                                break;
                            case 22:
                                //ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO
                                idProgreso = 9;
                                estado = "EN PROCESO";
                                //Cambiar fecha fin de beca
                                break;
                            default:
                                break;
                        }
                    } else {
                        //YA SE HIZO LA SOLICITUD LA PRIMERA VEZ
                        switch (idProgreso) {
                            case 7:
                                //ACUERDO DE BECA DEL CONSEJO SUPERIOR UNIVERSITARIO
                                idProgreso = 8;
                                estado = "PENDIENTE";
                                //SOLICITAR CONTRATO DE BECA de nuevo
                                
                                break;
                            case 15:
                                //ACUERDO DE LIBERACION DEL COMPROMISO CONTRACTUAL
                                idProgreso = 16;
                                estado = "FINALIZADO";
                                break;
                            case 22:
                                //ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO
                                idProgreso = 9;
                                estado = "EN PROCESO";
                                //Cambiar fecha fin de beca
                                break;
                            default:
                                break;
                        }
                    }
                    //Cambiar progreso y estado
                    expediente.setIdProgreso(idProgreso);
                    expediente.setEstadoProgreso(estado);
                    expDao.actualizarExpediente(expediente);
                    break;
                case "DENEGADO":
                    //Actualizar Documento y poner el progreso como denegado
                    //Insercion o Actualizacion
                    Integer idAcuerdoSolicitado = 0;
                    Documento acuerdoSolicitado = new Documento();
                    if(accion.equals("insertar")){
                        
                        switch (idProgreso) {
                            case 7:
                                //ACUERDO DE BECA DEL CONSEJO SUPERIOR UNIVERSITARIO
                                idProgreso = 7;
                                estado = "DENEGADO";
                                
                                break;
                            case 15:
                                ////ACUERDO DE LIBERACION DEL COMPROMISO CONTRACTUAL
                                idProgreso = 14;
                                estado = "REVISION";
                                //Solicitar correccion del Acuerdo del consejo de becas
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 157);
                                acuerdoSolicitado = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                acuerdoSolicitado.setEstadoDocumento("REVISION");
                                acuerdoSolicitado.setObservacion(observacion);
                                documentoDao.ActualizarEstadoDocumento(acuerdoSolicitado);
                                break;
                            case 22:
                                //ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO
                                idProgreso = 22;
                                estado = "DENEGADO";
                                break;
                            default:
                                break;
                        }
                    }else{
                        //Borrar la solicitud de acuerdos que se habia hecho y cambiar el progreso
                        switch (idProgreso) {
                            case 7:
                                //ACUERDO DE BECA DEL CONSEJO SUPERIOR UNIVERSITARIO
                                idProgreso = 7;
                                estado = "DENEGADO";
                                //BORRAR DOCUMENTO SOLICITADO
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 134);
                                documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                                //idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 134);
                                break;
                            case 15:
                                ////ACUERDO DE LIBERACION DEL COMPROMISO CONTRACTUAL
                                idProgreso = 14;
                                estado = "REVISION";
                                //Solicitar correccion del Acuerdo del consejo de becas
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 157);
                                acuerdoSolicitado = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                acuerdoSolicitado.setEstadoDocumento("REVISION");
                                acuerdoSolicitado.setObservacion(observacion);
                                documentoDao.ActualizarEstadoDocumento(acuerdoSolicitado);
                                break;
                            case 22:
                                //ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO
                                idProgreso = 22;
                                estado = "DENEGADO";
                                break;
                            default:
                                break;
                        }
                    }
                    expediente.setIdProgreso(idProgreso);
                    expediente.setEstadoProgreso(estado);
                    expDao.actualizarExpediente(expediente);
                    break;
                case "CORRECCION":
                    //Actualizar documento anterior a correccion y cambiar progreso al anterior
                    Integer idAcuerdoSolicitad = 0;
                    Documento acuerdoSolicitad = new Documento();
                    if (accion.equals("insertar")) {
                        switch (idProgreso) {
                            case 7:
                               documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(6);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 15:
                                //ACUERDO DE LIBERACION DEL COMPROMISO CONTRACTUAL
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(14);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 22:
                                //ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(21);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            default:
                                break;
                        }
                    } else {
                        //Actualizar
                        //Eliminar solicitudes si se habian hecho y cambiar progreso
                        switch (idProgreso) {
                            case 7:
                               documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(6);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                               //BORRAR DOCUMENTO SOLICITADO
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 134);
                                documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                                break;
                            case 15:
                                //ACUERDO DE LIBERACION DEL COMPROMISO CONTRACTUAL
                                documentoDao.ActualizarResolverCorreccion(documento);
                                //Solicitar correccion del Acuerdo del consejo de becas
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 157);
                                acuerdoSolicitado = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                acuerdoSolicitado.setEstadoDocumento("REVISION");
                                acuerdoSolicitado.setObservacion(observacion);
                                documentoDao.ActualizarEstadoDocumento(acuerdoSolicitado);
                               expediente.setIdProgreso(14);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);                               
                                break;
                            case 22:
                                //ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(21);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                               //Reestablecer fecha original de beca
                                break;
                            default:
                                break;
                        }
                    }
                    break;
                default:
                    break;
            }
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se resolvio la solicitud satisfactoriamente.");
        } catch (Exception e) {
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo resolver la solicitud.");
        }
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

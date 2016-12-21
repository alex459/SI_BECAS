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
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "ResolverAcuerdoJuntaDirectiva", urlPatterns = {"/ResolverAcuerdoJuntaDirectiva"})
public class ResolverAcuerdoJuntaDirectiva extends HttpServlet {

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
            switch (resolucion) {
                case "APROBADO":
                    //Actualizar Documento a resolver
                    documento.setDocumentoDigital(archivo);
                    documentoDao.ActualizarResolver(documento);
                    //Insercion o Actualizacion
                    Documento acuerdoSolicitar = new Documento();
                    if (accion.equals("insertar")) {
                        //Al insertar se debe solicitar el nuevo documento y cambiar el progreso
                        switch (idProgreso) {
                            case 1:
                                //Solicitud de Permiso inicial, solo cambiar progreso
                                idProgreso = 2;
                                estado = "PENDIENTE";
                                break;
                            case 4:
                                //Acuerdos de Permisos de Beca
                                idProgreso = 5;
                                estado = "PENDIENTE";
                                break;
                            case 10:
                                //Acuerdo de Año Fiscal
                                idProgreso = 9;
                                estado = "EN PROCESO";
                                break;
                            case 12:
                                //Solicitud Inicio de Servicio Contractual, pasar solicitud al consejo de Becas
                                estado = "EN PROCESO";
                                //solicitar Acuerdos al Consejo de Becas
                                acuerdoSolicitar.setIdDocumento(documentoDao.getSiguienteId());
                                acuerdoSolicitar.setIdExpediente(expediente);
                                acuerdoSolicitar.setFechaSolicitud(sqlDate);
                                acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                acuerdoSolicitar.setObservacion(obs);
                                tipoDoc = tipoDao.consultarPorId(152);
                                acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                                documentoDao.solicitarDocumento(acuerdoSolicitar);
                                break;
                            case 13:
                                //Solicitud de Acuerdo de Gestión de Compromiso Contractual
                                idProgreso = 14;
                                estado = "PENDIENTE";
                                break;
                            case 20:
                                //SOLICITUD DE PRORROGA
                                idProgreso = 21;
                                estado = "EN PROCESO";
                                //solicitar Acuerdos al Consejo de Becas
                                acuerdoSolicitar.setIdDocumento(documentoDao.getSiguienteId());
                                acuerdoSolicitar.setIdExpediente(expediente);
                                acuerdoSolicitar.setFechaSolicitud(sqlDate);
                                acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                acuerdoSolicitar.setObservacion(obs);
                                tipoDoc = tipoDao.consultarPorId(141);
                                acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                                documentoDao.solicitarDocumento(acuerdoSolicitar);
                                break;
                            default:
                                break;
                        }
                    } else {
                        //YA SE HIZO LA SOLICITUD LA PRIMERA VEZ
                    }
                    //Cambiar progreso y estado
                    expediente.setIdProgreso(idProgreso);
                    expediente.setEstadoProgreso(estado);
                    expDao.actualizarExpediente(expediente);
                    break;
                case "DENEGADO":
                    //Actualizar Documento y poner el progreso como denegado
                    documento.setDocumentoDigital(archivo);
                    documentoDao.ActualizarResolver(documento);
                    //Insercion o Actualizacion
                    Integer idAcuerdoSolicitado = 0;
                    Documento acuerdoSolicitado = new Documento();
                    if(accion.equals("insertar")){
                        //fin
                    }else{
                        //Borrar la solicitud de acuerdos que se habia hecho y cambiar el progreso
                        switch (idProgreso) {
                            case 1:
                                //Solicitud de Permiso inicial, solo cambiar progreso
                                idProgreso = 1;
                                estado = "DENEGADO";
                                break;
                            case 4:
                                //Acuerdos de Permisos de Beca
                                idProgreso = 4;
                                estado = "DENEGADO";
                                break;
                            case 10:
                                //Acuerdo de Año Fiscal
                                idProgreso = 10;
                                estado = "DENEGADO";
                                break;
                            case 12:
                                //Solicitud Inicio de Servicio Contractual, pasar solicitud al consejo de Becas
                                idProgreso = 12;
                                estado = "DENEGADO";
                                //BORRAR DOCUMENTO SOLICITADO
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 152);
                                documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                                break;
                            case 13:
                                //Solicitud de Acuerdo de Gestión de Compromiso Contractual
                                idProgreso = 13;
                                estado = "DENEGADO";
                                break;
                            case 20:
                                //SOLICITUD DE PRORROGA
                                idProgreso = 20;
                                estado = "DENEGADO";
                                //BORRAR DOCUMENTO SOLICITADO
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 141);
                                documentoDao.eliminarDocumento(idAcuerdoSolicitado);
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
                            case 1:
                               documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(1);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 4:
                                //Acuerdos de Permisos de Beca
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(3);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 10:
                                //Acuerdo de Año Fiscal
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(10);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 12:
                                //Solicitud Inicio de Servicio Contractual, pasar solicitud al consejo de Becas
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(12);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 13:
                                //Solicitud de Acuerdo de Gestión de Compromiso Contractual
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(13);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 20:
                                //SOLICITUD DE PRORROGA
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(20);
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
                            case 1:
                               documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(1);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 4:
                                //Acuerdos de Permisos de Beca
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(3);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 10:
                                //Acuerdo de Año Fiscal
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(10);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 12:
                                //Solicitud Inicio de Servicio Contractual, pasar solicitud al consejo de Becas
                               //BORRAR DOCUMENTO SOLICITADO
                                idAcuerdoSolicitad = documentoDao.ExisteDocumento(idExpediente, 152);
                                documentoDao.eliminarDocumento(idAcuerdoSolicitad);
                                //Cambiar Progreso
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(12);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 13:
                                //Solicitud de Acuerdo de Gestión de Compromiso Contractual
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(13);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
                                break;
                            case 20:
                                //SOLICITUD DE PRORROGA
                                //BORRAR DOCUMENTO SOLICITADO
                                idAcuerdoSolicitad = documentoDao.ExisteDocumento(idExpediente, 141);
                                documentoDao.eliminarDocumento(idAcuerdoSolicitad);
                                //Cambiar Progreso
                                documentoDao.ActualizarResolverCorreccion(documento);
                               expediente.setIdProgreso(20);
                               expediente.setEstadoProgreso("REVISION");
                               expDao.actualizarExpediente(expediente);
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import DAO.TipoDocumentoDAO;
import DAO.OfertaBecaDAO;
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
@WebServlet(name = "ResolverDictamen", urlPatterns = {"/ResolverDictamen"})
@MultipartConfig(maxFileSize = 16177215)
public class ResolverDictamen extends HttpServlet {

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
            String accion = request.getParameter("accion");
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
                    //Actualizar Documento y solicitar el nuevo
                    documento.setDocumentoDigital(archivo);
                    documentoDao.ActualizarResolver(documento);
                    //Insercion o Actualizacion
                    Documento acuerdoSolicitar = new Documento();
                    if(accion.equals("insertar")){
                        //solicitar Acuerdos a Junta Directiva
                        acuerdoSolicitar.setIdDocumento(documentoDao.getSiguienteId());
                        acuerdoSolicitar.setIdExpediente(expediente);
                        acuerdoSolicitar.setFechaSolicitud(sqlDate);
                        acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                        acuerdoSolicitar.setObservacion(obs);
                        if(TipoBeca.equals("INTERNA")){
                            tipoDoc = tipoDao.consultarPorId(120);
                            acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                            documentoDao.solicitarDocumento(acuerdoSolicitar);
                        }else{
                            tipoDoc = tipoDao.consultarPorId(121);
                            acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                            documentoDao.solicitarDocumento(acuerdoSolicitar);
                        } 
                        
                    }else{
                        //YA SE HIZO LA SOLICITUD LA PRIMERA VEZ
                    }
                    //Cambiar progreso y estado
                    expediente.setIdProgreso(4);
                    expediente.setEstadoProgreso("PENDIENTE");
                    expDao.actualizarExpediente(expediente);
                    break;
                case "DENEGADO":
                    //Actualizar Documento y poner el progreso como denegado
                    documento.setDocumentoDigital(archivo);
                    documentoDao.ActualizarResolver(documento);
                    //Insercion o Actualizacion
                    if(accion.equals("insertar")){
                        //fin
                    }else{
                        //Borrar la solicitud de acuerdos que se habia hecho
                        //obteniendo el id del acuerdo solicitado
                        Integer idAcuerdoSolicitado = 0;
                        Documento acuerdoSolicitado = new Documento();
                        //eliminando el documento
                        if(TipoBeca.equals("INTERNA")){
                           idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 120);
                           documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                        }else{
                           idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 121);
                           documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                        }
                        
                    }
                    //Cambiar progreso y estado
                    expediente.setIdProgreso(3);
                    expediente.setEstadoProgreso("DENEGADO");
                    expDao.actualizarExpediente(expediente);
                    break;
                case "CORRECCION":
                    //Actualizar documento anterior a correccion y cambiar progreso al anterior
                    documentoDao.ActualizarResolverCorreccion(documento);
                    expediente.setIdProgreso(2);
                    expediente.setEstadoProgreso("PENDIENTE");
                    expDao.actualizarExpediente(expediente);
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import DAO.TipoDocumentoDAO;
import POJO.Documento;
import POJO.Expediente;
import POJO.TipoDocumento;
import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "SolicitarReintegro", urlPatterns = {"/SolicitarReintegro"})
public class SolicitarReintegro extends HttpServlet {

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
            //Recuperando datos del formulario
            int idExpediente = Integer.parseInt(request.getParameter("idExpediente"));
            if (idExpediente >= 1) {
                //Solicitar

                //POJOS Y DAOS
                ExpedienteDAO expDao = new ExpedienteDAO();
                Documento acuerdoSolicitar = new Documento();
                DocumentoDAO documentoDao = new DocumentoDAO();
                TipoDocumento tipo = new TipoDocumento();
                TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();

                Expediente expediente = expDao.consultarPorId(idExpediente);
                String obs = "LA BECA HA EXPIRADO";
                tipo = tipoDao.consultarPorId(159);
                int idDoc = documentoDao.getSiguienteId();
                Date fechaHoy = new Date();
                java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
                int idActa = documentoDao.ExisteDocumento(idExpediente, 159);
                if (idActa == 0) {
                    acuerdoSolicitar.setIdDocumento(idDoc);
                    acuerdoSolicitar.setIdExpediente(expediente);
                    acuerdoSolicitar.setFechaSolicitud(sqlDate);
                    acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                    acuerdoSolicitar.setObservacion(obs);
                    acuerdoSolicitar.setIdTipoDocumento(tipo);
                    documentoDao.solicitarDocumento(acuerdoSolicitar);
                } else {
                    acuerdoSolicitar = documentoDao.obtenerInformacionDocumentoPorId(idActa);
                    acuerdoSolicitar.setFechaSolicitud(sqlDate);
                    acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                    acuerdoSolicitar.setObservacion(obs);
                    documentoDao.ActualizarResolverCorreccion(acuerdoSolicitar);
                }

                //CAMBIAR PROGRESO Y ESTADO
                expediente.setIdProgreso(23);
                expediente.setEstadoProgreso("PENDIENTE");
                expDao.actualizarExpediente(expediente);

                Utilidades.mostrarMensaje(response, 1, "Exito", "Se ha solicitado el Reintegro de la Beca satisfactoriamente.");
            } else {
                //Mostrar mensaje de error
                Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo solicitar el reintegro de la beca.");
            }
        } catch (Exception e) {
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo solicitar el reintegro de la beca.");
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

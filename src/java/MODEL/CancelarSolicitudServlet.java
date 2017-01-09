/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import POJO.Documento;
import POJO.Expediente;
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
@WebServlet(name = "CancelarSolicitudServlet", urlPatterns = {"/CancelarSolicitudServlet"})
public class CancelarSolicitudServlet extends HttpServlet {

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
            
            try{
            //obtener id del documento
            int idDocumento = Integer.parseInt(request.getParameter("idDocumento"));
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
            
            if (idDocumento == 0){
                Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo cancelar la solicitud.");
            } 
            
            //recuperar documento
            Documento documento = new Documento();
            DocumentoDAO documentoDao = new DocumentoDAO();
            documento = documentoDao.obtenerInformacionDocumentoPorId(idDocumento);
            //cambiar estado a cancelado y actualizar documento
            documento.setEstadoDocumento("CANCELADO");
            documento.setFechaIngreso(sqlDate);
            documentoDao.ActualizarEstadoDocumento(documento);                        
                        
            //obteniendo expediente y cambiar estado progreso a pendiente
            ExpedienteDAO expDao = new ExpedienteDAO();
            int idExpediente = documentoDao.ObtenerIdExpedientePorIdDocumento(idDocumento);
            //Si es permiso inicial cerrar expediente
            int permisoinicial = documentoDao.ExisteDocumento(idExpediente, 103);
            Expediente expediente = expDao.consultarPorId(idExpediente);
            //Cancelar los documentos en espera de correccion
            documentoDao.CancelarDocumentos(idExpediente);
            if (idDocumento == permisoinicial){
                expediente.setEstadoExpediente("CERRADO");
                expediente.setEstadoProgreso("CANCELADO");
            } else{
                expediente.setEstadoProgreso("PENDIENTE");
            }                        
            expDao.actualizarExpediente(expediente);
            
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se cancelo la solicitud satisfactoriamente.");
            }catch(Exception e){
                Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo cancelar la solicitud.");
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

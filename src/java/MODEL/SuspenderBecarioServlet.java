/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.ExpedienteDAO;
import DAO.DocumentoDAO;
import DAO.TipoDocumentoDAO;
import POJO.Documento;
import POJO.Expediente;
import POJO.TipoDocumento;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Manuel Miranda
 */
@WebServlet(name = "SuspenderBecarioServlet", urlPatterns = {"/SuspenderBecarioServlet"})
public class SuspenderBecarioServlet extends HttpServlet {

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
        String suspenderBecario = request.getParameter("SUSPENDER_BECARIO");
        String user = request.getParameter("idUsuario");
        Integer idExpediente = Integer.parseInt(request.getParameter("idExpediente"));
        ExpedienteDAO expedienteDAO = new ExpedienteDAO();
        DocumentoDAO documentoDAO = new DocumentoDAO();
        TipoDocumento tipoDoc = new TipoDocumento();
        TipoDocumentoDAO tipoDocDAO = new TipoDocumentoDAO();
        Expediente expediente = new Expediente();
        expediente = expedienteDAO.consultarPorId(idExpediente);
        Boolean actExpediente = Boolean.FALSE;
        Boolean solicitarAcuerdo = Boolean.FALSE;
        Integer tip;
        Integer idDoc;
        
        
        if("True".equalsIgnoreCase(suspenderBecario) && expediente != null ){
            
            //Solicitar Documento
            Documento acuerdo = new Documento();
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
            idDoc = documentoDAO.getSiguienteId();
            tip = 159;
            tipoDoc = tipoDocDAO.consultarPorId(tip);
            String observacion = "ACTA DE REINTEGRO DE BECA PARA EL USUARIO:" + user;

            acuerdo.setIdDocumento(idDoc);
            acuerdo.setIdTipoDocumento(tipoDoc);
            acuerdo.setIdExpediente(expediente);
            acuerdo.setFechaSolicitud(sqlDate);
            acuerdo.setObservacion(observacion);
            acuerdo.setEstadoDocumento("PENDIENTE");
            solicitarAcuerdo = documentoDAO.solicitarDocumento(acuerdo);

            if (solicitarAcuerdo){
            //Actualizzar expediente 
                expediente.setIdProgreso(23);
                expediente.setEstadoProgreso("PENDIENTE");
                actExpediente = expedienteDAO.actualizarExpediente(expediente);
            }
            
            if(actExpediente){
                Utilidades.mostrarMensaje(response, 1, "Exito", "Se ha suspendido al becario.");
            }else{
                Utilidades.mostrarMensaje(response, 2, "Error", "No se ha podido suspender al becario.");
            }
            
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

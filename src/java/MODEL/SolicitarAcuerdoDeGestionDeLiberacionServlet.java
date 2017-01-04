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
 * @author Manuel Miranda
 */
@WebServlet(name = "SolicitarAcuerdoDeGestionDeLiberacionServlet", urlPatterns = {"/SolicitarAcuerdoDeGestionDeLiberacionServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class SolicitarAcuerdoDeGestionDeLiberacionServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");

        InputStream docDigital = null;
        String user = request.getParameter("user");
        Integer idExpediente = Integer.parseInt(request.getParameter("idExpediente"));
        boolean solicitarAcuerdo = false;

        DocumentoDAO documentoDao = new DocumentoDAO();
        TipoDocumento tipo = new TipoDocumento();
        TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
        Integer tip;
        Integer idDoc;

        ExpedienteDAO expDao = new ExpedienteDAO();
        Expediente expediente = expDao.consultarPorId(idExpediente);

        if(expediente != null){
            Part filePart = null;
            Documento anexo = new Documento();
            idDoc = documentoDao.getSiguienteId();
            tip = 156;
            tipo = tipoDao.consultarPorId(tip);
            filePart = request.getPart("cartaSolicitud");
            if (filePart != null) {
                docDigital = filePart.getInputStream();
            }
            String obs = "DOCUMENTO ADJUNTO PARA SOLICITUD DE ACUERDO DE GESTION DE LIBERACION DEL USUARIO: " + user;

            anexo.setIdDocumento(idDoc);
            anexo.setIdTipoDocumento(tipo);
            anexo.setIdExpediente(expediente);
            anexo.setDocumentoDigital(docDigital);
            anexo.setObservacion(obs);
            anexo.setEstadoDocumento("INGRESADO");
            documentoDao.Ingresar(anexo);
            
            //Solicitar Documento
            Documento acuerdo = new Documento();
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
            idDoc = documentoDao.getSiguienteId();
            tip = 157;
            tipo = tipoDao.consultarPorId(tip);
            String observacion = "DOCUMENTO SOLICITADO POR EL USUARIO:" + user;

            acuerdo.setIdDocumento(idDoc);
            acuerdo.setIdTipoDocumento(tipo);
            acuerdo.setIdExpediente(expediente);
            acuerdo.setFechaSolicitud(sqlDate);
            acuerdo.setObservacion(observacion);
            acuerdo.setEstadoDocumento("PENDIENTE");
            solicitarAcuerdo = documentoDao.solicitarDocumento(acuerdo);

            if (solicitarAcuerdo == true){
            //Cambiar Estado de Progreso 
                expediente.setEstadoProgreso("EN PROCESO");
                expDao.actualizarExpediente(expediente);
            }else{
            //eliminar Carta de solicitud
            }
        }

        if(solicitarAcuerdo== true)
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se solicito el acuerdo de gestion de liberacion correctamente.");
        else
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo realizar la solicitud de acuerdo de gestion de liberacion.");
        
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

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
import java.io.PrintWriter;
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
@WebServlet(name = "SolicitarInicioDeServicioContractualServlet", urlPatterns = {"/SolicitarInicioDeServicioContractualServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class SolicitarInicioDeServicioContractualServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String idDocumentos[] = {"actaPosesion","proyectoApoyara","solicitudJD","solicitudCB"};
            
            InputStream tituloObtenido = null;
            String user = request.getParameter("user");
            Integer idExpediente = Integer.parseInt(request.getParameter("idExpediente"));
            Integer nAnexos = Integer.parseInt(request.getParameter("nAnexos"));
            Part filePart = request.getPart("tituloObtenido");
            if (filePart != null) {
                tituloObtenido = filePart.getInputStream();
            }
            boolean solicitarAcuerdo = false;
            boolean ingresarDocumento = false;

            ExpedienteDAO expDao = new ExpedienteDAO();
            Expediente expediente = expDao.consultarPorId(idExpediente);

            if(expediente != null){
                
                Documento documento = new Documento();
                DocumentoDAO documentoDao = new DocumentoDAO();
                TipoDocumento tipo = new TipoDocumento();
                TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();

                Integer idDoc =  documentoDao.getSiguienteId();
                Integer idTitulo = idDoc;
                String obs = "TITULO OBTENIDO POR EL USUARIO " + user;
                Integer tip = 130;
                tipo = tipoDao.consultarPorId(tip);

                documento.setIdDocumento(idDoc);
                documento.setIdTipoDocumento(tipo);
                documento.setDocumentoDigital(tituloObtenido);
                documento.setIdExpediente(expediente);
                documento.setObservacion(obs);
                documento.setEstadoDocumento("INGRESADO");
                ingresarDocumento = documentoDao.Ingresar(documento);
                
                
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

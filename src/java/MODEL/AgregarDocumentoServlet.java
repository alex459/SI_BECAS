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
@WebServlet("/AgregarDocumentoServlet")
@MultipartConfig(maxFileSize = 16177215)
public class AgregarDocumentoServlet extends HttpServlet {

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
        Integer tip = Integer.parseInt(request.getParameter("tipo"));
        String obs = request.getParameter("observacion");
        InputStream archivo = null;
        Part filePart = request.getPart("doc_digital");
        if (filePart != null) {
            archivo = filePart.getInputStream();
        }
        
        Documento documento = new Documento();
        DocumentoDAO documentoDao = new DocumentoDAO();
        TipoDocumento tipo = new TipoDocumento();
        TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
        ExpedienteDAO expDao = new ExpedienteDAO();
        
        Integer idDoc =  documentoDao.getSiguienteId();
        
        tipo = tipoDao.consultarPorId(tip);
        Integer idexp = 0;
        Expediente idexpediente = expDao.consultarPorId(idexp);  
        String Estado = "Publico";
        
        
        
        documento.setIdDocumento(idDoc);
        documento.setIdTipoDocumento(tipo);
        documento.setDocumentoDigital(archivo);
        documento.setIdExpediente(idexpediente);
        documento.setObservacion(obs);
        documento.setEstadoDocumento(Estado);
        
        
        boolean ing = documentoDao.Ingresar(documento);
        
        if(ing= true){
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se ingreso el Documento correctamente.");
        }
        else
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo ingresar el Documento.");
    
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

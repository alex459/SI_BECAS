/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.DocumentoDAO;
import POJO.Documento;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "VerDocumentoCierre", urlPatterns = {"/VerDocumentoCierre"})
public class VerDocumentoCierre extends HttpServlet {

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
        DocumentoDAO docdao = new DocumentoDAO();
        Integer idDoc = Integer.parseInt(request.getParameter("ID_DOCUMENTO"));
        Documento doc = new Documento();
        doc = docdao.obtenerDocumentoExpediente(idDoc);
        String PdfName = doc.getIdTipoDocumento().getTipoDocumento() +".pdf";
        ServletOutputStream  outs;
        response.setContentType( "application/pdf" );
        response.setHeader("Content-disposition","inline; filename=" +PdfName );
        outs=  response.getOutputStream ();
        InputStream is = null; 
        BufferedInputStream  bis = null; 
        BufferedOutputStream bos = null;
        
        try{
            
            is= doc.getDocumentoDigital();
            
            bis = new BufferedInputStream(is);
            bos = new BufferedOutputStream(outs);
            byte[] buff = new byte[8192];
            int bytesRead;
    // leyendo el archivo 
            while(-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
                int id=0;
            }
        }catch(Exception e){
              System.out.println(e);          
        }finally{
            if (bis != null)
             bis.close();
             if (bos != null)
             bos.close();
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

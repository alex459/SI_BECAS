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
 * @author Manuel Miranda
 */
@WebServlet(name = "AgregarDocumentoFinalizacionBecaServlet", urlPatterns = {"/AgregarDocumentoFinalizacionBecaServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class AgregarDocumentoFinalizacionBecaServlet extends HttpServlet {

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
        //Recuperando datos del formulario
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
        
        if (expediente != null){
        //Ingresar carta de solicitud
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
        
            if(ingresarDocumento == true){
            //Ingresar anexos
                if(nAnexos >0){
                    InputStream archivoAnexo = null;
                    for (int i = 1; i < nAnexos+1; i++) {
                        String varTipo = "tipoAnexo" +i;
                        String varNombreDocumento = "anexo" +i;
                        Documento anexo = new Documento();
                        Integer idAnexo = documentoDao.getSiguienteId();
                        tip = Integer.parseInt(request.getParameter(varTipo));
                        tipo = tipoDao.consultarPorId(tip);
                        filePart = null;
                        filePart = request.getPart(varNombreDocumento);
                        if (filePart != null) {
                            archivoAnexo = filePart.getInputStream();
                        }
                        obs = "DOCUMENTO ADJUNTO PARA FINALIZACION DE BECA DEL USUARIO: " + user;
                
                        anexo.setIdDocumento(idAnexo);
                        anexo.setIdTipoDocumento(tipo);
                        anexo.setIdExpediente(expediente);
                        anexo.setDocumentoDigital(archivoAnexo);
                        anexo.setObservacion(obs);
                        anexo.setEstadoDocumento("INGRESADO");
                        documentoDao.Ingresar(anexo);
                    }
                }else{
                    //Nada NO hay Documentacion Anexada
                }
      
            }else{
                //NADA no se ingreso ningun documento
            }

        }else{
        //Nada no se obtuvo expediente
        }
        
        if(ingresarDocumento == true){
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se solicito el Acuerdo de Autorizacion Inicial correctamente.");
        }
        else
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo realizar la solicitud del Acuerdo de Autorizacion Inicial.");
        
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

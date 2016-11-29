/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import DAO.SolocitudBecaDAO;
import DAO.TipoDocumentoDAO;
import DAO.UsuarioDAO;
import POJO.Documento;
import POJO.Expediente;
import POJO.SolicitudDeBeca;
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
@WebServlet(name = "SolicitarPermisoInicialServlet", urlPatterns = {"/PermisoInicial"})
@MultipartConfig(maxFileSize = 16177215)
public class SolicitarPermisoInicialServlet extends HttpServlet {

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
        InputStream cartaSolicitud = null;
        String user = request.getParameter("user");
        Part filePart = request.getPart("cartaSolicitud");
        if (filePart != null) {
            cartaSolicitud = filePart.getInputStream();
        }
        
        //Creando el expediente
        ExpedienteDAO expDao = new ExpedienteDAO();
        Expediente expediente = new Expediente();
        Integer idExpediente = expDao.getSiguienteId();
        Integer idProgreso = 1;
        
        expediente.setIdExpediente(idExpediente);
        expediente.setEstadoExpediente("ABIERTO");
        expediente.setIdProgreso(idProgreso);
        expediente.setEstadoProgreso("EN PROCESO");
        
        boolean exito = expDao.ingresar(expediente);
                
        //Ingresando el documento
        Documento documento = new Documento();
        DocumentoDAO documentoDao = new DocumentoDAO();
        TipoDocumento tipo = new TipoDocumento();
        TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
        
        Integer idDoc =  documentoDao.getSiguienteId();
        String obs = "CARTA DE SOLICITUD DEL USUARIO " + user;
        Integer tip = 100;
        tipo = tipoDao.consultarPorId(tip);
        
        documento.setIdDocumento(idDoc);
        documento.setIdTipoDocumento(tipo);
        documento.setDocumentoDigital(cartaSolicitud);
        documento.setIdExpediente(expediente);
        documento.setObservacion(obs);
        documento.setEstadoDocumento("Ingresado");
        
        boolean ingresarDocumento = documentoDao.Ingresar(documento);
        
        //creando Solicitud de beca
        SolocitudBecaDAO solDao = new SolocitudBecaDAO();
        SolicitudDeBeca solicitud = new SolicitudDeBeca();
        UsuarioDAO usuDao = new UsuarioDAO();
        Integer idSolicitud = solDao.getSiguienteId();
        Integer idUsuario = usuDao.obtenerIdUsuario(user);
        Integer idOfertaBeca = 4;
        Date fechaHoy = new Date();
        java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime()); 
        
        solicitud.setIdSolicitud(idSolicitud);
        solicitud.setIdExpediente(idExpediente);
        solicitud.setIdUsuario(idUsuario);
        solicitud.setIdOfertaBeca(idOfertaBeca);
        solicitud.setFechaSolicitud(sqlDate);
        
        boolean ingresarSolicitud = solDao.ingresar(solicitud);
        
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

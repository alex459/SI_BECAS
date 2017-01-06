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
 * @author adminPC
 */
@WebServlet(name = "ActualizarGestionLiberacionServlet", urlPatterns = {"/ActualizarGestionLiberacionServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class ActualizarGestionLiberacionServlet extends HttpServlet {

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
            String accCarta = request.getParameter("accCarta");                

            int id_documento = 0;
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
            int idDoc = 0;
            String obs = "";
            int tip=0;

            InputStream archivo = null;
            Part filePart = null;

            DocumentoDAO documentoDao = new DocumentoDAO();
            Documento documento = new Documento();
            TipoDocumento tipo = new TipoDocumento();
            TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
            ExpedienteDAO expDao = new ExpedienteDAO();
            Expediente expediente = new Expediente();
            
            expediente = expDao.consultarPorId(idExpediente);

            //Carta de Solicitud del candidato
            switch (accCarta) {
                case "ninguna":
                    //No hacer nada
                    break;
                case "eliminar":
                    //Obteniendo el id del documento
                    id_documento = documentoDao.ExisteDocumento(idExpediente, 156);
                    if (id_documento != 0) {
                        //eliminar
                        documentoDao.eliminarDocumento(id_documento);
                    } else {
                        //nada
                    }
                    break;
                case "actualizar":
                    //Actualizar Documento
                    //Obteniendo el id del documento y el documento                    
                    filePart = request.getPart("cartaSolicitud");
                    if (filePart != null) {
                        archivo = filePart.getInputStream();
                    }
                    id_documento = documentoDao.ExisteDocumento(idExpediente, 156);
                    if (id_documento != 0) {
                        //Actualizar
                        documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                        documento.setDocumentoDigital(archivo);
                        documento.setFechaIngreso(sqlDate);
                        documentoDao.ActualizarDocDig(documento);
                    } else {
                        //Agregar
                        idDoc = documentoDao.getSiguienteId();
                        obs = "CARTA DE SOLICITUD DEL expediente " + idExpediente;
                        tip= 156;
                        tipo = tipoDao.consultarPorId(tip);

                        documento.setIdDocumento(idDoc);
                        documento.setIdTipoDocumento(tipo);
                        documento.setDocumentoDigital(archivo);
                        documento.setIdExpediente(expediente);
                        documento.setObservacion(obs);
                        documento.setEstadoDocumento("INGRESADO");
                        documentoDao.Ingresar(documento);
                    }
                    break;
                default:
                    break;
            }
                                                     
            
            if(accCarta.equals("ninguna")){
                //no se realizo ninguna accion, Conservar estado y progreso 
            } else{
                //CAMBIAR DOCUMENTO,PROGRESO Y ESTADO A PENDIENTE
                id_documento = documentoDao.ExisteDocumento(idExpediente, 157);
                documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                documento.setEstadoDocumento("PENDIENTE");
                documentoDao.ActualizarEstadoDocumento(documento);
                
                expediente.setIdProgreso(14);
                expediente.setEstadoProgreso("EN PROCESO");
                expDao.actualizarExpediente(expediente);
            }
            
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se Actualizo correctamente la Solicitud.");

        } catch (Exception e) {
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo Actualizar la Solicitud.");
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

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
        Integer idOfertaBeca = Integer.parseInt(request.getParameter("idOferta"));
        Integer nAnexos = Integer.parseInt(request.getParameter("nAnexos"));
        Part filePart = request.getPart("cartaSolicitud");
        if (filePart != null) {
            cartaSolicitud = filePart.getInputStream();
        }
        
        //Crear expediente
        ExpedienteDAO expDao = new ExpedienteDAO();
        Expediente expediente = new Expediente();
        Integer idExpediente = expDao.getSiguienteId();
        Integer idProgreso = 1;
        
        expediente.setIdExpediente(idExpediente);
        expediente.setEstadoExpediente("ABIERTO");
        expediente.setIdProgreso(idProgreso);
        expediente.setEstadoProgreso("EN PROCESO");
        
        boolean expedienteCreado = expDao.ingresar(expediente);
        boolean ingresarDocumento = false;
        boolean ingresarSolicitud = false;
        boolean solicitarAcuerdo = false;
        
        if(expedienteCreado == true){
            //Ingresar Carta de Solicitud
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
            documento.setEstadoDocumento("INGRESADO");
            ingresarDocumento = documentoDao.Ingresar(documento);
            
            if(ingresarDocumento == true){
                //Ingresando Documentacion Anexada si la hay
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
                        obs = "ANEXO DEL USUARIO: " + user;
                
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
                
                //Crear Solicitud
                SolocitudBecaDAO solDao = new SolocitudBecaDAO();
                SolicitudDeBeca solicitud = new SolicitudDeBeca();
                UsuarioDAO usuDao = new UsuarioDAO();
                Integer idSolicitud = solDao.getSiguienteId();
                Integer idUsuario = usuDao.obtenerIdUsuario(user);
                Date fechaHoy = new Date();
                java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime()); 
        
                solicitud.setIdSolicitud(idSolicitud);
                solicitud.setIdExpediente(idExpediente);
                solicitud.setIdUsuario(idUsuario);
                solicitud.setIdOfertaBeca(idOfertaBeca);
                solicitud.setFechaSolicitud(sqlDate);
                ingresarSolicitud = solDao.ingresar(solicitud);
                
                if(ingresarSolicitud == true){
                    //Solicitar Documento
                    Documento acuerdo = new Documento();
                    idDoc = documentoDao.getSiguienteId();
                    tip = 103;
                    tipo = tipoDao.consultarPorId(tip);
                    String observacion = "DOCUMENTO SOLICITADO POR EL USUARIO:" + user;
        
                    acuerdo.setIdDocumento(idDoc);
                    acuerdo.setIdTipoDocumento(tipo);
                    acuerdo.setIdExpediente(expediente);
                    acuerdo.setFechaSolicitud(sqlDate);
                    acuerdo.setObservacion(observacion);
                    acuerdo.setEstadoDocumento("PENDIENTE");
                    solicitarAcuerdo = documentoDao.solicitarDocumento(acuerdo);
                    
                    if (solicitarAcuerdo == false){
                        //Borrar Solicitud
                        solDao.eliminarDocumentosExpediente(expediente.getIdExpediente());
                        //Borrar Documentos
                        documentoDao.eliminarDocumentosExpediente(expediente.getIdExpediente());
                        //Borrar Expediente
                        expDao.eliminarPermanentemente(expediente.getIdExpediente());
                    }else{}
                }else{
                    //Borrar documentos del expediente
                    documentoDao.eliminarDocumentosExpediente(expediente.getIdExpediente());
                    
                    //Borrar Expediente
                    expDao.eliminarPermanentemente(expediente.getIdExpediente());
                }
            }else{
                //Borrar Expediente
                expDao.eliminarPermanentemente(expediente.getIdExpediente());
            }
        
        }else{
            //Agregar a bitacora accion
            //Utilidades.nuevaBitacora(1, request.getSession().getAttribute("user").toString(), "Error al ingresar solicitud de Permiso Inicial");
        }
        
        
        if(solicitarAcuerdo== true){
            Utilidades.nuevaBitacora(11, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()), request.getSession().getAttribute("user").toString() + " realizo la solicitud de permiso de gestion de beca.", "");            
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se solicito el Acuerdo de Permiso de Gestión de Beca correctamente.");
        }
        else
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo realizar la solicitud del Acuerdo de Permiso de Gestión de Beca.");
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

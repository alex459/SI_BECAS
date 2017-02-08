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
import java.util.ArrayList;
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
@WebServlet(name = "SolicitarAutorizacionInicialServlet", urlPatterns = {"/AutorizacionInicial"})
@MultipartConfig(maxFileSize = 16177215)
public class SolicitarAutorizacionInicialServlet extends HttpServlet {

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
        Integer idExpediente = Integer.parseInt(request.getParameter("idExpediente"));        
        Part filePart = request.getPart("cartaSolicitud");
        if (filePart != null) {
            cartaSolicitud = filePart.getInputStream();
        }
        boolean solicitarAcuerdo = false;
        
        //obtener Expediente
        ExpedienteDAO expDao = new ExpedienteDAO();
        Expediente expediente = expDao.consultarPorId(idExpediente);
        
        if (expediente != null){
        //Ingresar carta de solicitud
            Documento documento = new Documento();
            DocumentoDAO documentoDao = new DocumentoDAO();
            TipoDocumento tipo = new TipoDocumento();
            TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
        
            Integer idDoc =  documentoDao.getSiguienteId();
            Integer idCarta = idDoc;
            String obs = "CARTA DE SOLICITUD DE AUTORIZACION INICIAL DEL USUARIO " + user;
            Integer tip = 104;
            tipo = tipoDao.consultarPorId(tip);
        
            documento.setIdDocumento(idDoc);
            documento.setIdTipoDocumento(tipo);
            documento.setDocumentoDigital(cartaSolicitud);
            documento.setIdExpediente(expediente);
            documento.setObservacion(obs);
            documento.setEstadoDocumento("INGRESADO");
            boolean ingresarDocumento = documentoDao.Ingresar(documento);
            
            //Ingresando Documentacion necesaria para la Solicitud
            //documentos
                        ArrayList<String> documentos = new ArrayList<>();
                        documentos.add("titulo");
                        documentos.add("certificacion");
                        documentos.add("dui");
                        documentos.add("nombramiento");
                        documentos.add("cartaJefe");
                        documentos.add("constanciaExpediente");
                        documentos.add("constanciaBienestar");
                        ArrayList<Integer> tipos = new ArrayList<>();
                        tipos.add(124);
                        tipos.add(128);
                        tipos.add(126);
                        tipos.add(161);
                        tipos.add(123);
                        tipos.add(160);
                        tipos.add(129);

                        //Recuperando datos del formulario                        
                        InputStream documentoAdjunto = null;
                        obs = "DOCUMENTO ADJUNTO PARA SOLICITUD DE AUTORIZACION INICIAL DEL USUARIO: " + user;                        
                        TipoDocumento tipoDocumento = new TipoDocumento();
                        for (int i = 0; i < 7; i++) {
                            Documento anexo = new Documento();
                            //Comparando si exite documento
                            Integer idTipo = tipos.get(i);
                            Integer idDocumento = documentoDao.ExisteDocumento(expediente.getIdExpediente(), idTipo);
                            filePart = null;
                            filePart = request.getPart(documentos.get(i));
                            if (filePart != null) {
                                documentoAdjunto = filePart.getInputStream();
                            }

                            if (idDocumento == 0) {
                                //Ingresar Documento
                                idDocumento = documentoDao.getSiguienteId();
                                tipoDocumento = tipoDao.consultarPorId(idTipo);
                                anexo.setIdDocumento(idDocumento);
                                anexo.setIdTipoDocumento(tipoDocumento);
                                anexo.setIdExpediente(expediente);
                                anexo.setDocumentoDigital(documentoAdjunto);
                                anexo.setObservacion(obs);
                                anexo.setEstadoDocumento("INGRESADO");
                                documentoDao.Ingresar(anexo);
                            } else {
                                //Actualizar Documento
                                anexo = documentoDao.ObtenerPorId(idDocumento);
                                anexo.setDocumentoDigital(documentoAdjunto);
                                documentoDao.ActualizarDocumentoObservacion(anexo);
                            }

                        }
            
            
            
            
        
            if(ingresarDocumento == true){            
                
            //Solicitar Documento
                Documento acuerdo = new Documento();
                Date fechaHoy = new Date();
                java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
                idDoc = documentoDao.getSiguienteId();
                tip = 105;
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
                    documentoDao.eliminarDocumento(idCarta);
                
                }       
            }else{
                //NADA no se ingreso ningun documento
            }

        }else{
        //Nada no se obtuvo expediente
        }
        
        if(solicitarAcuerdo== true){
            Utilidades.nuevaBitacora(11, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()), request.getSession().getAttribute("user").toString()+ " solicito la Autorizacion Inicial.", "");
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

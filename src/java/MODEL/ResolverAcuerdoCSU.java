/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//FALTA 22
package MODEL;

import DAO.BecaDAO;
import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import DAO.OfertaBecaDAO;
import DAO.ProrrogaDAO;
import DAO.SolocitudBecaDAO;
import DAO.TipoDocumentoDAO;
import POJO.Beca;
import POJO.Documento;
import POJO.Expediente;
import POJO.Prorroga;
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
@WebServlet(name = "ResolverAcuerdoCSU", urlPatterns = {"/ResolverAcuerdoCSU"})
@MultipartConfig(maxFileSize = 16177215)
public class ResolverAcuerdoCSU extends HttpServlet {

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
            //RECUPERAR DATOS
            String resolucion = request.getParameter("resolucion");
            String observacion = request.getParameter("observacion");
            Integer idProgreso = Integer.parseInt(request.getParameter("id_p"));
            String accion = request.getParameter("accion");
            String estado = "";
            Integer id_documento = Integer.parseInt(request.getParameter("id_documento"));
            InputStream archivo = null;
            Part filePart = request.getPart("doc_digital");
            if (filePart != null) {
                archivo = filePart.getInputStream();
            }
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());

            //DAOS Y POJOS
            Documento documento = new Documento();
            DocumentoDAO documentoDao = new DocumentoDAO();
            TipoDocumento tipoDoc = new TipoDocumento();
            TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
            ExpedienteDAO expDao = new ExpedienteDAO();
            OfertaBecaDAO ofertaDao = new OfertaBecaDAO();
            BecaDAO becaDao = new BecaDAO();
            ProrrogaDAO prorrogaDao = new ProrrogaDAO();
            Beca beca = new Beca();
            Prorroga prorroga = new Prorroga();

            //RECUPERAR EXPEDIENTE, DOCUMENTO A RESOLVER  Y TIPO DE BECA
            Integer idExpediente = documentoDao.ObtenerIdExpedientePorIdDocumento(id_documento);
            String TipoBeca = ofertaDao.ObtenerTipoBeca(idExpediente);
            Expediente expediente = expDao.consultarPorId(idExpediente);
            documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
            //RESOLUCION DEL DOCUMENTO
            documento.setEstadoDocumento(resolucion);
            documento.setObservacion(observacion);
            String obs = documento.getObservacion();
            if (filePart.getSize() > 0) {
                //Actualizar Documento a resolver
                documento.setDocumentoDigital(archivo);
                documentoDao.ActualizarResolver(documento);
            } else {
                boolean exitoActDoc = documentoDao.ActualizarEstadoDocumento(documento);
            }
            //PROCESO SEGUN RESOLUCION 
            Integer idAcuerdoSolicitado = 0;
            Documento acuerdoAnterior = new Documento();
            int idProrroga = 0;
            switch (resolucion) {
                case "APROBADO":
                    Documento acuerdoSolicitar = new Documento();
                    switch (idProgreso) {
                        case 7:
                            //ACUERDO DE BECA DEL CONSEJO SUPERIOR UNIVERSITARIO
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                //SOLICITAR CONTRATO DE BECA
                                acuerdoSolicitar.setIdDocumento(documentoDao.getSiguienteId());
                                acuerdoSolicitar.setIdExpediente(expediente);
                                acuerdoSolicitar.setFechaSolicitud(sqlDate);
                                acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                acuerdoSolicitar.setObservacion(obs);
                                tipoDoc = tipoDao.consultarPorId(134);
                                acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                                documentoDao.solicitarDocumento(acuerdoSolicitar);
                            } else {
                                //ACTUALIZAR
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 134);
                                if (idAcuerdoSolicitado != 0) {
                                    //ACTUALIZAR DOCUMENTO SOLICITADO
                                    acuerdoSolicitar = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                    acuerdoSolicitar.setObservacion(obs);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoSolicitar);
                                } else {
                                    //REALIZAR SOLICITUD
                                    acuerdoSolicitar.setIdDocumento(documentoDao.getSiguienteId());
                                    acuerdoSolicitar.setIdExpediente(expediente);
                                    acuerdoSolicitar.setFechaSolicitud(sqlDate);
                                    acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                    acuerdoSolicitar.setObservacion(obs);
                                    tipoDoc = tipoDao.consultarPorId(134);
                                    acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                                    documentoDao.solicitarDocumento(acuerdoSolicitar);
                                }
                            }// FIN ACTUALIZAR
                            idProgreso = 8;
                            estado = "PENDIENTE";
                            break;
                        case 15:
                            //ACUERDO DE LIBERACION DEL COMPROMISO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                            }// FIN ACTUALIZAR
                            idProgreso = 16;
                            estado = "FINALIZADO";
                            break;
                        case 22:
                            //ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                            }// FIN ACTUALIZAR
                            beca = becaDao.consultarPorExpediente(idExpediente);
                            //obteniendo acuerdo de prorroga de JD
                            idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 140);
                            if (idAcuerdoSolicitado !=0){
                                idProrroga = prorrogaDao.ExisteProrroga(beca.getIdBeca(), idAcuerdoSolicitado);
                                prorroga = prorrogaDao.consultarPorId(idProrroga);
                                beca.setFechaFin(prorroga.getFechaFin());
                                becaDao.actualizar(beca);
                            }
                            idProgreso = 9;
                            estado = "PENDIENTE";
                            break;
                            case 26:
                            //ACUERDO DE LIBERACION DEL COMPROMISO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                            }// FIN ACTUALIZAR
                            idProgreso = 9;
                            estado = "PENDIENTE";
                            break;
                        default:
                            break;
                    } //FIN SWITCH PROGRESO
                    break;
                case "DENEGADO":
                    switch (idProgreso) {
                        case 7:
                            //ACUERDO DE BECA DEL CONSEJO SUPERIOR UNIVERSITARIO
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                                //BORRAR DOCUMENTO SOLICITADO                                
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 134);                                
                                if (idAcuerdoSolicitado != 0){
                                    documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                                } else{
                                    //No se habia solicitado
                                }
                            }// FIN ACTUALIZAR
                            idProgreso = 7;
                            estado = "DENEGADO";
                            break;
                        case 15:
                            //ACUERDO DE LIBERACION DEL COMPROMISO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                //obteniendo ACUERDO DE GESTION DE LIBERACION y cambiando estado a REVISION    
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 157);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    acuerdoAnterior.setObservacion(observacion);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                            } else {
                                //ACTUALIZAR
                                //obteniendo ACUERDO DE GESTION DE LIBERACION y cambiando estado a REVISION    
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 157);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    acuerdoAnterior.setObservacion(observacion);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                            }// FIN ACTUALIZAR
                            idProgreso = 14;
                            estado = "REVISION";
                            break;
                        case 22:
                            //ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                                //REGRESAR FECHA FIN A LA ANTERIOR               
                                beca = becaDao.consultarPorExpediente(idExpediente);
                                idProrroga = prorrogaDao.obtenerProrrogaAprobada(beca.getIdBeca());
                                if(idProrroga !=0){
                                    prorroga = prorrogaDao.consultarPorId(idProrroga);
                                    if(beca.getFechaFin() == prorroga.getFechaFin()){
                                        prorroga.setEstado("DENEGADO");
                                        prorrogaDao.actualizarProrroga(prorroga);
                                        beca.setFechaFin(prorroga.getFechaInicio());
                                    }else{
                                        // FECHA FIN BECA BIEN
                                    }
                                } else{
                                    //No hacer nada
                                }
                            }// FIN ACTUALIZAR
                            idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 141);
                            acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                            acuerdoAnterior.setEstadoDocumento("REVISION");
                            acuerdoAnterior.setObservacion(observacion);
                            documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                            idProgreso = 21;
                            estado = "REVISION";                            
                            break;
                            case 26:
                            //ACUERDO DE AÑO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                //obteniendo ACUERDO DEL CONSEJO DE BECAS y cambiando estado a REVISION    
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 162);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    acuerdoAnterior.setObservacion(observacion);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                            } else {
                                //ACTUALIZAR
                                //obteniendo ACUERDO DEL CONSEJO DE BECAS y cambiando estado a REVISION    
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 162);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    acuerdoAnterior.setObservacion(observacion);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                            }// FIN ACTUALIZAR
                            idProgreso = 25;
                            estado = "REVISION";
                            break;
                        default:
                            break;
                    } //FIN SWITCH PROGRESO
                    break;
                case "CORRECCION":                    
                    String tipoCorreccion = request.getParameter("tipoCorreccion");
                    switch (idProgreso) {
                        case 7:
                            //ACUERDO DE BECA DEL CONSEJO SUPERIOR UNIVERSITARIO
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                if (tipoCorreccion.equals("documento")){
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //obteniendo ACUERDO DE OTORGAMIENTO DE BECA y cambiando estado a REVISION    
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 131);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    acuerdoAnterior.setObservacion(observacion);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                                }else{
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD   
                                    //No EXISTE
                                }
                            } else {
                                //ACTUALIZAR
                                //BORRAR DOCUMENTO SOLICITADO                                
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 134);                                
                                if (idAcuerdoSolicitado != 0){
                                    documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                                } else{
                                    //No se habia solicitado
                                }
                                //obteniendo ACUERDO DE OTORGAMIENTO DE BECA y cambiando estado a REVISION    
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 131);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    acuerdoAnterior.setObservacion(observacion);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                            }// FIN ACTUALIZAR
                            idProgreso =5;
                            estado = "REVISION";
                            break;
                        case 15:
                            //ACUERDO DE LIBERACION DEL COMPROMISO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                if (tipoCorreccion.equals("documento")){
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //obteniendo ACUERDO DE GESTION DE LIBERACION y cambiando estado a REVISION    
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 157);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    acuerdoAnterior.setObservacion(observacion);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                                }else{
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD   
                                    //No EXISTE
                                }
                            } else {
                                //ACTUALIZAR
                                if (tipoCorreccion.equals("documento")){
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //obteniendo ACUERDO DE GESTION DE LIBERACION y cambiando estado a REVISION    
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 157);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    acuerdoAnterior.setObservacion(observacion);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                                }else{
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD   
                                    //No EXISTE
                                }
                            }// FIN ACTUALIZAR
                            idProgreso = 14;
                            estado = "REVISION";
                            break;
                        case 22:
                            //ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                                //REGRESAR FECHA FIN A LA ANTERIOR                                      
                                beca = becaDao.consultarPorExpediente(idExpediente);
                                idProrroga = prorrogaDao.obtenerProrrogaAprobada(beca.getIdBeca());
                                if(idProrroga !=0){
                                    prorroga = prorrogaDao.consultarPorId(idProrroga);
                                    if(beca.getFechaFin() == prorroga.getFechaFin()){
                                        prorroga.setEstado("DENEGADO");
                                        prorrogaDao.actualizarProrroga(prorroga);
                                        beca.setFechaFin(prorroga.getFechaInicio());
                                    }else{
                                        // FECHA FIN BECA BIEN
                                    }
                                } else{
                                    //No hacer nada
                                }
                            }// FIN ACTUALIZAR
                            idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 141);
                            acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                            acuerdoAnterior.setEstadoDocumento("REVISION");
                            acuerdoAnterior.setObservacion(observacion);
                            documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                            idProgreso = 21;
                            estado = "REVISION";
                            break;
                            case 26:
                            //ACUERDO DE AÑO FISCAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                if (tipoCorreccion.equals("documento")){
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //obteniendo ACUERDO DE AÑO FISCAL DEL CONSEJO DE BECAS y cambiando estado a REVISION    
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 162);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    acuerdoAnterior.setObservacion(observacion);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                                }else{
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD   
                                    //No EXISTE
                                }
                            } else {
                                //ACTUALIZAR
                                if (tipoCorreccion.equals("documento")){
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //obteniendo ACUERDO DE AÑO FISCAL DEL CONSEJO DE BECAS y cambiando estado a REVISION    
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 162);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    acuerdoAnterior.setObservacion(observacion);
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                                }else{
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD   
                                    //No EXISTE
                                }
                            }// FIN ACTUALIZAR
                            idProgreso = 25;
                            estado = "REVISION";
                            break;
                        default:
                            break;
                    } //FIN SWITCH PROGRESO
                    break;
                default:
                    Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo resolver la solicitud.");
                    break;
            } //FIN SWITCH RESOLUCION

            //CAMBIAR PROGRESO Y ESTADO
            expediente.setIdProgreso(idProgreso);
            expediente.setEstadoProgreso(estado);
            expDao.actualizarExpediente(expediente);
            
            try{
            //BITACORA Y CORREO-------------------------------------------------
            SolocitudBecaDAO solicitudBecaDao = new SolocitudBecaDAO();
            String nombre_tipo_documento = documento.getIdTipoDocumento().getTipoDocumento();
            int id_usuario_correo = solicitudBecaDao.consultarPorIdExpediente(expediente.getIdExpediente()).getIdUsuario();
            Integer []lista_usuarios = new Integer[1];
            lista_usuarios[0] = id_usuario_correo;
            
            switch (resolucion){
                case "APROBADO":{
                    Utilidades.nuevaBitacora(8, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()), request.getSession().getAttribute("user").toString()+ " aprobo el documento : "+nombre_tipo_documento+".", "");
                    Utilidades.EnviarCorreo("RESOLUCION DE SOLICITUD DE BECA DE POSTGRADO UES", "UNIVERSIDAD DE EL SALVADOR.\n\n"+request.getSession().getAttribute("rol").toString()+" HA APROBADO SU SOLICITUD. \n\n PARA MAS DETALLES CONSULTE: " + Utilidades.ObtenerUrlRaiz(request.getRequestURL().toString()), lista_usuarios);
                    break;
                }
                case "DENEGADO":{
                    Utilidades.nuevaBitacora(9, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()), request.getSession().getAttribute("user").toString()+ " denego el documento : "+nombre_tipo_documento+".", "");
                    Utilidades.EnviarCorreo("RESOLUCION DE SOLICITUD DE BECA DE POSTGRADO UES", "UNIVERSIDAD DE EL SALVADOR.\n\n"+request.getSession().getAttribute("rol").toString()+" HA DENEGADO SU SOLICITUD. \n\n PARA MAS DETALLES CONSULTE: " + Utilidades.ObtenerUrlRaiz(request.getRequestURL().toString()), lista_usuarios);
                    break;
                }
                case "CORRECCION":{
                        if(request.getParameter("tipoCorreccion").equals("documento")){
                            Utilidades.nuevaBitacora(10, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()), request.getSession().getAttribute("user").toString()+ " solicito correccion del documento : "+nombre_tipo_documento+".", "");
                            Utilidades.EnviarCorreo("RESOLUCION DE SOLICITUD DE BECA DE POSTGRADO UES", "UNIVERSIDAD DE EL SALVADOR.\n\n"+request.getSession().getAttribute("rol").toString()+" HA PEDIDO CORRECCION DE SU SOLICITUD. \n\n PARA MAS DETALLES CONSULTE: " + Utilidades.ObtenerUrlRaiz(request.getRequestURL().toString()), lista_usuarios);
                        }else{
                            Utilidades.nuevaBitacora(10, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()), request.getSession().getAttribute("user").toString()+ " solicito correccion del acuerdo.", "");
                        }
                    
                    break;
                }
            }
            }catch(Exception ex){
                ex.printStackTrace();
                System.out.println("Error en bitacora o correos en el consejo superior universitario. "+ex);
            }
            //BITACORA Y CORREO-------------------------------------------------
            
            
            //MOSTRAR MENSAJE DE EXITO
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se resolvio la solicitud satisfactoriamente.");
        } catch (Exception e) {
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo resolver la solicitud.");
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//FALTA 10 Y 20 (ANO FISCAL Y PRORROGA)
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
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
@WebServlet(name = "ResolverAcuerdoJuntaDirectiva", urlPatterns = {"/ResolverAcuerdoJuntaDirectiva"})
@MultipartConfig(maxFileSize = 16177215)
public class ResolverAcuerdoJuntaDirectiva extends HttpServlet {

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
            ProrrogaDAO prorrogaDao = new ProrrogaDAO();
            BecaDAO becaDao = new BecaDAO();
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
            String fechafinProrroga = "";
            int idProrroga = 0;
            switch (resolucion) {
                case "APROBADO":
                    Documento acuerdoSolicitar = new Documento();
                    switch (idProgreso) {
                        case 1:
                            //SOLICITUD DE PERMISO INICIAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                estado = "PENDIENTE";
                            } else {
                                //ACTUALIZAR
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 105);
                                if (idAcuerdoSolicitado != 0) {
                                    estado = "EN PROCESO";
                                    acuerdoSolicitar = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                    documentoDao.ActualizarEstadoDocumento(acuerdoSolicitar);
                                } else {
                                    estado = "PENDIENTE";
                                }
                            }// FIN ACTUALIZAR
                            idProgreso = 2;

                            break;
                        case 4:
                            //ACUERDOS DE PERMISOS DE BECA
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                estado = "PENDIENTE";
                            } else {
                                //ACTUALIZAR                                
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 131);
                                if (idAcuerdoSolicitado != 0) {
                                    estado = "EN PROCESO";
                                    acuerdoSolicitar = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                    documentoDao.ActualizarEstadoDocumento(acuerdoSolicitar);
                                } else {
                                    estado = "PENDIENTE";
                                }
                            }// FIN ACTUALIZAR
                            idProgreso = 5;
                            estado = "PENDIENTE";
                            break;
                        case 10:
                            //ACUERDO DE AÑO FISCAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                            }// FIN ACTUALIZAR
                            idProgreso = 9;
                            estado = "PENDIENTE";
                            break;
                        case 12:
                            //SOLICITUD INICIO DE SERVICIO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                //SOLICITAR ACUERDO AL CONSEJO DE BECAS
                                acuerdoSolicitar.setIdDocumento(documentoDao.getSiguienteId());
                                acuerdoSolicitar.setIdExpediente(expediente);
                                acuerdoSolicitar.setFechaSolicitud(sqlDate);
                                acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                acuerdoSolicitar.setObservacion(obs);
                                tipoDoc = tipoDao.consultarPorId(152);
                                acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                                documentoDao.solicitarDocumento(acuerdoSolicitar);
                            } else {
                                //ACTUALIZAR
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 152);
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
                                    tipoDoc = tipoDao.consultarPorId(152);
                                    acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                                    documentoDao.solicitarDocumento(acuerdoSolicitar);
                                }//FIN idAcuerdoSolicitado                                                               
                            }// FIN ACTUALIZAR
                            idProgreso = 12;
                            estado = "EN PROCESO";
                            break;
                        case 13:
                            //SOLICITUD DE ACUERDO DE GESTION DE COMPROMISO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                estado = "PENDIENTE";
                            } else {
                                //ACTUALIZAR
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 157);
                                if (idAcuerdoSolicitado != 0) {
                                    estado = "EN PROCESO";
                                    acuerdoSolicitar = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                    documentoDao.ActualizarEstadoDocumento(acuerdoSolicitar);
                                } else {
                                    estado = "PENDIENTE";
                                }
                            }// FIN ACTUALIZAR
                            idProgreso = 14;

                            break;
                        case 20:
                            //SOLICITUD DE PRORROGA
                            fechafinProrroga = request.getParameter("fechaCierre");
                            java.sql.Date sqlDate2 = new java.sql.Date(StringAFecha(fechafinProrroga).getTime());
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                //SOLICITAR ACUERDO AL CONSEJO DE BECAS
                                acuerdoSolicitar.setIdDocumento(documentoDao.getSiguienteId());
                                acuerdoSolicitar.setIdExpediente(expediente);
                                acuerdoSolicitar.setFechaSolicitud(sqlDate);
                                acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                acuerdoSolicitar.setObservacion(obs);
                                tipoDoc = tipoDao.consultarPorId(141);
                                acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                                documentoDao.solicitarDocumento(acuerdoSolicitar);
                            } else {
                                //ACTUALIZAR
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 141);
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
                                    tipoDoc = tipoDao.consultarPorId(141);
                                    acuerdoSolicitar.setIdTipoDocumento(tipoDoc);
                                    documentoDao.solicitarDocumento(acuerdoSolicitar);
                                }
                            }// FIN ACTUALIZAR
                            //INGRESAR O ACTUALIZAR PRORROGA EN EL SISTEMA
                            beca = becaDao.consultarPorExpediente(idExpediente);
                            int idProrrogaAnterior = prorrogaDao.ExisteProrrogaAnterior(beca.getIdBeca());
                            idProrroga = prorrogaDao.ExisteProrroga(beca.getIdBeca(), id_documento);
                             if (idProrrogaAnterior != 0) {
                                    Prorroga prorrogaAnterior = prorrogaDao.consultarPorId(idProrrogaAnterior);
                                    prorroga.setFechaInicio(prorrogaAnterior.getFechaFin());
                                } else {
                                    prorroga.setFechaInicio(beca.getFechaFin());
                                }
                            if (idProrroga != 0) {
                                //Actualizar
                                prorroga = prorrogaDao.consultarPorId(idProrroga);                               
                                prorroga.setFechaFin(sqlDate2);
                                prorroga.setEstado("APROBADO");
                                prorrogaDao.actualizarProrroga(prorroga);
                            } else {
                                //ingresar
                                idProrroga = prorrogaDao.getSiguienteId();
                                prorroga.setIdProrroga(idProrroga);
                                prorroga.setIdBeca(beca.getIdBeca());
                                prorroga.setIdDocumento(id_documento);                                
                                prorroga.setFechaFin(sqlDate2);
                                prorroga.setEstado("APROBADO");
                                prorrogaDao.ingresar(prorroga);
                            }
                            idProgreso = 21;
                            estado = "EN PROCESO";
                            break;
                        default:
                            break;
                    } //FIN SWITCH PROGRESO
                    break;
                case "DENEGADO":
                    switch (idProgreso) {
                        case 1:
                            //SOLICITUD DE PERMISO INICIAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 105);
                                if (idAcuerdoSolicitado != 0) {
                                    documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                                }

                            }// FIN ACTUALIZAR
                            idProgreso = 1;
                            estado = "DENEGADO";
                            break;
                        case 4:
                            //ACUERDOS DE PERMISOS DE BECA
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 131);
                                if (idAcuerdoSolicitado != 0) {
                                    documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                                }
                            }// FIN ACTUALIZAR
                            idProgreso = 4;
                            estado = "DENEGADO";
                            break;
                        case 10:
                            //ACUERDO DE AÑO FISCAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                            }// FIN ACTUALIZAR
                            idProgreso = 9;
                            estado = "PENDIENTE";
                            break;
                        case 12:
                            //SOLICITUD INICIO DE SERVICIO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                                idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 152);
                                if (idAcuerdoSolicitado != 0) {
                                    //ELIMINAR DOCUMENTO SOLICITADO    
                                    documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                                } else {
                                    //NADA
                                }//FIN idAcuerdoSolicitado
                            }// FIN ACTUALIZAR
                            idProgreso = 9;
                            estado = "PENDIENTE";
                            break;
                        case 13:
                            //SOLICITUD DE ACUERDO DE GESTION DE COMPROMISO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                            }// FIN ACTUALIZAR
                            estado = "PENDIENTE";
                            break;
                        case 20:
                            //SOLICITUD DE PRORROGA
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                                //ACTUALIZAR ESTADO PRORROGA EN EL SISTEMA
                                beca = becaDao.consultarPorExpediente(idExpediente);
                                idProrroga = prorrogaDao.ExisteProrroga(beca.getIdBeca(), id_documento);
                                if (idProrroga != 0) {
                                    //Actualizar
                                    prorroga = prorrogaDao.consultarPorId(idProrroga);
                                    prorroga.setEstado("DENEGADO");
                                    prorrogaDao.actualizarProrroga(prorroga);
                                } else {
                                    //NO SOLICITAR
                                }
                            }// FIN ACTUALIZAR

                            idProgreso = 9;
                            estado = "PENDIENTE";
                            break;
                        default:
                            break;
                    } //FIN SWITCH PROGRESO
                    break;
                case "CORRECCION":
                    Documento acuerdoAnterior = new Documento();
                    String tipoCorreccion = request.getParameter("tipoCorreccion");
                    switch (idProgreso) {
                        case 1:
                            //SOLICITUD DE PERMISO INICIAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                if (tipoCorreccion.equals("documento")) {
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //no existe documento anteriror
                                } else {
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD
                                    idProgreso = 1;
                                    estado = "CORRECCION";
                                }
                            } else //ACTUALIZAR
                            {
                                if (tipoCorreccion.equals("documento")) {
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //no existe documento anterior
                                } else {
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD
                                    idProgreso = 1;
                                    estado = "CORRECCION";
                                }// FIN ACTUALIZAR
                            }
                            break;
                        case 4:
                            //ACUERDOS DE PERMISOS DE BECA
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                if (tipoCorreccion.equals("documento")) {
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //obteniendo dictamen de becas y cambiando estado a REVISION
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 112);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                                } else {
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD
                                    //no existe solicitud
                                }
                            } else //ACTUALIZAR
                            {
                                if (tipoCorreccion.equals("documento")) {
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //obteniendo dictamen de becas y cambiando estado a REVISION
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 112);
                                    acuerdoAnterior = documentoDao.obtenerInformacionDocumentoPorId(idAcuerdoSolicitado);
                                    acuerdoAnterior.setEstadoDocumento("REVISION");
                                    documentoDao.ActualizarEstadoDocumento(acuerdoAnterior);
                                } else {
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD
                                    //no existe solicitud
                                }// FIN ACTUALIZAR
                            }
                            idProgreso = 3;
                            estado = "REVISION";
                            break;
                        case 10:
                            //ACUERDO DE AÑO FISCAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR
                            }// FIN ACTUALIZAR
                            idProgreso = 10;
                            estado = "CORRECCION";
                            break;
                        case 12:
                            //SOLICITUD INICIO DE SERVICIO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                if (tipoCorreccion.equals("documento")) {
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //no existe
                                } else {
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD                                    
                                }
                                idProgreso = 9;
                                estado = "CORRECCION";
                            } else {
                                //ACTUALIZAR
                                if (tipoCorreccion.equals("documento")) {
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //no existe
                                } else {
                                    //ELIMINAR SOLICITUD DE SIGUIENTE DOCUMENTO REALIZADA
                                    idAcuerdoSolicitado = documentoDao.ExisteDocumento(idExpediente, 152);
                                    if (idAcuerdoSolicitado != 0) {
                                        //ELIMINAR DOCUMENTO SOLICITADO    
                                        documentoDao.eliminarDocumento(idAcuerdoSolicitado);
                                    } else {
                                        //NADA
                                    }//FIN idAcuerdoSolicitado
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD                                    
                                }
                                idProgreso = 9;
                                estado = "CORRECCION";
                            }// FIN ACTUALIZAR
                            break;
                        case 13:
                            //SOLICITUD DE ACUERDO DE GESTION DE COMPROMISO CONTRACTUAL
                            if (accion.equals("insertar")) {
                                //INSERTAR
                                if (tipoCorreccion.equals("documento")) {
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //no existe
                                } else {
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD                                    
                                }
                                idProgreso = 13;
                                estado = "CORRECCION";
                            } else {
                                //ACTUALIZAR
                                if (tipoCorreccion.equals("documento")) {
                                    //REALIZAR SOLICITUD DE REVISION DE DOCUMENTO
                                    //no existe
                                } else {
                                    //REALIZAR SOLICITUD DE CORRECCION DE SOLICITUD                                    
                                }
                                idProgreso = 13;
                                estado = "CORRECCION";
                            }// FIN ACTUALIZAR
                            break;
                        case 20:
                            //SOLICITUD DE PRORROGA
                            if (accion.equals("insertar")) {
                                //INSERTAR
                            } else {
                                //ACTUALIZAR ESTADO PRORROGA EN EL SISTEMA
                                beca = becaDao.consultarPorExpediente(idExpediente);
                                idProrroga = prorrogaDao.ExisteProrroga(beca.getIdBeca(), id_documento);
                                if (idProrroga != 0) {
                                    //Actualizar
                                    prorroga = prorrogaDao.consultarPorId(idProrroga);
                                    prorroga.setEstado("DENEGADO");
                                    prorrogaDao.actualizarProrroga(prorroga);
                                } else {
                                    //NO SOLICITAR
                                }
                            }// FIN ACTUALIZAR
                            idProgreso = 20;
                            estado = "CORRECCION";
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
            //MOSTRAR MENSAJE DE EXITO
                        
            
            //BITACORA Y CORREO-------------------------------------------------
            try{
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
                System.out.println("Error en bitacora o correos en junta directiva. "+ex);
            }
            //BITACORA Y CORREO-------------------------------------------------
            
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se resolvio la solicitud satisfactoriamente.");
        } catch (Exception e) {
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo resolver la solicitud.");
        }
    }

    public Date StringAFecha(String Sfecha) {
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
        Date fecha = null;
        try {
            fecha = formatoDelTexto.parse(Sfecha);
        } catch (ParseException ex) {

            ex.printStackTrace();

        }
        System.out.println("fechanice!");
        return fecha;
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

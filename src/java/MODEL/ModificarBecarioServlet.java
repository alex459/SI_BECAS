/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.BecaDAO;
import DAO.DocumentoDAO;
import DAO.SolocitudBecaDAO;
import DAO.ExpedienteDAO;
import DAO.OfertaBecaDAO;
import DAO.TipoDocumentoDAO;
import DAO.UsuarioDAO;
import POJO.Beca;
import POJO.Documento;
import POJO.Expediente;
import POJO.SolicitudDeBeca;
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
@WebServlet(name = "ModificarBecarioServlet", urlPatterns = {"/ModificarBecarioServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class ModificarBecarioServlet extends HttpServlet {

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
            //Recuperar accion
            String accion = request.getParameter("accion");
            int idExpediente = Integer.parseInt(request.getParameter("id_Expediente"));
            SolicitudDeBeca solicitud = new SolicitudDeBeca();
            SolocitudBecaDAO solicitudDao = new SolocitudBecaDAO();
            Expediente expediente = new Expediente();
            ExpedienteDAO expedienteDao = new ExpedienteDAO();

            if (accion.equals("becario")) {
                //Editar el becario
                UsuarioDAO usuarioDao = new UsuarioDAO();
                //Obteniendo el idUsuario
                int idUsuario = Integer.parseInt(request.getParameter("ID_USUARIO"));
                //Obteniendo la solicitud de beca                
                solicitud = solicitudDao.consultarPorIdExpediente(idExpediente);
                if (solicitud.getIdSolicitud() != 0) {
                    //Actualizar Becario
                    int idBecarioActual = solicitud.getIdUsuario();
                    solicitud.setIdUsuario(idUsuario);
                    solicitudDao.actualizar(solicitud);
                    //Agregar el nuevo becario
                    usuarioDao.actualizarRolPorIdUsuario(idUsuario, 2);
                    //Borrar becario Actual                    
                    expediente = expedienteDao.consultarPorId(idExpediente);
                    if (expediente.getEstadoExpediente().equals("ABIERTO")) {
                        //Cambiar Becario Actual a Candidato                        
                        usuarioDao.actualizarRolPorIdUsuario(idBecarioActual, 1);
                    } else {
                        //Beca cerrada no hacer nada
                    }
                    //Mensaje de Exito
                    Utilidades.mostrarMensaje(response, 1, "Exito", "Se Actualizó el becario satisfactoriamente.");
                } else {
                    //Mostrar mensaje de error
                    Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo Actualizar el becario.");
                }
            } else {
                //Editar Expediente o datos de la beca
                try {
                    int idOferta = Integer.parseInt(request.getParameter("oferta"));
                    String fechaInicioBeca = request.getParameter("fechaInicio");
                    String fechaFinBeca = request.getParameter("fechaFin");
                    String estado = request.getParameter("estado");

                    //Obteniendo Solicitud de Beca y Beca
                    solicitud = solicitudDao.consultarPorIdExpediente(idExpediente);
                    BecaDAO becaDao = new BecaDAO();
                    Beca beca = new Beca();
                    beca = becaDao.consultarPorExpediente(idExpediente);

                    //Actualizando Solicitud de Beca
                    solicitud.setIdOfertaBeca(idOferta);
                    solicitudDao.actualizar(solicitud);

                    //Actualizando Beca
                    java.sql.Date fechaInicio = new java.sql.Date(StringAFecha(fechaInicioBeca).getTime());
                    java.sql.Date fechaFin = new java.sql.Date(StringAFecha(fechaFinBeca).getTime());
                    beca.setFechaInicio(fechaInicio);
                    beca.setFechaFin(fechaFin);
                    becaDao.actualizar(beca);

                    //Obtener Expediente
                    expediente = expedienteDao.consultarPorId(idExpediente);

                    //Obtener el progreso nuevo
                    int idProgresoNuevo = 0;
                    switch (estado) {
                        case "estudio":
                            idProgresoNuevo = 9;
                            break;
                        case "servicio":
                            idProgresoNuevo = 12;
                            break;
                        case "compromiso":
                            idProgresoNuevo = 13;
                            break;
                        case "liberacion":
                            idProgresoNuevo = 14;
                            break;
                        case "becaFinalizada":
                            idProgresoNuevo = 16;
                            break;
                        case "reintegro":
                            idProgresoNuevo = 23;
                            break;
                        case "finReintegro":
                            idProgresoNuevo = 16;
                            break;
                    }

                    //Comparar progreso Anterior con el nuevo
                    DocumentoDAO documentoDao = new DocumentoDAO();
                    int idProgresoAnterior = expediente.getIdProgreso();
                    if (idProgresoAnterior != idProgresoNuevo) {
                        //Borrar documentos demas
                        documentoDao.eliminarDocumentosExpediente(idExpediente);
                    }

                    //Actualizando los Documentos
                    int idDocumento = 0; //Para obtener Tipo de Documento
                    int id_documento = 0; //Para ver si existe                                       
                    Documento documento = new Documento();
                    InputStream archivo = null;
                    Part filePart = null;
                    Date fechaHoy = new Date();
                    java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
                    TipoDocumento tipo = new TipoDocumento();
                    TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
                    String obs = "";
                    int idDoc = 0;

                    //Acuerdo de Permiso de Gestion de Beca
                    String accpermisoGestion = request.getParameter("accpermisoGestion");
                    idDocumento = 103;
                    switch (accpermisoGestion) {
                        case "ninguna":
                            //No hacer nada
                            break;
                        case "eliminar":
                            //Obteniendo el id del documento
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                            filePart = request.getPart("permisoGestion");
                            if (filePart != null) {
                                archivo = filePart.getInputStream();
                            }
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                            if (id_documento != 0) {
                                //Actualizar
                                documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                documento.setDocumentoDigital(archivo);
                                documento.setFechaIngreso(sqlDate);
                                documentoDao.ActualizarDocDig(documento);
                            } else {
                                //Agregar
                                idDoc = documentoDao.getSiguienteId();
                                obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                tipo = tipoDao.consultarPorId(idDocumento);

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

                    //Acuerdo de Autorización inicial
                    String accautorizacionInicial = request.getParameter("accautorizacionInicial");
                    idDocumento = 105;
                    switch (accautorizacionInicial) {
                        case "ninguna":
                            //No hacer nada
                            break;
                        case "eliminar":
                            //Obteniendo el id del documento
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                            filePart = request.getPart("autorizacionInicial");
                            if (filePart != null) {
                                archivo = filePart.getInputStream();
                            }
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                            if (id_documento != 0) {
                                //Actualizar
                                documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                documento.setDocumentoDigital(archivo);
                                documento.setFechaIngreso(sqlDate);
                                documentoDao.ActualizarDocDig(documento);
                            } else {
                                //Agregar
                                idDoc = documentoDao.getSiguienteId();
                                obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                tipo = tipoDao.consultarPorId(idDocumento);

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

                    //Dictamen de Propuesta ante Junta Directiva
                    String accdictamen = request.getParameter("accdictamen");
                    idDocumento = 112;
                    switch (accdictamen) {
                        case "ninguna":
                            //No hacer nada
                            break;
                        case "eliminar":
                            //Obteniendo el id del documento
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                            filePart = request.getPart("dictamen");
                            if (filePart != null) {
                                archivo = filePart.getInputStream();
                            }
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                            if (id_documento != 0) {
                                //Actualizar
                                documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                documento.setDocumentoDigital(archivo);
                                documento.setFechaIngreso(sqlDate);
                                documentoDao.ActualizarDocDig(documento);
                            } else {
                                //Agregar
                                idDoc = documentoDao.getSiguienteId();
                                obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                tipo = tipoDao.consultarPorId(idDocumento);

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

                    //Acuerdo de Permiso de Beca de Junta Directiva
                    String accacuerdoBecaJD = request.getParameter("accacuerdoBecaJD");
                    OfertaBecaDAO ofertaDao = new OfertaBecaDAO();
                    String TipoBeca = ofertaDao.ObtenerTipoBeca(idExpediente);
                    if (TipoBeca.equals("INTERNA")) {
                        idDocumento = 120;
                    } else {
                        idDocumento = 121;
                    }
                    switch (accacuerdoBecaJD) {
                        case "ninguna":
                            //No hacer nada
                            break;
                        case "eliminar":
                            //Obteniendo el id del documento
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                            filePart = request.getPart("acuerdoBecaJD");
                            if (filePart != null) {
                                archivo = filePart.getInputStream();
                            }
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                            if (id_documento != 0) {
                                //Actualizar
                                documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                documento.setDocumentoDigital(archivo);
                                documento.setFechaIngreso(sqlDate);
                                documentoDao.ActualizarDocDig(documento);
                            } else {
                                //Agregar
                                idDoc = documentoDao.getSiguienteId();
                                obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                tipo = tipoDao.consultarPorId(idDocumento);

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

                    //Acuerdo de Otorgamiento de Beca
                    String accacuerdoBecaCNB = request.getParameter("accacuerdoBecaCNB");
                    idDocumento = 131;
                    switch (accacuerdoBecaCNB) {
                        case "ninguna":
                            //No hacer nada
                            break;
                        case "eliminar":
                            //Obteniendo el id del documento
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                            filePart = request.getPart("acuerdoBecaCNB");
                            if (filePart != null) {
                                archivo = filePart.getInputStream();
                            }
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                            if (id_documento != 0) {
                                //Actualizar
                                documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                documento.setDocumentoDigital(archivo);
                                documento.setFechaIngreso(sqlDate);
                                documentoDao.ActualizarDocDig(documento);
                            } else {
                                //Agregar
                                idDoc = documentoDao.getSiguienteId();
                                obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                tipo = tipoDao.consultarPorId(idDocumento);

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

                    //Acuerdo de Permiso de Beca Consejo Superior Universitario                    
                    String accacuerdoBecaCSU = request.getParameter("accacuerdoBecaCSU");
                    if (TipoBeca.equals("INTERNA")) {
                        idDocumento = 132;
                    } else {
                        idDocumento = 133;
                    }
                    switch (accacuerdoBecaCSU) {
                        case "ninguna":
                            //No hacer nada
                            break;
                        case "eliminar":
                            //Obteniendo el id del documento
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                            filePart = request.getPart("acuerdoBecaCSU");
                            if (filePart != null) {
                                archivo = filePart.getInputStream();
                            }
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                            if (id_documento != 0) {
                                //Actualizar
                                documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                documento.setDocumentoDigital(archivo);
                                documento.setFechaIngreso(sqlDate);
                                documentoDao.ActualizarDocDig(documento);
                            } else {
                                //Agregar
                                idDoc = documentoDao.getSiguienteId();
                                obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                tipo = tipoDao.consultarPorId(idDocumento);

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

                    //Contrato de Beca
                    String acccontrato = request.getParameter("acccontrato");
                    idDocumento = 134;
                    switch (acccontrato) {
                        case "ninguna":
                            //No hacer nada
                            break;
                        case "eliminar":
                            //Obteniendo el id del documento
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                            filePart = request.getPart("contrato");
                            if (filePart != null) {
                                archivo = filePart.getInputStream();
                            }
                            id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                            if (id_documento != 0) {
                                //Actualizar
                                documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                documento.setDocumentoDigital(archivo);
                                documento.setFechaIngreso(sqlDate);
                                documentoDao.ActualizarDocDig(documento);
                            } else {
                                //Agregar
                                idDoc = documentoDao.getSiguienteId();
                                obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                tipo = tipoDao.consultarPorId(idDocumento);

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

                    //Ingreso de documentos por proceso
                    switch (estado) {
                        case "estudio":
                            break;
                        case "servicio":
                            //Titulo Obtenido
                            String acctituloObtenido = request.getParameter("acctituloObtenido");
                            idDocumento = 143;
                            switch (acctituloObtenido) {
                                case "ninguna":
                                    //No hacer nada
                                    break;
                                case "eliminar":
                                    //Obteniendo el id del documento
                                    id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                                    filePart = request.getPart("tituloObtenido");
                                    if (filePart != null) {
                                        archivo = filePart.getInputStream();
                                    }
                                    id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                                    if (id_documento != 0) {
                                        //Actualizar
                                        documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                        documento.setDocumentoDigital(archivo);
                                        documento.setFechaIngreso(sqlDate);
                                        documentoDao.ActualizarDocDig(documento);
                                    } else {
                                        //Agregar
                                        idDoc = documentoDao.getSiguienteId();
                                        obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                        tipo = tipoDao.consultarPorId(idDocumento);

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
                            
                            //Certificación De Notas
                            String acccertificacionNotasFin = request.getParameter("acccertificacionNotasFin");
                            idDocumento = 144;
                            switch (acccertificacionNotasFin) {
                                case "ninguna":
                                    //No hacer nada
                                    break;
                                case "eliminar":
                                    //Obteniendo el id del documento
                                    id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                                    filePart = request.getPart("certificacionNotasFin");
                                    if (filePart != null) {
                                        archivo = filePart.getInputStream();
                                    }
                                    id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                                    if (id_documento != 0) {
                                        //Actualizar
                                        documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                        documento.setDocumentoDigital(archivo);
                                        documento.setFechaIngreso(sqlDate);
                                        documentoDao.ActualizarDocDig(documento);
                                    } else {
                                        //Agregar
                                        idDoc = documentoDao.getSiguienteId();
                                        obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                        tipo = tipoDao.consultarPorId(idDocumento);

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
                            
                            //Acta De Evaluación De Tesis
                            String accactaEvaluacion = request.getParameter("accactaEvaluacion");
                            idDocumento = 145;
                            switch (accactaEvaluacion) {
                                case "ninguna":
                                    //No hacer nada
                                    break;
                                case "eliminar":
                                    //Obteniendo el id del documento
                                    id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                                    filePart = request.getPart("actaEvaluacion");
                                    if (filePart != null) {
                                        archivo = filePart.getInputStream();
                                    }
                                    id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                                    if (id_documento != 0) {
                                        //Actualizar
                                        documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                        documento.setDocumentoDigital(archivo);
                                        documento.setFechaIngreso(sqlDate);
                                        documentoDao.ActualizarDocDig(documento);
                                    } else {
                                        //Agregar
                                        idDoc = documentoDao.getSiguienteId();
                                        obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                        tipo = tipoDao.consultarPorId(idDocumento);

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
                            
                            //Constancia de Egresado
                            String accconstanciaEgresado = request.getParameter("accconstanciaEgresado");
                            idDocumento = 146;
                            switch (accconstanciaEgresado) {
                                case "ninguna":
                                    //No hacer nada
                                    break;
                                case "eliminar":
                                    //Obteniendo el id del documento
                                    id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
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
                                    filePart = request.getPart("constanciaEgresado");
                                    if (filePart != null) {
                                        archivo = filePart.getInputStream();
                                    }
                                    id_documento = documentoDao.ExisteDocumento(idExpediente, idDocumento);
                                    if (id_documento != 0) {
                                        //Actualizar
                                        documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
                                        documento.setDocumentoDigital(archivo);
                                        documento.setFechaIngreso(sqlDate);
                                        documentoDao.ActualizarDocDig(documento);
                                    } else {
                                        //Agregar
                                        idDoc = documentoDao.getSiguienteId();
                                        obs = "DOCUMENTO DE BECARIO AGREGADO AL SISTEMA MANUALMENTE";
                                        tipo = tipoDao.consultarPorId(idDocumento);

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
                            
                            
                            break;
                        case "compromiso":
                            idProgresoNuevo = 13;
                            break;
                        case "liberacion":
                            idProgresoNuevo = 14;
                            break;
                        case "becaFinalizada":
                            idProgresoNuevo = 16;
                            break;
                        case "reintegro":
                            idProgresoNuevo = 23;
                            break;
                        case "finReintegro":
                            idProgresoNuevo = 16;
                            break;
                    }

                    //Mostrar mensaje de Exito
                    Utilidades.mostrarMensaje(response, 1, "Exito", "Se actualizó el becario satisfactoriamente.");
                } catch (Exception e) {
                    e.printStackTrace();
                    //Mostrar mensaje de error
                    Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo Actualizar el becario.");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            //Mostrar mensaje de error
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo Actualizar el becario.");
        }
    }

    //Metodo que permite convertir un texto en fecha
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

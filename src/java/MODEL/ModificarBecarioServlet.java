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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
                    String estadoExpediente = "";
                    switch (estado) {
                        case "estudio":
                            idProgresoNuevo = 9;
                            estadoExpediente = "ABIERTO";
                            break;
                        case "servicio":
                            idProgresoNuevo = 12;
                            estadoExpediente = "ABIERTO";
                            break;
                        case "compromiso":
                            idProgresoNuevo = 13;
                            estadoExpediente = "ABIERTO";
                            break;
                        case "liberacion":
                            idProgresoNuevo = 14;
                            estadoExpediente = "ABIERTO";
                            break;
                        case "becaFinalizada":
                            idProgresoNuevo = 16;
                            estadoExpediente = "CERRADO";
                            break;
                        case "reintegro":
                            idProgresoNuevo = 23;
                            estadoExpediente = "ABIERTO";
                            break;
                        case "finReintegro":
                            idProgresoNuevo = 16;
                            estadoExpediente = "CERRADO";
                            break;
                    }

                    //Comparar progreso Anterior con el nuevo
                    DocumentoDAO documentoDao = new DocumentoDAO();
                    int idProgresoAnterior = expediente.getIdProgreso();
                    if (idProgresoAnterior != idProgresoNuevo) {
                        if (idProgresoAnterior > idProgresoNuevo) {
                            List<Integer> documentosDemas = new ArrayList();
                            switch (idProgresoNuevo) {
                                case 9:
                                    documentosDemas.add(143);
                                    documentosDemas.add(144);
                                    documentosDemas.add(145);
                                    documentosDemas.add(146);
                                    documentosDemas.add(147);
                                    documentosDemas.add(148);
                                    documentosDemas.add(154);
                                    documentosDemas.add(155);
                                    documentosDemas.add(157);
                                    documentosDemas.add(158);
                                    documentosDemas.add(159);
                                    break;
                                case 12:
                                    documentosDemas.add(154);
                                    documentosDemas.add(155);
                                    documentosDemas.add(157);
                                    documentosDemas.add(158);
                                    documentosDemas.add(159);
                                    break;
                                case 13:
                                    documentosDemas.add(155);
                                    documentosDemas.add(157);
                                    documentosDemas.add(158);
                                    documentosDemas.add(159);
                                    break;
                                case 14:
                                    documentosDemas.add(157);
                                    documentosDemas.add(158);
                                    documentosDemas.add(159);
                                    break;
                                case 16:
                                    //Fin reintegro
                                    if (estado.equals("finReintegro")) {
                                        //nada
                                    } else {
                                        documentosDemas.add(157);
                                    }
                                    break;
                                case 23:
                                    //Solicitar Reintegro
                                    TipoDocumento tipoDocumento = new TipoDocumento();
                                    TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
                                    Documento acuerdoSolicitar = new Documento();
                                    String obs = "LA BECA HA EXPIRADO";
                                    tipoDocumento = tipoDao.consultarPorId(159);
                                    int idDoc = documentoDao.getSiguienteId();
                                    Date fechaActual = new Date();
                                    java.sql.Date hoy = new java.sql.Date(fechaActual.getTime());
                                    int idActa = documentoDao.ExisteDocumento(idExpediente, 159);
                                    if (idActa == 0) {
                                        acuerdoSolicitar.setIdDocumento(idDoc);
                                        acuerdoSolicitar.setIdExpediente(expediente);
                                        acuerdoSolicitar.setFechaSolicitud(hoy);
                                        acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                        acuerdoSolicitar.setObservacion(obs);
                                        acuerdoSolicitar.setIdTipoDocumento(tipoDocumento);
                                        documentoDao.solicitarDocumento(acuerdoSolicitar);
                                    } else {
                                        acuerdoSolicitar = documentoDao.obtenerInformacionDocumentoPorId(idActa);
                                        acuerdoSolicitar.setFechaSolicitud(hoy);
                                        acuerdoSolicitar.setEstadoDocumento("PENDIENTE");
                                        acuerdoSolicitar.setObservacion(obs);
                                        documentoDao.ActualizarResolverCorreccion(acuerdoSolicitar);
                                    }
                                    break;
                            }
                            //Borrar documentos demas
                            int idDocumento = 0;
                            for (int i = 0; i < documentosDemas.size(); i++) {
                                //Existe documento
                                idDocumento = documentoDao.ExisteDocumento(idExpediente, documentosDemas.get(i));
                                if (idDocumento != 0) {
                                    documentoDao.eliminarDocumento(idDocumento);
                                }
                            }
                        }

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

                            //Acta De Toma De Posesión
                            String acctomaPosesion = request.getParameter("acctomaPosesion");
                            idDocumento = 147;
                            switch (acctomaPosesion) {
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
                                    filePart = request.getPart("tomaPosesion");
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

                            //Proyecto mediante el cual se compromete a multiplicar los conocimientos adquiridos durante la beca
                            String accproyecto = request.getParameter("accproyecto");
                            idDocumento = 148;
                            switch (accproyecto) {
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
                                    filePart = request.getPart("proyecto");
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

                            //Carta De Oficina De RRHH que cumplió con el tiempo acordado
                            String acccartaRRHH = request.getParameter("acccartaRRHH");
                            idDocumento = 154;
                            switch (acccartaRRHH) {
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
                                    filePart = request.getPart("cartaRRHH");
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
                        case "liberacion":
                            //Acuerdo de Gestión de Compromiso Contractual
                            String accacuerdoGestionContractual = request.getParameter("accacuerdoGestionContractual");
                            idDocumento = 155;
                            switch (accacuerdoGestionContractual) {
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
                                    filePart = request.getPart("acuerdoGestionContractual");
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
                        case "becaFinalizada":
                            //Titulo Obtenido
                            acctituloObtenido = request.getParameter("acctituloObtenido");
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
                            acccertificacionNotasFin = request.getParameter("acccertificacionNotasFin");
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
                            accactaEvaluacion = request.getParameter("accactaEvaluacion");
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
                            accconstanciaEgresado = request.getParameter("accconstanciaEgresado");
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

                            //Acta De Toma De Posesión
                            acctomaPosesion = request.getParameter("acctomaPosesion");
                            idDocumento = 147;
                            switch (acctomaPosesion) {
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
                                    filePart = request.getPart("tomaPosesion");
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

                            //Proyecto mediante el cual se compromete a multiplicar los conocimientos adquiridos durante la beca
                            accproyecto = request.getParameter("accproyecto");
                            idDocumento = 148;
                            switch (accproyecto) {
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
                                    filePart = request.getPart("proyecto");
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

                            //Carta De Oficina De RRHH que cumplió con el tiempo acordado
                            acccartaRRHH = request.getParameter("acccartaRRHH");
                            idDocumento = 154;
                            switch (acccartaRRHH) {
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
                                    filePart = request.getPart("cartaRRHH");
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

                            //Acuerdo de Gestión de Compromiso Contractual
                            accacuerdoGestionContractual = request.getParameter("accacuerdoGestionContractual");
                            idDocumento = 155;
                            switch (accacuerdoGestionContractual) {
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
                                    filePart = request.getPart("acuerdoGestionContractual");
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

                            //Acuerdo de Gestión de Liberación
                            String accacuerdoGestionLiberacion = request.getParameter("accacuerdoGestionLiberacion");
                            idDocumento = 157;
                            switch (accacuerdoGestionLiberacion) {
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
                                    filePart = request.getPart("acuerdoGestionLiberacion");
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

                            //Acuerdo de Liberacion del Compromiso Contractual
                            String accacuerdoLiberacion = request.getParameter("accacuerdoLiberacion");
                            idDocumento = 158;
                            switch (accacuerdoLiberacion) {
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
                                    filePart = request.getPart("acuerdoLiberacion");
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
                        case "reintegro":
                            break;
                        case "finReintegro":
                            //Acta de Reintegro de Beca
                            String accactaReintegro = request.getParameter("accactaReintegro");
                            idDocumento = 159;
                            switch (accactaReintegro) {
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
                                    filePart = request.getPart("actaReintegro");
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

                            //Acuerdo de Gestión de Liberación
                            String accacuerdoGestionLiberacion2 = request.getParameter("accacuerdoGestionLiberacion2");
                            idDocumento = 157;
                            switch (accacuerdoGestionLiberacion2) {
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
                                    filePart = request.getPart("acuerdoGestionLiberacion2");
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

                            //Acuerdo de Liberacion del Compromiso Contractual
                            String accacuerdoLiberacion2 = request.getParameter("accacuerdoLiberacion2");
                            idDocumento = 158;
                            switch (accacuerdoLiberacion2) {
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
                                    filePart = request.getPart("acuerdoLiberacion2");
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
                    }
                    
                    //Actualizar Expediente                    
                                expediente.setIdProgreso(idProgresoNuevo);
                                expediente.setEstadoExpediente(estadoExpediente);
                                expedienteDao.actualizarExpediente(expediente);
                                if (estadoExpediente.equals("ABIERTO")){
                                    //Actualizar de candidato a becario
                                    UsuarioDAO usuarioDao = new UsuarioDAO();
                                    usuarioDao.actualizarRolPorIdUsuario(solicitud.getIdUsuario(), 2);
                                } else{
                                    //Actualizar de becario a candidato
                                    UsuarioDAO usuarioDao = new UsuarioDAO();
                                    usuarioDao.actualizarRolPorIdUsuario(solicitud.getIdUsuario(), 1);
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

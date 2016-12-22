/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.UsuarioDAO;
import DAO.BecaDAO;
import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import DAO.OfertaBecaDAO;
import DAO.TipoDocumentoDAO;
import POJO.Beca;
import POJO.Documento;
import POJO.Expediente;
import POJO.OfertaBeca;
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
@WebServlet(name = "ResolverContratoFiscalia", urlPatterns = {"/ResolverContratoFiscalia"})
@MultipartConfig(maxFileSize = 16177215)
public class ResolverContratoFiscalia extends HttpServlet {

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
            //Recuperando informacion
            String resolucion = request.getParameter("resolucion");
            String observacion = request.getParameter("observacion");
            String accion = request.getParameter("accion");
            Integer idExpediente = Integer.parseInt(request.getParameter("id_ex"));
            InputStream archivo = null;
            Part filePart = request.getPart("doc_digital");
            if (filePart != null) {
                archivo = filePart.getInputStream();
            }

            Documento documento = new Documento();
            DocumentoDAO documentoDao = new DocumentoDAO();
            TipoDocumento tipoDoc = new TipoDocumento();
            TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
            ExpedienteDAO expDao = new ExpedienteDAO();
            OfertaBecaDAO ofertaDao = new OfertaBecaDAO();
            BecaDAO becaDao = new BecaDAO();
            Beca beca = new Beca();
            UsuarioDAO usuarioDao = new UsuarioDAO();
            boolean exitoBeca = false;
            //Obteniendo el tipo de beca

            String TipoBeca = ofertaDao.ObtenerTipoBeca(idExpediente);
            Expediente expediente = expDao.consultarPorId(idExpediente);
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());

            //Obteniendo Documento a resolver
            Integer id_documento = documentoDao.ExisteDocumento(idExpediente, 134);
            documento = documentoDao.obtenerInformacionDocumentoPorId(id_documento);
            documento.setEstadoDocumento(resolucion);
            documento.setObservacion(observacion);
            String obs = documento.getObservacion();
            switch (resolucion) {
                case "APROBADO":
                    //Actualizar Documento y solicitar el nuevo
                    documento.setDocumentoDigital(archivo);
                    documentoDao.ActualizarResolver(documento);
                    if (accion.equals("insertar")) {
                        //CREAR LA BECA
                        Integer idOferta = ofertaDao.consultarPorExpediente(idExpediente);
                        OfertaBeca oferta = ofertaDao.consultarPorId(idOferta);
                        beca.setIdBeca(becaDao.getSiguienteId());
                        beca.setFechaInicio(oferta.getFechaInicio());
                        ///////////SUMARLE DURACION A FECHA INICIO
                        beca.setFechaFin(oferta.getFechaInicio());
                        beca.setIdExpediente(idExpediente);
                        exitoBeca = becaDao.ingresar(beca);
                        //CAMBIAR EL ESTADO A BECARIO
                        Integer IdUsuario = becaDao.consultarIdUsuarioPorIdExpediente(idExpediente);
                        usuarioDao.actualizarRolPorIdUsuario(IdUsuario, 2);
                    } else {

                    }

                    //CAMBIAR PROGRESO Y ESTADO DE EXPEDIENTE
                    expediente.setIdProgreso(9);
                    expediente.setEstadoProgreso("PENDIENTE");
                    expDao.actualizarExpediente(expediente);
                    break;
                case "DENEGADO":
                    //Actualizar Documento y poner el progreso como denegado
                    documento.setDocumentoDigital(archivo);
                    documentoDao.ActualizarResolver(documento);
                    //Insercion o Actualizacion
                    if (accion.equals("insertar")) {
                        //CAMBIAR ESTADO DE EXPEDIENTE A DENEGADO
                    } else {
                        //ELIMINAR LA BECA CREADA
                        //CAMBIAR EL ESTADO A CANDIDATO
                    }
                    //CAMBIAR PROGRESO Y ESTADO DE EXPEDIENTE
                    expediente.setIdProgreso(8);
                    expediente.setEstadoProgreso("DENEGADO");
                    expDao.actualizarExpediente(expediente);
                    break;
                case "CORRECCION":
                    //Actualizar documento anterior a correccion y cambiar progreso al anterior
                    if (accion.equals("insertar")) {
                        //NO SE HABIA CREADO BECA
                    } else {
                        //ELIMINAR LA BECA CREADA (CASO DE QUE SE HAYA APROBADO ANTES)
                        //CAMBIAR EL ESTADO A CANDIDATO
                    }
                    //CAMBIAR PROGRESO Y ESTADO DE EXPEDIENTE
                    expediente.setIdProgreso(7);
                    expediente.setEstadoProgreso("REVISION");
                    expDao.actualizarExpediente(expediente);
                    break;
                default:
                    break;
            }

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

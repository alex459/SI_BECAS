/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.BecaDAO;
import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import DAO.OfertaBecaDAO;
import DAO.UsuarioDAO;
import POJO.Beca;
import POJO.Documento;
import POJO.Expediente;
import POJO.OfertaBeca;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "ResolverInicioBeca", urlPatterns = {"/ResolverInicioBeca"})
public class ResolverInicioBeca extends HttpServlet {

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
            //RECUPERANDO INFORMACION DEL JSP
            String resolucion = request.getParameter("resolucion");
            String observacion = "";
            Integer idDocumento = Integer.parseInt(request.getParameter("id_documento"));

            //Obteniendo el expediente
            DocumentoDAO documentoDao = new DocumentoDAO();
            Integer idExpediente = documentoDao.ObtenerIdExpedientePorIdDocumento(idDocumento);
            ExpedienteDAO expDao = new ExpedienteDAO();
            Expediente expediente = expDao.consultarPorId(idExpediente);

            if (resolucion.equals("APROBADO")) {
                //CREAR LA BECA
                OfertaBecaDAO ofertaDao = new OfertaBecaDAO();
                Integer idOferta = ofertaDao.consultarPorExpediente(idExpediente);
                OfertaBeca oferta = ofertaDao.consultarPorId(idOferta);
                BecaDAO becaDao = new BecaDAO();
                Beca beca = new Beca();
                UsuarioDAO usuarioDao = new UsuarioDAO();
                beca.setIdBeca(becaDao.getSiguienteId());
                beca.setFechaInicio(oferta.getFechaInicio());
                ///////////SUMARLE DURACION A FECHA INICIO
                Date fecha = oferta.getFechaInicio();
                Calendar cal = Calendar.getInstance();
                cal.setTime(fecha);
                cal.add(Calendar.MONTH, oferta.getDuracion());
                Date nuevaFecha = cal.getTime();
                java.sql.Date fechaFin = new java.sql.Date(nuevaFecha.getTime());
                beca.setFechaFin(fechaFin);
                beca.setIdExpediente(idExpediente);
                boolean exitoBeca = becaDao.ingresar(beca);
                //CAMBIAR EL ESTADO A BECARIO
                Integer IdUsuario = becaDao.consultarIdUsuarioPorIdExpediente(idExpediente);
                usuarioDao.actualizarRolPorIdUsuario(IdUsuario, 2);
                //CAMBIAR PROGRESO Y ESTADO DE EXPEDIENTE
                expediente.setIdProgreso(9);
                expediente.setEstadoProgreso("PENDIENTE");
                expDao.actualizarExpediente(expediente);
            } else {
                //Solicitar Correccion
                //CAMBIAR ESTADO DE DOCUMENTO
                Documento contrato = new Documento();
                contrato = documentoDao.obtenerInformacionDocumentoPorId(idDocumento);
                contrato.setEstadoDocumento("REVISION");
                documentoDao.ActualizarEstadoDocumento(contrato);
                //CAMBIAR PROGRESO Y ESTADO EXPEDIENTE
                expediente.setIdProgreso(8);
                expediente.setEstadoProgreso("REVISION");
                expDao.actualizarExpediente(expediente);
            }
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se resolvio la solicitud satisfactoriamente.");
        } catch (Exception e) {
            e.printStackTrace();
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

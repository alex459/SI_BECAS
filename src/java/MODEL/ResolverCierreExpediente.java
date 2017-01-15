/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.BecaDAO;
import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import DAO.UsuarioDAO;
import POJO.Documento;
import POJO.Expediente;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "ResolverCierreExpediente", urlPatterns = {"/ResolverCierreExpediente"})
public class ResolverCierreExpediente extends HttpServlet {

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
        try{
            //RECUPERANDO INFORMACION DEL JSP
            String resolucion = request.getParameter("resolucion");
            String observacion ="";
            Integer idDocumento = Integer.parseInt(request.getParameter("id_documento"));
            
            //Obteniendo el expediente
            DocumentoDAO documentoDao = new DocumentoDAO();
            Integer idExpediente = documentoDao.ObtenerIdExpedientePorIdDocumento(idDocumento);
            ExpedienteDAO expDao = new ExpedienteDAO();
            Expediente expediente = expDao.consultarPorId(idExpediente);
            boolean exitoActExpediente = false;
            
            if (resolucion.equals("CERRAR")){
                //Cerrar Expediente
                expediente.setEstadoExpediente("CERRADO");
                exitoActExpediente = expDao.actualizarExpediente(expediente);
                //Cambiar estado a Candidato
                 BecaDAO becaDao = new BecaDAO();
                Integer IdUsuario = becaDao.consultarIdUsuarioPorIdExpediente(idExpediente);
                UsuarioDAO usuarioDao = new UsuarioDAO();
                usuarioDao.actualizarRolPorIdUsuario(IdUsuario, 2);
            }else{
                //Solicitar Correccion 
                Documento acuerdo = documentoDao.obtenerInformacionDocumentoPorId(idDocumento);
                acuerdo.setEstadoDocumento("REVISION");
                acuerdo.setObservacion(observacion);
                boolean exitoActEstado =documentoDao.ActualizarEstadoDocumento(acuerdo);
                if(expediente.getIdProgreso() == 16){
                expediente.setIdProgreso(15);
                }

                expediente.setEstadoProgreso("REVISION");
                exitoActExpediente = expDao.actualizarExpediente(expediente);
            }
            if (exitoActExpediente == true){
                    Utilidades.mostrarMensaje(response, 1, "Exito", "Se resolvio la solicitud satisfactoriamente.");
                } else{
                    Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo resolver la solicitud.");
                }
        }catch(Exception e){
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

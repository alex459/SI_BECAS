/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.SolocitudBecaDAO;
import DAO.ExpedienteDAO;
import DAO.UsuarioDAO;
import POJO.Expediente;
import POJO.SolicitudDeBeca;
import POJO.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "ModificarBecarioServlet", urlPatterns = {"/ModificarBecarioServlet"})
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

            if (accion.equals("becario")) {
                //Editar el becario
                UsuarioDAO usuarioDao = new UsuarioDAO();
                //Obteniendo el idUsuario
                int idUsuario = Integer.parseInt(request.getParameter("ID_USUARIO"));
                int idExpediente = Integer.parseInt(request.getParameter("idExpediente"));
                //Obteniendo la solicitud de beca
                SolicitudDeBeca solicitud = new SolicitudDeBeca();
                SolocitudBecaDAO solicitudDao = new SolocitudBecaDAO();
                solicitud = solicitudDao.consultarPorIdExpediente(idExpediente);
                if (solicitud.getIdSolicitud() != 0) {
                    //Actualizar Becario
                    int idBecarioActual = solicitud.getIdUsuario();
                    solicitud.setIdUsuario(idUsuario);
                    solicitudDao.actualizar(solicitud);
                    //Agregar el nuevo becario
                    usuarioDao.actualizarRolPorIdUsuario(idUsuario, 2);
                    //Borrar becario Actual
                    Expediente expediente = new Expediente();
                    ExpedienteDAO expedienteDao = new ExpedienteDAO();
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
                //Actualizar datos de la beca
                //obtener expediente y progreso actual
                //comparar progreso actual con anterior
                //si progreso cambio borrar los documentos que no van
                //agregar o actualizar documentos
            }
        } catch (Exception e) {
            e.printStackTrace();
            //Mostrar mensaje de error
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo Actualizar el becario.");
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

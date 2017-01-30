/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.ExpedienteDAO;
import DAO.ProgresoDAO;
import POJO.Expediente;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Manuel Miranda
 */
@WebServlet(name = "ModificarEstadoDeBecarioServlet", urlPatterns = {"/ModificarEstadoDeBecarioServlet"})
public class ModificarEstadoDeBecarioServlet extends HttpServlet {

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
        String progresoString = request.getParameter("PROGRESO_BECARIO");
        String progresoName =  progresoString.substring(7, progresoString.length());
        Integer idExpediente = Integer.parseInt(request.getParameter("idExpediente"));
        
        Expediente expediente = new Expediente();
        ExpedienteDAO expedienteDAO = new ExpedienteDAO();
        ProgresoDAO progresoDAO = new ProgresoDAO();
        Integer idProgreso = 0;
        Boolean actualizarProgreso = false;
        
        idProgreso = progresoDAO.consultarId(progresoName);
        expediente = expedienteDAO.consultarPorId(idExpediente);
        
        expediente.setIdProgreso(idProgreso);
        actualizarProgreso = expedienteDAO.actualizarIdProgreso(expediente);
        
        if(actualizarProgreso){
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se ha actualizado satisfactoriamente el estado del becario.");
        }
        else{
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo actualizar el estado del becario.");
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

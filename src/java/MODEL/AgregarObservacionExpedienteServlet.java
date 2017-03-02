/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.ObservacionesDAO;
import POJO.Observaciones;
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
@WebServlet(name = "AgregarObservacionExpedienteServlet", urlPatterns = {"/AgregarObservacionExpedienteServlet"})
public class AgregarObservacionExpedienteServlet extends HttpServlet {

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
            //recuperando valores del formulario
            String observacion = request.getParameter("observacion");
            int idExpediente = Integer.parseInt(request.getParameter("idExpediente"));
            
            //ingresando observacion
            ObservacionesDAO observacionDao = new ObservacionesDAO();
            Observaciones observaciones = new Observaciones();
            observaciones.setIdObservacion(observacionDao.getSiguienteId());
            observaciones.setIdExpediente(idExpediente);
            observaciones.setObservacion(observacion);
            observacionDao.ingresar(observaciones);
            
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se Agregó la observación correctamente al expediente.");
        }catch (Exception e){
            e.printStackTrace();
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo Agregar la observación.");
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

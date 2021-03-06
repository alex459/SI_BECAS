/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.OfertaBecaDAO;
import DAO.InstitucionDAO;
import POJO.OfertaBeca;
import java.io.IOException;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MauricioBC
 */
@WebServlet("/EliminarOfertaBecaServlet")
public class EliminarOfertaBecaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Date fechaHoy = new Date();
        OfertaBeca ofertaBeca = new OfertaBeca();
        OfertaBecaDAO ofertaBecaDAO = new OfertaBecaDAO();
        InstitucionDAO institucionDAO = new InstitucionDAO();
        java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());        

        //parte de lectura desde el jsp y guardado en bd     
        ofertaBeca.setIdOfertaBeca(Integer.parseInt(request.getParameter("ID_OFERTA_BECA"))); 
        ofertaBeca = ofertaBecaDAO.consultarPorId(ofertaBeca.getIdOfertaBeca());
        System.out.println("ID RECIBIDO "+Integer.parseInt(request.getParameter("ID_OFERTA_BECA")));
        Boolean exito=ofertaBecaDAO.eliminar(ofertaBeca);
        if(exito){
            Utilidades.nuevaBitacora(4, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()), "Se dio de baja la oferta de beca: " + ofertaBeca.getNombreOferta() + " con id "+ofertaBeca.getIdOfertaBeca()+".", "");
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se deshabilito la oferta correctamente.");
        }else{
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo deshabilitar la oferta de beca");
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

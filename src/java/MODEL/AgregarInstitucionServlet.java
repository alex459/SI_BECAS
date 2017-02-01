/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.InstitucionDAO;
import POJO.Institucion;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author alex
 */
@WebServlet("/AgregarInstitucionServlet")

public class AgregarInstitucionServlet extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");

        Institucion institucion = new Institucion();
        InstitucionDAO institucionDAO = new InstitucionDAO();

        //parte de lectura desde el jsp y guardado en bd  
        int idInstitucion = institucionDAO.getSiguienteId();
        int institucionActiva = 1;
        InstitucionDAO institucionDao = new InstitucionDAO();
        institucion.setIdInstitucion(idInstitucion);
        institucion.setNombreInstitucion(request.getParameter("text_NomInstitucion"));
        institucion.setTipoInstitucion(request.getParameter("select_tipoInstitucion"));
        institucion.setPais(request.getParameter("tex_paisInstitucion"));
        institucion.setPaginaWeb(request.getParameter("tex_webInstitucion"));
        institucion.setEmail(request.getParameter("tex_correoInstitucion"));
        institucion.setInstitucionActiva(institucionActiva);

        if (institucionDao.validarInstitucionRepetida(institucion.getNombreInstitucion(), institucion.getPais())) {
            institucionDAO.ingresar(institucion);
            Utilidades.nuevaBitacora(1, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()), "Se ingresó la institución " + institucion.getNombreInstitucion() + ".", "");
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se ingreso el institucion correctamente.");
        } else {
            Utilidades.mostrarMensaje(response, 3, "Error", "Ya existe una institucion con el mismo nombre en el mismo pais.");
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

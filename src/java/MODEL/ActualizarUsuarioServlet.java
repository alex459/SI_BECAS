/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.DetalleUsuarioDAO;
import DAO.UsuarioDAO;
import POJO.DetalleUsuario;
import POJO.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author next
 */
public class ActualizarUsuarioServlet extends HttpServlet {

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
        
        Usuario usuario = new Usuario();
        DetalleUsuario detalleUsuario = new DetalleUsuario();
        UsuarioDAO usuarioDao = new UsuarioDAO();
        DetalleUsuarioDAO detalleUsuarioDao = new DetalleUsuarioDAO();
        
        //parte de lectura desde el jsp y guardado en bd     
        
        usuario.setIdUsuario(Integer.parseInt(request.getParameter("ID_USUARIO")));
        usuario.setIdTipoUsuario(Integer.parseInt(request.getParameter("ID_TIPO_USUARIO")));
        usuario.setNombreUsuario(request.getParameter("CARNET"));
        usuario.setClave(request.getParameter("CLAVE"));
        usuarioDao.actualizar(usuario); //guardando usuario
        
        detalleUsuario.setIdDetalleUsuario(Integer.parseInt(request.getParameter("ID_DETALLE_USUARIO")));
        detalleUsuario.setIdUsuario(Integer.parseInt(request.getParameter("ID_USUARIO")));
        detalleUsuario.setIdFacultad(Integer.parseInt(request.getParameter("ID_FACULTAD")));
        detalleUsuario.setCarnet(request.getParameter("CARNET"));
        detalleUsuario.setNombre1Du(request.getParameter("NOMBRE1_DU"));
        detalleUsuario.setNombre2Du(request.getParameter("NOMBRE2_DU"));
        detalleUsuario.setApellido1Du(request.getParameter("APELLIDO1_DU"));
        detalleUsuario.setApellido2Du(request.getParameter("APELLIDO2_DU"));
        detalleUsuarioDao.actualizarOpcion2(detalleUsuario); //guardando detalle usuario
        
        
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

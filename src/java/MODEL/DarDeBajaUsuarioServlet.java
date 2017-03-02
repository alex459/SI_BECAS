/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.ExpedienteDAO;
import DAO.UsuarioDAO;
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
 * @author next
 */

@WebServlet("/DarDeBajaUsuarioServlet")
public class DarDeBajaUsuarioServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
        request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ
        
        Usuario usuario = new Usuario();
        UsuarioDAO usuarioDao = new UsuarioDAO();
        
        boolean validacion1 = false; //usuario candidato o becario con proceso activo.
        boolean validacion2 = false; //dar de baja a uno mismo.                        
        String mensaje = new String();
        String nombre_usuario = request.getParameter("CARNET");
        usuario = usuarioDao.consultarPorNombreUsuario(nombre_usuario);
        int id_user_login = Integer.parseInt(request.getSession().getAttribute("id_user_login").toString());
        boolean bandera;
        
        //validacion1
        if(usuario.getIdTipoUsuario() == 1 || usuario.getIdTipoUsuario() == 2 ){
            ExpedienteDAO expedienteDao = new ExpedienteDAO();
            if(expedienteDao.expedienteAbiertoPorIdUsuario(usuario.getIdUsuario())){
                validacion1=false;
                mensaje = mensaje.concat("No se puede dar de baja a un usuario que se encuentre en un proceso de beca.");
            }else{
                validacion1=true;
            }
        }else{
            validacion1 = true;
        }
        
        //validacion2
        if(request.getSession().getAttribute("user").equals(usuario.getNombreUsuario())){
            validacion2 = false;
            mensaje = mensaje.concat("No se puede dar de baja a su usuario mientras esta logeado.");
        }else{
            validacion2 = true;
        }                        
        
        bandera = usuarioDao.darDeBajaUsuario(usuario, id_user_login);

        if (bandera) {            
            Utilidades.nuevaBitacora(2, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()) , "Se ha dado de baja al usuario "+nombre_usuario, "");
            Utilidades.mostrarMensaje(response, 1, "Exito", "El usuario "+nombre_usuario+" se ha dado de baja.");
        } else {
            Utilidades.mostrarMensaje(response, 2, "Error", "No se puede actualizar el usuario. " + mensaje);
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

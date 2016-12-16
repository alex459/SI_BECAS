/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.TipoUsuarioDao;
import DAO.UsuarioDAO;
import POJO.TipoUsuario;
import POJO.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ModificarRolesServlet")
public class ModificarRolesServlet extends HttpServlet {

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

        boolean bandera=false;
        
        //actualizando usuario
        
        String nombre_usuario = request.getParameter("CARNET");
        usuario = usuarioDao.consultarPorNombreUsuario(nombre_usuario);
        usuario.setIdTipoUsuario(Integer.parseInt(request.getParameter("ID_TIPO_USUARIO")));
        int id_user_login = Integer.parseInt(request.getSession().getAttribute("id_user_login").toString());
        bandera = usuarioDao.actualizar(usuario, id_user_login);

        
        
        
        if (bandera) {
            //parte de bitacora            
            TipoUsuario temp1 = new TipoUsuario();
            TipoUsuarioDao temp2 = new TipoUsuarioDao();
            temp1 = temp2.consultarPorId(usuario.getIdTipoUsuario());
            String rol_anterior = request.getParameter("TIP_USUARIO_ANTERIOR");
            String rol_nuevo = temp1.getTipoUsuario();                    
            //Utilidades.nuevaBitacora(2, request.getSession().getAttribute("user").toString(), "Se actualizo el rol del usuario "+nombre_usuario+" de "+rol_anterior+" a "+rol_nuevo+".");
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se cambio el rol del usuario "+nombre_usuario+" correctamente.");
        } else {
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo cambiar el rol del usuario " + nombre_usuario + ".");
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

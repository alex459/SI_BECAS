
package MODEL;

import DAO.UsuarioDAO;
import POJO.TipoUsuario;
import POJO.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class login extends HttpServlet {
    
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
        
        Usuario usuario = new Usuario();
        UsuarioDAO usuarioDao = new UsuarioDAO();
        TipoUsuario tipoUsuario = new TipoUsuario();
        
        usuario.setNombreUsuario(request.getParameter("user"));
        usuario.setClave(request.getParameter("pass"));
        
        
        if(usuarioDao.login(usuario.getNombreUsuario(), usuario.getClave())){
            HttpSession sesion = request.getSession();
            sesion.setMaxInactiveInterval(600); //600 segundos, 10 min max para sesion activa
            sesion.setAttribute("user", usuario.getNombreUsuario());
            response.sendRedirect("principal.jsp");            
        }else{            
            response.sendRedirect("login.jsp");
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

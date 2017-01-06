
package MODEL;

import DAO.ConexionBD;
import DAO.UsuarioDAO;
import POJO.TipoUsuario;
import POJO.Usuario;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
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
        usuario = usuarioDao.consultarPorNombreUsuario(usuario.getNombreUsuario());
        
        if(usuarioDao.login(usuario.getNombreUsuario(), usuario.getClave())){
            HttpSession sesion = request.getSession();
            sesion.setMaxInactiveInterval(3600); //3600 segundos, 1 hora max para sesion activa            
            sesion.setAttribute("id_user_login", usuario.getIdUsuario().toString());
            sesion.setAttribute("user", usuario.getNombreUsuario());
            sesion.setAttribute("rol", getRol(usuario.getNombreUsuario(),usuarioDao));
            sesion.setAttribute("id_tipo_usuario", usuario.getIdTipoUsuario());
            response.sendRedirect("principal.jsp");            
        }else{            
            response.sendRedirect("login.jsp");
        }
        
    }
    
    public String getRol(String nombre, UsuarioDAO usuarioDao) {
        Statement stmt;
        ResultSet rs;
        ConexionBD conexion=new ConexionBD();
        usuarioDao.abrirConexion();
        conexion.abrirConexion();
        String rol="nadas";
        try {
            stmt = usuarioDao.conn.createStatement();
            String sql = "SELECT TIPO_USUARIO FROM TIPO_USUARIO WHERE ID_TIPO_USUARIO = (SELECT ID_TIPO_USUARIO FROM USUARIO where NOMBRE_USUARIO = '"+nombre+"');";
            rs = stmt.executeQuery(sql);
            conexion.cerrarConexion();
            System.out.println(rol);
            if (rs.next()) {
               rol=rs.getString("TIPO_USUARIO");}
        } catch (Exception e) {
            System.out.println("Error " + e);}
        return rol;
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

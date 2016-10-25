
package MODEL;

import DAO.UsuarioDAO;
import POJO.TipoUsuario;
import POJO.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


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
        
        //las variables user y pass se envian desde la pagina login.jsp a este servlet
        //donde son leidas y guardadas.
        
               
        String enlace = "jdbc:mariadb://localhost:3306/bd_becas";
        String controlador = "org.mariadb.jdbc.Driver";
        String error = " ";
        String us = "root";
        String contrasenia = "";
        Connection conn = null;
        Statement stmt = null;

        try {
            Class.forName(controlador);
            conn = DriverManager.getConnection(enlace, us, contrasenia);
            stmt = conn.createStatement();
            String sql = "SELECT ID_USUARIO, ID_TIPO_USUARIO, NOMBRE_USUARIO, CLAVE FROM usuario";
            
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                //Retrieve by column name
                int ID_USUARIO = rs.getInt("ID_USUARIO");
                int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                String NOMBRE_USUARIO = rs.getString("NOMBRE_USUARIO");
                String CLAVE = rs.getString("CLAVE");

                //Display values
                System.out.print("ID_USUARIO: " + ID_USUARIO);
                System.out.print(", ID_TIPO_USUARIO: " + ID_TIPO_USUARIO);
                System.out.print(", NOMBRE_USUARIO: " + NOMBRE_USUARIO);
                System.out.println(", CLAVE: " + CLAVE);
            }
            rs.close();
            stmt.close();
            conn.close();

            response.sendRedirect("principal.jsp");
            
        } catch (Exception e) {
            System.out.println("error "+e);
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

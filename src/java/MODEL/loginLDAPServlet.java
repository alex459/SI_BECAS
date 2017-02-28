package MODEL;

import DAO.ConexionBD;
import DAO.UsuarioDAO;
import POJO.TipoUsuario;
import POJO.Usuario;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.security.cert.X509Certificate;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Hashtable;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;
import javax.servlet.http.HttpSession;

@WebServlet(name = "loginLDAPServlet", urlPatterns = {"/loginLDAPServlet"})
public class loginLDAPServlet extends HttpServlet {

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
            throws ServletException, IOException, NoSuchAlgorithmException, KeyManagementException {
        response.setContentType("text/html;charset=UTF-8");

        int tiempo_de_logeo = Utilidades.ObtenerTiempoDeSesion();
        boolean login_base = false;

        try {
            Usuario usuario_obj = new Usuario();
            UsuarioDAO usuarioDao = new UsuarioDAO();
            TipoUsuario tipoUsuario = new TipoUsuario();
            String usuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");
            usuario_obj.setNombreUsuario(usuario);
            usuario_obj.setClave(contrasena);
            login_base = usuarioDao.login(usuario_obj.getNombreUsuario(), usuario_obj.getClave());
            if (login_base) {
                usuario_obj = usuarioDao.consultarPorNombreUsuario(usuario_obj.getNombreUsuario());
                HttpSession sesion = request.getSession();
                sesion.setMaxInactiveInterval(tiempo_de_logeo); //3600 segundos, 1 hora max para sesion activa            
                sesion.setAttribute("id_user_login", usuario_obj.getIdUsuario().toString());
                sesion.setAttribute("user", usuario_obj.getNombreUsuario());
                sesion.setAttribute("rol", getRol(usuario_obj.getNombreUsuario(), usuarioDao));
                sesion.setAttribute("id_tipo_usuario", usuario_obj.getIdTipoUsuario());
                response.sendRedirect("principal.jsp");
            } else {
                System.out.println("No se pudo logear al sistema. Intentando con LDAP");
            }

        } catch (Exception ex) {
            System.out.println("Error en login del sistema: " + ex);
        }

        if (!login_base) {
            try (PrintWriter out = response.getWriter()) {

                try {

                    //conectando con LDAP
                    String usuario = request.getParameter("usuario");
                    String contrasena = request.getParameter("contrasena");
                    DirContext ctx = this.loginLDAP(usuario, contrasena);
                    boolean result = ctx != null;
                    //validando login
                    
                    if (result) {
                        //Credenciales validas en LDAP. entonces consultar
                        //la base de datos del sistema.                       
                        Usuario usuario_obj = new Usuario();
                        UsuarioDAO usuarioDao = new UsuarioDAO();
                        TipoUsuario tipoUsuario = new TipoUsuario();

                        usuario_obj.setNombreUsuario(usuario);
                        usuario_obj.setClave(contrasena);
                        
                        //El usuario ya se encuentra registrado. ingresando!!
                        if (usuarioDao.login_ldap(usuario_obj.getNombreUsuario())) {
                            usuario_obj = usuarioDao.consultarPorNombreUsuario(usuario_obj.getNombreUsuario());
                            HttpSession sesion = request.getSession();
                            sesion.setMaxInactiveInterval(tiempo_de_logeo); //3600 segundos, 1 hora max para sesion activa            
                            sesion.setAttribute("id_user_login", usuario_obj.getIdUsuario().toString());
                            sesion.setAttribute("user", usuario_obj.getNombreUsuario());
                            sesion.setAttribute("rol", getRol(usuario_obj.getNombreUsuario(), usuarioDao));
                            sesion.setAttribute("id_tipo_usuario", usuario_obj.getIdTipoUsuario());
                            response.sendRedirect("principal.jsp");
                            System.out.println("Credenciales validas en LDAP y validas en SIABP");
                        } else {
                            //Credenciales validas en el LDAP
                            //registrando el usuario por primera vez en la base del sistema.
                            System.out.println("Credenciales validas LDAP e invalidas en SIABP. Enviando al registro.");
                            HttpSession sesion = request.getSession();
                            sesion.setMaxInactiveInterval(tiempo_de_logeo); //3600 segundos, 1 hora max para sesion activa            
                            sesion.setAttribute("id_user_login", "0");
                            sesion.setAttribute("user", usuario);
                            sesion.setAttribute("rol", "1");
                            sesion.setAttribute("id_tipo_usuario", 1);
                            response.sendRedirect("116_registrar_usuario.jsp");
                        }
                    } else {
                        //Acceso denegado. Credenciales invalidas
                        response.sendRedirect("login.jsp");
                        System.out.println("Credenciales invalidas LDAP y SIABP");

                    }
                } catch (Exception ex) {
                    //Error. regresando al login
                    System.out.println("error en servidor LDAP: " + ex);                    
                        response.sendRedirect("login.jsp");
                    
                }

            }
        }
    }

    public String getRol(String nombre, UsuarioDAO usuarioDao) {
        Statement stmt;
        ResultSet rs;
        ConexionBD conexion = new ConexionBD();
        usuarioDao.abrirConexion();
        conexion.abrirConexion();
        String rol = "nadas";
        try {
            stmt = usuarioDao.conn.createStatement();
            String sql = "SELECT TIPO_USUARIO FROM TIPO_USUARIO WHERE ID_TIPO_USUARIO = (SELECT ID_TIPO_USUARIO FROM USUARIO where NOMBRE_USUARIO = '" + nombre + "');";
            rs = stmt.executeQuery(sql);
            conexion.cerrarConexion();
            System.out.println(rol);
            if (rs.next()) {
                rol = rs.getString("TIPO_USUARIO");
            }
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        return rol;
    }

    public DirContext loginLDAP(String userName, String passWord) {

        DirContext ctx = null;
        String principal = new String();
        Hashtable<String, String> env = new Hashtable<String, String>();
        try {
           
            Properties prop = new Properties();
            String resourceName = "config.properties";
            ClassLoader loader = Thread.currentThread().getContextClassLoader();
            try (InputStream resourceStream = loader.getResourceAsStream(resourceName)) {
                prop.load(resourceStream);
            } catch (Exception ex) {
                System.out.println("Error al leer archivo de configuracion. " + ex);
                return null;
            }
            // obteniendo propiedades.
            
            String LDAPurl = prop.getProperty("LDAP.url");           
            String LDAPgrupo = prop.getProperty("LDAP.group");
            String LDAPbase  = prop.getProperty("LDAP.base");            
            String LDAPSecurity = prop.getProperty("LDAP.security");
            String LDAPfactory = prop.getProperty("LDAP.factory");
            
            //preparando el mensaje
            principal = "uid=" + userName + "," + LDAPgrupo + "," + LDAPbase;
            env = new Hashtable<String, String>();
            env.put(Context.INITIAL_CONTEXT_FACTORY, LDAPfactory);            
            env.put(Context.PROVIDER_URL, LDAPurl);
            env.put(Context.SECURITY_AUTHENTICATION, LDAPSecurity);
            env.put(Context.SECURITY_PRINCIPAL, principal);
            env.put(Context.SECURITY_CREDENTIALS, passWord);

            //intentando conectar con LDAP
            ctx = new InitialDirContext(env);
            return ctx;

        } catch (Exception e) {
            System.out.println(e);
            return ctx;
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
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(loginLDAPServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (KeyManagementException ex) {
            Logger.getLogger(loginLDAPServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(loginLDAPServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (KeyManagementException ex) {
            Logger.getLogger(loginLDAPServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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

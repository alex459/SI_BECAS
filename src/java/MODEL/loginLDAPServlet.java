package MODEL;

import DAO.ConexionBD;
import DAO.UsuarioDAO;
import POJO.TipoUsuario;
import POJO.Usuario;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
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
import java.util.logging.Level;
import java.util.logging.Logger;
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
        
        int tiempo_de_logeo = 60;
        
        try (PrintWriter out = response.getWriter()) {

            // Evitando error de certificacion en del LDAP.
            TrustManager[] trustAllCerts = new TrustManager[]{new X509TrustManager() {
                public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                    return null;
                }

                public void checkClientTrusted(X509Certificate[] certs, String authType) {
                }

                public void checkServerTrusted(X509Certificate[] certs, String authType) {
                }
            }
            };
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
            HostnameVerifier allHostsValid = new HostnameVerifier() {
                public boolean verify(String hostname, SSLSession session) {
                    return true;
                }
            };
            HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);

            //Parametros
            String usuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");
            String urlParameters = "usuario=" + usuario + "&contrasena=" + contrasena;

            try {

                //conectando con LDAP
                String USER_AGENT = "Mozilla/5.0";
                String url1 = "https://ldap.ues.edu.sv/autentificacion/control.php";
                URL obj = new URL(url1);
                HttpURLConnection con1;
                con1 = (HttpURLConnection) obj.openConnection();
                con1.setRequestProperty("User-Agent", USER_AGENT);
                con1.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
                //Enviando POST
                con1.setDoOutput(true);
                DataOutputStream wr = new DataOutputStream(con1.getOutputStream());
                wr.writeBytes(urlParameters);
                wr.flush();
                wr.close();
                int responseCode = con1.getResponseCode();
                BufferedReader in = new BufferedReader(
                        new InputStreamReader(con1.getInputStream()));
                String inputLine;
                StringBuffer responseD = new StringBuffer();
                while ((inputLine = in.readLine()) != null) {
                    responseD.append(inputLine);
                }
                //obteniendo respuesta
                String htmlContent = new String();
                for (int i = 0; i < responseD.length(); i++) {
                    htmlContent = htmlContent + responseD.charAt(i);
                }
                System.out.println("contenido" + htmlContent);
                in.close();
                //validando login
                if (htmlContent.contains("Datos incorrectos")) {
                    //Credenciales invalidas, entonces intenta revisar 
                    //la base del sistema para logearse.
                    Usuario usuario_obj = new Usuario();
                    UsuarioDAO usuarioDao = new UsuarioDAO();
                    TipoUsuario tipoUsuario = new TipoUsuario();

                    usuario_obj.setNombreUsuario(usuario);
                    usuario_obj.setClave(contrasena);
                    usuario_obj = usuarioDao.consultarPorNombreUsuario(usuario_obj.getNombreUsuario());

                    if (usuarioDao.login(usuario_obj.getNombreUsuario(), usuario_obj.getClave())) {
                        HttpSession sesion = request.getSession();
                        sesion.setMaxInactiveInterval(tiempo_de_logeo); //3600 segundos, 1 hora max para sesion activa            
                        sesion.setAttribute("id_user_login", usuario_obj.getIdUsuario().toString());
                        sesion.setAttribute("user", usuario_obj.getNombreUsuario());
                        sesion.setAttribute("rol", getRol(usuario_obj.getNombreUsuario(), usuarioDao));
                        sesion.setAttribute("id_tipo_usuario", usuario_obj.getIdTipoUsuario());
                        response.sendRedirect("principal.jsp");
                        System.out.println("Credenciales invalidas en LDAP y validas en SIABP");
                    } else {
                        //Credenciales invalidas en la base entonces
                        //enviar al login_ldap.                                               
                        response.sendRedirect("login_ldap.jsp");
                        System.out.println("Credenciales invalidas LDAP y SIABP");                                                                        
                        
                    }

                } else {
                    //Credenciales validas en LDAP. entonces consultar
                    //la base de datos del sistema.
                    
                    Usuario usuario_obj = new Usuario();
                    UsuarioDAO usuarioDao = new UsuarioDAO();
                    TipoUsuario tipoUsuario = new TipoUsuario();

                    usuario_obj.setNombreUsuario(usuario);
                    usuario_obj.setClave(contrasena);
                    usuario_obj = usuarioDao.consultarPorNombreUsuario(usuario_obj.getNombreUsuario());

                    //
                    if (usuarioDao.login_ldap(usuario_obj.getNombreUsuario())) {
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
                        //enviar al login.                                               }
                        System.out.println("Credenciales validas LDAP e invalidas en SIABP. Enviando al registro.");
                        HttpSession sesion = request.getSession();
                        sesion.setMaxInactiveInterval(tiempo_de_logeo); //3600 segundos, 1 hora max para sesion activa            
                        sesion.setAttribute("id_user_login", "0");
                        sesion.setAttribute("user", usuario);
                        sesion.setAttribute("rol", "1");
                        sesion.setAttribute("id_tipo_usuario", 1);
                        response.sendRedirect("116_registrar_usuario.jsp");                        
                    }                    
                }

            } catch (java.net.UnknownHostException e_UnknownHost) {

                System.out.println("Sin conexion al LDAP: "+e_UnknownHost);
                //si no se puede conectar al ldap entonces que se 
                //trate de conectar a la base de datos del sistema.
                Usuario usuario_obj = new Usuario();
                UsuarioDAO usuarioDao = new UsuarioDAO();
                TipoUsuario tipoUsuario = new TipoUsuario();

                usuario_obj.setNombreUsuario(usuario);
                usuario_obj.setClave(contrasena);
                usuario_obj = usuarioDao.consultarPorNombreUsuario(usuario_obj.getNombreUsuario());

                if (usuarioDao.login(usuario_obj.getNombreUsuario(), usuario_obj.getClave())) {
                    HttpSession sesion = request.getSession();
                    sesion.setMaxInactiveInterval(tiempo_de_logeo); //3600 segundos, 1 hora max para sesion activa            
                    sesion.setAttribute("id_user_login", usuario_obj.getIdUsuario().toString());
                    sesion.setAttribute("user", usuario_obj.getNombreUsuario());
                    sesion.setAttribute("rol", getRol(usuario_obj.getNombreUsuario(), usuarioDao));
                    sesion.setAttribute("id_tipo_usuario", usuario_obj.getIdTipoUsuario());
                    response.sendRedirect("principal.jsp");
                } else {
                    response.sendRedirect("login_ldap.jsp");
                }

            }catch (Exception ex) {
                System.out.println("Error en el login_ldap: "+ex);
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

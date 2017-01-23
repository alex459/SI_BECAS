/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author jose
 */
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
        try (PrintWriter out = response.getWriter()) {

            // Create a trust manager that does not validate certificate chains
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

            // Install the all-trusting trust manager
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

            // Create all-trusting host name verifier
            HostnameVerifier allHostsValid = new HostnameVerifier() {
                public boolean verify(String hostname, SSLSession session) {
                    return true;
                }
            };

            // Install the all-trusting host verifier
            HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);

            URL url = new URL("https://ldap.ues.edu.sv/autentificacion/aplicacion.php");
            URLConnection con = url.openConnection();
            Reader reader = new InputStreamReader(con.getInputStream());
            while (true) {
                int ch = reader.read();
                if (ch == -1) {
                    break;
                }
                System.out.print((char) ch);
            }

            /* TODO output your page here. You may use following sample code. */
            //
            String USER_AGENT = "Mozilla/5.0";

            String url1 = "https://ldap.ues.edu.sv/autentificacion/control.php";
            URL obj = new URL(url1);
            HttpURLConnection con1;
            con1 = (HttpURLConnection) obj.openConnection();

            con1.setRequestProperty("User-Agent", USER_AGENT);
            con1.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

            //Data to be posted
            String usuario = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasena");
            String urlParameters = "usuario=" + usuario + "&contrasena=" + contrasena;

            // Send post request
            con1.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con1.getOutputStream());
            wr.writeBytes(urlParameters);
            wr.flush();
            wr.close();

            int responseCode = con1.getResponseCode();
            //out.println("\nSending 'POST' request to URL : " + url);
            //out.println("Post parameters : " + urlParameters);
            //out.println("Response Code : " + responseCode);

            BufferedReader in = new BufferedReader(
                    new InputStreamReader(con1.getInputStream()));
            String inputLine;
            StringBuffer responseD = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                responseD.append(inputLine);
            }
            String htmlContent = new String();
            for(int i=0; i<responseD.length() ;i++){
                htmlContent = htmlContent + responseD.charAt(i);
            }
            System.out.println("contenido" + htmlContent);
            
            in.close();
            //print result
            //out.println("Response From The URL: " + responseD.toString());
            
            //validando login
            if(htmlContent.contains("Datos incorrectos")){
                
                response.sendRedirect("login_ldap.jsp");
                
            }else{
                
                out.println("LOGIN");
                
            }

            
            
            /*URL url2 = new URL("https://ldap.ues.edu.sv/autentificacion/aplicacion.php");
            BufferedReader in = new BufferedReader(new InputStreamReader(url2.openStream()));
            String inputLine;
            StringBuilder response2 = new StringBuilder();
            String htmlContent = new String();
            while ((inputLine = in.readLine()) != null) {
                response2.append(inputLine);                 
            }
            for(int i=0; i<response2.length() ;i++){
                htmlContent = htmlContent + response2.charAt(i);
            }
            System.out.println("contenido" + htmlContent);            
            in.close();*/
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

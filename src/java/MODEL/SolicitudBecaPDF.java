/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.ConexionBD;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "SolicitudBecaPDF", urlPatterns = {"/SolicitudBecaPDF"})
@MultipartConfig(maxFileSize = 16177215)
public class SolicitudBecaPDF extends HttpServlet {

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

        try {
            //leyendo parametros del jsp

            String nombre1 = request.getParameter("nombre1");
            String nombre2 = request.getParameter("nombre2");
            String apellido1 = request.getParameter("apellido1");
            String apellido2 = request.getParameter("apellido2");
            java.sql.Date fechaNacimiento = new java.sql.Date(StringAFecha(request.getParameter("fechaNacimiento")).getTime());
            String departamentoNacimiento = request.getParameter("departamentoNacimiento");
            Integer municipioNacimiento = Integer.parseInt(request.getParameter("municipioNacimiento"));
            String genero = request.getParameter("genero");
            String direccion = request.getParameter("direccion");
            String departamentoDireccion = request.getParameter("departamentoDireccion");
            Integer municipioDireccion = Integer.parseInt(request.getParameter("municipioDireccion"));
            String telCasa = request.getParameter("telCasa");
            String telMovil = request.getParameter("telMovil");
            String telOficina = request.getParameter("telOficina");

            //preparando parametros para el reporte
            Map parametersMap = new HashMap();
            parametersMap.put("nombre1", nombre1);
            parametersMap.put("nombre2", nombre2);
            parametersMap.put("apellido1", apellido1);
            parametersMap.put("apellido2", apellido2);
            parametersMap.put("fechaNacimiento", fechaNacimiento);
            parametersMap.put("departamentoNacimiento", departamentoNacimiento);
            parametersMap.put("municipioNacimiento", municipioNacimiento);
            parametersMap.put("genero", genero);
            parametersMap.put("direccion", direccion);
            parametersMap.put("departamentoDireccion", departamentoDireccion);
            parametersMap.put("municipioDireccion", municipioDireccion);
            parametersMap.put("telCasa", telCasa);
            parametersMap.put("telMovil", telMovil);
            parametersMap.put("telOficina", telOficina);
            
            ConexionBD conexionBD = new ConexionBD();
            conexionBD.abrirConexion();
            String path = getServletContext().getRealPath("/REPORTES/");
            byte[] bytes = JasperRunManager.runReportToPdf(path + "/308_Solicitud_Beca_PDF.jasper", parametersMap, conexionBD.conn);
            conexionBD.cerrarConexion();
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outputstream = response.getOutputStream();
            outputstream.write(bytes, 0, bytes.length);
            outputstream.flush();
            outputstream.close();

        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("Error: " + ex);
        }
    }

    public Date StringAFecha(String Sfecha) {
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
        Date fecha = null;
        try {
            fecha = formatoDelTexto.parse(Sfecha);           
        } catch (ParseException ex) {

            ex.printStackTrace();

        }
        System.out.println("fechanice!");
        return fecha;
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
        protected void doGet
        (HttpServletRequest request, HttpServletResponse response)
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
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }

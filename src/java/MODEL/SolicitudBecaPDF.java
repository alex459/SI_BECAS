/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "SolicitudBecaPDF", urlPatterns = {"/SolicitudBecaPDF"})
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
        
        //servlet encargado de generar reportes de bitacora
        try {
            //leyendo parametros del jsp
            String nombre1 = request.getParameter("nombre1");
            String nombre2 = request.getParameter("nombre2");
            String apellido1 = request.getParameter("apellido1");
            String apellido2 = request.getParameter("apellido2");

            //preparando parametros para el reporte
            Map parametersMap = new HashMap();
            parametersMap.put("nombre1", "");
            parametersMap.put("nombre2", "");
            parametersMap.put("apellido1", "");
            parametersMap.put("apellido2", "");
            JasperReport report = JasperCompileManager.compileReport("REPORTES/308_Solicitud_Beca_PDF.jrxml");

            //SALIDA EN PDF                
                ConexionBD conexionBD = new ConexionBD();
                conexionBD.abrirConexion();
                response.setContentType("application/pdf");
                byte[] bytes = JasperRunManager.runReportToPdf(report, parametersMap, conexionBD.conn);
                //byte[] bytes = JasperRunManager.runReportToPdf("C:\\Users\\adminPC\\Documents\\NetBeansProjects\\JavaApplication1\\src\\javaapplication1\\solicitud100.jasper", parametersMap, conexionBD.conn);
                //byte[] bytes = JasperRunManager.runReportToPdf
                conexionBD.cerrarConexion();
                
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

package MODEL;

import DAO.ConexionBD;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author next
 */
@WebServlet("/ReporteInstitucionFinancieraServlet")
public class ReporteInstitucionFinancieraServlet extends HttpServlet {

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
            String reporte_reporte_rol_usuario = request.getParameter("REPORTE_ROL_USUARIO");
            String opcion_de_salida = request.getParameter("OPCION_DE_SALIDA");
            String condicion = request.getParameter("CONDICION");
            String query="";
            query= request.getParameter("QUERY");
          Map parametersMap=new HashMap();
          parametersMap.put("paramtest", "EXTERNA");
          parametersMap.put("condicion", condicion);
          System.out.println(condicion);
               // parametersMap=null;
            if ("1".equals(opcion_de_salida)) { //SALIDA EN PDF  
                 ConexionBD conexionBD = new ConexionBD();
                conexionBD.abrirConexion();
                String path = getServletContext().getRealPath("/REPORTES/");
                byte[] bytes = JasperRunManager.runReportToPdf(path + "/511_Reporte_Institucion_Financiera.jasper", parametersMap, conexionBD.conn);
                conexionBD.cerrarConexion();
                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream outputstream = response.getOutputStream();
                outputstream.write(bytes, 0, bytes.length);
                outputstream.flush();
                outputstream.close();
            }

            if ("2".equals(opcion_de_salida)) { //SALIDA EN XLS
            }

            if ("3".equals(opcion_de_salida)) { //SALIDA EN XLS

            }

            if ("4".equals(opcion_de_salida)) { //SALIDA EN XLS

            }

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

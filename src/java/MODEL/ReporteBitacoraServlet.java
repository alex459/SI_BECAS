package MODEL;

import DAO.ConexionBD;
import DAO.DetalleUsuarioDAO;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;

/**
 *
 * @author next
 */
@WebServlet("/ReporteBitacoraServlet")
public class ReporteBitacoraServlet extends HttpServlet {

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
            String reporte_nombre1 = request.getParameter("REPORTE_NOMBRE1");
            String reporte_nombre2 = request.getParameter("REPORTE_NOMBRE2");
            String reporte_apellido1 = request.getParameter("REPORTE_APELLIDO1");
            String reporte_apellido2 = request.getParameter("REPORTE_APELLIDO2");
            String reporte_fecha1 = request.getParameter("REPORTE_FECHA1");
            String reporte_fecha2 = request.getParameter("REPORTE_FECHA2");
            String reporte_id_accion_menor = request.getParameter("REPORTE_ID_ACCION_MENOR");
            String reporte_id_accion_mayor = request.getParameter("REPORTE_ID_ACCION_MAYOR");
            String opcion_de_salida = request.getParameter("OPCION_DE_SALIDA");

            if ("".equals(reporte_nombre1)) {
                reporte_nombre1 = "%";
            }
            if ("".equals(reporte_nombre2)) {
                reporte_nombre2 = "%";
            }
            if ("".equals(reporte_apellido1)) {
                reporte_apellido1 = "%";
            }
            if ("".equals(reporte_apellido2)) {
                reporte_apellido2 = "%";
            }
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            Date parsedDate1 = (Date) dateFormat.parse(reporte_fecha1);
            Timestamp timestamp1 = new java.sql.Timestamp(parsedDate1.getTime());
            Date parsedDate2 = (Date) dateFormat.parse(reporte_fecha2);
            Timestamp timestamp2 = new java.sql.Timestamp(parsedDate2.getTime());
            if ("".equals(reporte_id_accion_menor)) {
                reporte_id_accion_menor = "0";
            }
            if ("".equals(reporte_id_accion_mayor)) {
                reporte_id_accion_mayor = "10";
            }

            //preparando parametros para el reporte
            Map parametersMap = new HashMap();
            //parametersMap.put("PARAMETRO1", "HOLA");
            //parametersMap.put("PARAMETRO2", "MUNDO");
            parametersMap.put("NOMBRE1", reporte_nombre1);
            parametersMap.put("NOMBRE2", reporte_nombre2);
            parametersMap.put("APELLIDO1", reporte_apellido1);
            parametersMap.put("APELLIDO2", reporte_apellido2);
            parametersMap.put("FECHA1", timestamp1);            
            parametersMap.put("FECHA2", timestamp2);
            parametersMap.put("ID_ACCION_MENOR", Integer.parseInt(reporte_id_accion_menor));
            parametersMap.put("ID_ACCION_MAYOR", Integer.parseInt(reporte_id_accion_mayor));
            parametersMap.put("NOMBRE_USUARIO", new DetalleUsuarioDAO().ObtenerNombrePorIdUsuario(Integer.parseInt(request.getSession().getAttribute("id_user_login").toString())));
            parametersMap.put("ROL_USUARIO", request.getSession().getAttribute("rol"));

            if ("1".equals(opcion_de_salida)) { //SALIDA EN PDF                
                ConexionBD conexionBD = new ConexionBD();
                conexionBD.abrirConexion();
                String path = getServletContext().getRealPath("/REPORTES/");
                //byte[] bytes = JasperRunManager.runReportToPdf(path + "/test_reporte_2.jasper", parametersMap, conexionBD.conn);
                byte[] bytes = JasperRunManager.runReportToPdf(path + "/101_reporte_bitacora.jasper", parametersMap, conexionBD.conn);
                conexionBD.cerrarConexion();
                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream outputstream = response.getOutputStream();
                outputstream.write(bytes, 0, bytes.length);
                outputstream.flush();
                outputstream.close();

            }

            if ("2".equals(opcion_de_salida)) { //SALIDA EN XLS
                /*JasperReport jasperReport = JasperCompileManager.compileReport("C:\\Users\\next\\Documents\\NetBeansProjects\\SI_BECAS\\web\\REPORTES\\101_reporte_bitacora.jrxml");
                ConexionBD conexionBD = new ConexionBD();
                conexionBD.abrirConexion();
                JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parametersMap, conexionBD.conn);
                conexionBD.cerrarConexion();
                JRXlsExporter exporter = new JRXlsExporter();
                exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
                exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, "C:\\a.xls");
                exporter.exportReport();*/

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

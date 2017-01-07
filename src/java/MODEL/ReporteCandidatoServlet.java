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
@WebServlet("/ReporteCandidatoServlet")
public class ReporteCandidatoServlet extends HttpServlet {

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
            String reporte_tipobeca = request.getParameter("REPORTE_TIPOBECA");
            String reporte_facultad = request.getParameter("REPORTE_FACULTAD");
            String reporte_tipoestudio = request.getParameter("REPORTE_TIPOESTUDIO");
            String reporte_institucion = request.getParameter("REPORTE_INSTITUCION");
            String reporte_reporte_nombre_usuario = request.getParameter("REPORTE_NOMBRE_USUARIO");
            String reporte_reporte_rol_usuario = request.getParameter("REPORTE_ROL_USUARIO");
            String opcion_de_salida = request.getParameter("OPCION_DE_SALIDA");
            String query="";
            query= request.getParameter("QUERY");

            //preparando parametros para el reporte
            //Map parametersMap = new HashMap();
            
            /*parametersMap.put("NOMBRE1", "%");
            parametersMap.put("NOMBRE2", "%");
            parametersMap.put("APELLIDO1", "%");
            parametersMap.put("APELLIDO2", "%");
            System.out.println(new Date((2016 - 1900), 1, 1));
            System.out.println(new Date((2016 - 1900), 12, 31));
            parametersMap.put("FECHA1", new Date((2016 - 1900), 1, 1));
            parametersMap.put("FECHA2", new Date((2016 - 1900), 12, 31));
            parametersMap.put("ID_ACCION_MENOR", 0);
            parametersMap.put("ID_ACCION_MAYOR", 10);
            parametersMap.put("NOMBRE_USUARIO", "JOSE ALEXIS BELTRAN SERRANO");
            parametersMap.put("ROL_USUARIO", "ADMINISTRADOR");*/
          //  PrintStream salida = null
          Map parametersMap=new HashMap();
          parametersMap.put("paramtest", "EXTERNA");
               // parametersMap=null;
            if ("1".equals(opcion_de_salida)) { //SALIDA EN PDF     
                
            
                ConexionBD conexionBD = new ConexionBD();
                conexionBD.abrirConexion();
                String dir="C:\\Users\\MauricioBC\\Documents\\NetBeansProjects\\SI_BECAS\\web\\REPORTES\\ReporteCandidatos.jrxml";
                 String dir2="C:\\Users\\MauricioBC\\Documents\\NetBeansProjects\\SI_BECAS\\web\\REPORTES\\ReporteCandidatos.Jasper";
               // InputStream entrada = new ByteArrayInputStream(dir.getBytes(StandardCharsets.UTF_8));
              //  salida.print(dir2);
                /*JasperDesign jd=JRXmlLoader.load(dir);
                String sql=query;
                JRDesignQuery newQuery= new JRDesignQuery();
                newQuery.setText(sql);
                JasperReport jr=JasperCompileManager.compileReport(jd);*/
                //JasperPrint jp=JasperFillManager.fillReport(jr, null, conexionBD.conn);
                //JasperViewer.viewReport(jp);
                //byte[] bytes = JasperRunManager.runReportToPdf("C:\\Users\\MauricioBC\\Documents\\NetBeansProjects\\SI_BECAS\\web\\REPORTES\\ReporteCandidatos.jasper", parametersMap, conexionBD.conn);
                //JasperReport jr=JasperCompileManager.compileReport(dir);
                //JasperCompileManager.compileReportToStream(entrada, salida);
                byte[] bytes = JasperRunManager.runReportToPdf(dir2, null, conexionBD.conn);
              
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

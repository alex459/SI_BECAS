/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.ConexionBD;
import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import DAO.TipoDocumentoDAO;
import POJO.Documento;
import POJO.Expediente;
import POJO.SolicitudDeBeca;
import POJO.TipoDocumento;
import POJO.Usuario;
import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author MauricioBC
 */
@WebServlet("/SolAcuerdoAnioFiscalServlet")
@MultipartConfig(maxFileSize = 16177215)
public class AcuerdoAnioFiscal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Obtener el id del expediente del usuario actual
        int idUser, idExp;
        String user=request.getParameter("user");
            ConexionBD conexionbd = null;
            ResultSet rs = null;
            Usuario temp1=new Usuario();
            SolicitudDeBeca temp2=new SolicitudDeBeca();
            //////////Obtener el id del usuario
             try {
                //formando la consulta
                String consultaSql="SELECT ID_USUARIO FROM USUARIO WHERE NOMBRE_USUARIO='"+user+"';";
                //realizando la consulta
                conexionbd = new ConexionBD();
                rs = conexionbd.consultaSql(consultaSql); 
                temp1 = new Usuario();
                if(rs.next()) {
                    temp1.setIdUsuario(rs.getInt("ID_USUARIO"));
                }
                //con el rs se llenara la tabla de resultados
            } catch (Exception ex) {
                System.out.println(ex);
            }
            idUser=temp1.getIdUsuario();
            ////////Obtener el id del expediente
             try {
                //formando la consulta
                String consultaSql= "SELECT ID_EXPEDIENTE FROM SOLICITUD_DE_BECA WHERE ID_USUARIO="+idUser;
                //realizando la consulta
                conexionbd = new ConexionBD();
                rs = conexionbd.consultaSql(consultaSql); 
                temp2 = new SolicitudDeBeca();
                if(rs.next()) {
                    temp2.setIdExpediente(rs.getInt("ID_EXPEDIENTE"));
                }
                //con el rs se llenara la tabla de resultados
            } catch (Exception ex) {
                System.out.println(ex);
            }
            idExp=temp2.getIdExpediente();
        ///////////////////////////////////////////////////////////////////
        
        //Agarrando el pdf
        int tip1 = 116;
        String obs = "Solicitud de acuerdo de año fiscal ingresada";        
        //1er archivo, 1ra carta de sol de prorroga
        InputStream archivo1 = null;
        Part filePart1 = request.getPart("doc_digital");
        if (filePart1 != null) {
            archivo1 = filePart1.getInputStream();
        }
        
        Date fechaHoy = new Date();
        java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());  
        Documento documento1 = new Documento();
        DocumentoDAO docdao = new DocumentoDAO();
        TipoDocumento tipo1 = new TipoDocumento();
        TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
        ExpedienteDAO expDao = new ExpedienteDAO();
        //Insertando el pdf 1
        int idDoc1=docdao.getSiguienteId();
        tipo1 = tipoDao.consultarPorId(tip1);
        Expediente idexpediente = expDao.consultarPorId(idExp);  
        String Estado = "Pendiente";        
        documento1.setIdDocumento(idDoc1);
        documento1.setFechaIngreso(sqlDate);
        documento1.setFechaSolicitud(sqlDate);
        documento1.setIdTipoDocumento(tipo1);
        documento1.setDocumentoDigital(archivo1);
        documento1.setIdExpediente(idexpediente);
        documento1.setObservacion(obs);
        documento1.setEstadoDocumento(Estado);     
        boolean ing1 = docdao.Ingresar(documento1);
        System.out.println("resultado de doc "+ing1);
        
            if(ing1==true){
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se ingreso la solicitud correctamente.");
        }else{
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo ingresar la solicitud");
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

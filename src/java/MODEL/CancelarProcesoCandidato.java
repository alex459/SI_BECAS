/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.OfertaBecaDAO;
import DAO.InstitucionDAO;
import DAO.DocumentoDAO;
import DAO.ExpedienteDAO;
import DAO.TipoDocumentoDAO;
import POJO.Institucion;
import POJO.OfertaBeca;
import POJO.Documento;
import POJO.Expediente;
import POJO.TipoDocumento;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
@WebServlet("/CancelarProcesoCandidato")
public class CancelarProcesoCandidato extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8"); 
        request.setCharacterEncoding("UTF-8");
        Expediente exp=new Expediente();
        ExpedienteDAO expDAO=new ExpedienteDAO();
        int id=Integer.parseInt(request.getParameter("id_exp"));
        exp.setIdExpediente(id);
        exp.setIdProgreso(1);
        exp.setEstadoExpediente("CERRADO");
        exp.setEstadoProgreso("EN PROCESO");
        
        Boolean exito=expDAO.actualizarExpediente(exp);
        if(exito){
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se ha cerrado el proceso de obtención de beca correctamente");
        }else{
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo cerrar el proceso");
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

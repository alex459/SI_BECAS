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
@WebServlet("/ActualizarAutorizacionInicialServlet")
@MultipartConfig(maxFileSize = 16177215)
public class ActualizarAutorizacionInicialServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       response.setContentType("text/html;charset=UTF-8");
        
        //Recuperando datos del formulario
        InputStream cartaSolicitud = null;
        int idexp = Integer.parseInt(request.getParameter("idexp"));
        Integer idDoc = Integer.parseInt(request.getParameter("idDoc"));
        Integer nAnexos = Integer.parseInt(request.getParameter("nAnexos"));
        Part filePart = request.getPart("cartaSolicitud");
        if (filePart != null) {
            cartaSolicitud = filePart.getInputStream();
        }
        
        ExpedienteDAO expDao = new ExpedienteDAO();
        Expediente expediente = new Expediente();
        
        expediente.setIdExpediente(idexp);
        expediente.setEstadoExpediente("ABIERTO");
        expediente.setIdProgreso(2);
        expediente.setEstadoProgreso("EN PROCESO");
        expDao.actualizarExpediente(expediente);
        
        //boolean expedienteCreado = expDao.ingresar(expediente);
        boolean ingresarDocumento = false;
        
            //Ingresar Carta de Solicitud
            Documento documento = new Documento();
            DocumentoDAO documentoDao = new DocumentoDAO();
            TipoDocumento tipo = new TipoDocumento();
        
            documento.setIdDocumento(idDoc);
            documento.setDocumentoDigital(cartaSolicitud);
            ingresarDocumento = documentoDao.ActualizarDocDig(documento);
            
            //Agregar a bitacora accion
            //Utilidades.nuevaBitacora(1, request.getSession().getAttribute("user").toString(), "Error al ingresar solicitud de Permiso Inicial");
        
        
        
        if(ingresarDocumento== true){
            
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se modifico el documento de autorizacion Inicial correctamente.");
        }
        else
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo modifico el documento de la solicitud del Acuerdo de autorizacion Inicial.");
    
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

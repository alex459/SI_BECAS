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
@WebServlet("/SolAcuerdoAnioFiscalServlet")
@MultipartConfig(maxFileSize = 16177215)
public class AcuerdoAnioFiscal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Agarrando el pdf
        Integer tip = 2; //id del tipo de documento = oferta de beca
        String obs = "Oferta de Beca de Postgrado";
        InputStream archivo = null;
        Part filePart = request.getPart("doc_digital");
        if (filePart != null) {
            archivo = filePart.getInputStream();
        }
        
        Date fechaHoy = new Date();
        OfertaBeca ofertaBeca = new OfertaBeca();
        OfertaBecaDAO ofertaBecaDAO = new OfertaBecaDAO();
        InstitucionDAO institucionDAO = new InstitucionDAO();
        java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());  
        Documento documento = new Documento();
        DocumentoDAO docdao = new DocumentoDAO();
        TipoDocumento tipo = new TipoDocumento();
        TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
        ExpedienteDAO expDao = new ExpedienteDAO();


           //Insertando el pdf
        int idDoc=docdao.getSiguienteId();
        tipo = tipoDao.consultarPorId(tip);
        Integer idexp = 0;
        Expediente idexpediente = expDao.consultarPorId(idexp);  
        String Estado = "Difusion";        
        documento.setIdDocumento(idDoc);
        documento.setIdTipoDocumento(tipo);
        documento.setDocumentoDigital(archivo);
        documento.setIdExpediente(idexpediente);
        documento.setObservacion(obs);
        documento.setEstadoDocumento(Estado);     
        boolean ing = docdao.Ingresar(documento);
        System.out.println("resultado de doc "+ing);
        
            if(ing){
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se ingreso la oferta correctamente.");
        }else{
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo ingresar la oferta");
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

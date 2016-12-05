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
@WebServlet("/AgregarOfertaBecaServlet")
@MultipartConfig(maxFileSize = 16177215)
public class AgregarOfertaBecaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8"); 
        request.setCharacterEncoding("UTF-8");
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


        //parte de lectura desde el jsp y guardado en bd     
        int idOfertaBeca = ofertaBecaDAO.getSiguienteId();
        ofertaBeca.setIdOfertaBeca(idOfertaBeca);
        ofertaBeca.setIdInstitucionEstudio(institucionDAO.consultarIdPorNombre(request.getParameter("institucionEstudio")));
        ofertaBeca.setIdInstitucionFinanciera(institucionDAO.consultarIdPorNombre(request.getParameter("institucionOferente")));
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
        
        //asignar valores a oferta de beca
        ofertaBeca.setIdDocumento(idDoc);
        ofertaBeca.setNombreOferta(request.getParameter("nombreOferta"));
        ofertaBeca.setTipoOfertaBeca(request.getParameter("tipoBeca"));
        
        System.out.println("PRUEBA");
        ofertaBeca.setDuracion(Integer.parseInt(request.getParameter("duracion")));
       //  System.out.println(request.getParameter("fechaCierre"));
       ofertaBeca.setDuracion(Integer.parseInt(request.getParameter("duracion")));
        java.sql.Date sqlDate2 = new java.sql.Date(StringAFecha(request.getParameter("fechaCierre")).getTime());
        ofertaBeca.setFechaCierre(sqlDate2);
        ofertaBeca.setModalidad(request.getParameter("modalidad"));
        java.sql.Date sqlDate3 = new java.sql.Date(StringAFecha(request.getParameter("fechaInicio")).getTime());
        ofertaBeca.setFechaInicio(sqlDate3);
        
        ofertaBeca.setIdioma(request.getParameter("idioma"));
        ofertaBeca.setPerfil(request.getParameter("perfilBeca"));
        ofertaBeca.setFinanciamiento(request.getParameter("financiamiento"));        
        ofertaBeca.setFechaIngreso(sqlDate);
        ofertaBeca.setTipoEstudio(request.getParameter("tipoEstudio"));
        ofertaBeca.setOfertaBecaActiva(1);
        
        Boolean exito=ofertaBecaDAO.ingresar(ofertaBeca);
        
        if(exito){
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

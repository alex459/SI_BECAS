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
@WebServlet("/ModificarOfertaBecaServlet")
@MultipartConfig(maxFileSize = 16177215)
public class ModificarOfertaBecaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8"); 
        request.setCharacterEncoding("UTF-8");
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
        
        
        ////////////////////---------------------------
         InputStream archivo = null;
        Part filePart = request.getPart("doc_digital");
        if (filePart != null) {
            archivo = filePart.getInputStream();
        }
        DocumentoDAO documentoDao = new DocumentoDAO();    
        int idDoc=Integer.parseInt(request.getParameter("ID_DOCUMENTO"));        
        documento.setIdDocumento(idDoc);
        System.out.println("id servlet "+idDoc);
        documento.setDocumentoDigital(archivo);
        boolean act = false;
        if (filePart.getSize() >0){
        act = documentoDao.ActualizarDocumentoObservacion(documento);
        } else{
            act = documentoDao.ActualizarObservacion(documento);
        }
        ///////////////---------------------
        
        
        
        //Agarrando el pdf       
    /*    int idDoc=Integer.parseInt(request.getParameter("ID_DOCUMENTO"));
        Integer tip = 2; //id del tipo de documento = oferta de beca
        String obs = "Oferta de Beca de Postgrado";
        InputStream archivo = null;
        if(request.getPart("doc_digital").getSize()==0){
        Part filePart = request.getPart("doc_digital");
        if (filePart != null) {
            archivo = filePart.getInputStream();
        }
        //Insertando el pdf      
        documento.setIdDocumento(idDoc);
        documento.setDocumentoDigital(archivo);
        boolean ing = docdao.ActualizarDocDig(documento);
        System.out.println("resultado de doc "+ing);
        }*/
        //asignar valores a oferta de beca
        ofertaBeca.setIdDocumento(idDoc);
        
        //parte de lectura desde el jsp y guardado en bd     
        ofertaBeca.setIdOfertaBeca(Integer.parseInt(request.getParameter("idOferta")));
        ofertaBeca.setIdInstitucionEstudio(institucionDAO.consultarIdPorNombre(request.getParameter("institucionEstudio")));
        ofertaBeca.setIdInstitucionFinanciera(institucionDAO.consultarIdPorNombre(request.getParameter("institucionOferente")));
        //ofertaBeca.setIdDocumento(1);
        ofertaBeca.setNombreOferta(request.getParameter("nombreOferta"));
        ofertaBeca.setTipoOfertaBeca(request.getParameter("tipoBeca"));
        ofertaBeca.setDuracion(Integer.parseInt(request.getParameter("duracion")));
        
        java.sql.Date sqlDate2 = new java.sql.Date(StringAFecha(request.getParameter("fechaCierre")).getTime());
       
        ofertaBeca.setFechaCierre(sqlDate2);
        ofertaBeca.setModalidad(request.getParameter("modalidad"));
        System.out.println(request.getParameter("fechaCierre"));
        java.sql.Date sqlDate3 = new java.sql.Date(StringAFecha(request.getParameter("fechaInicio")).getTime());
         
        ofertaBeca.setFechaInicio(sqlDate3);
        ofertaBeca.setIdioma(request.getParameter("idioma"));
        ofertaBeca.setPerfil(request.getParameter("perfilBeca"));
        ofertaBeca.setFinanciamiento(request.getParameter("financiamiento"));        
        ofertaBeca.setFechaIngreso(sqlDate);
        ofertaBeca.setTipoEstudio(request.getParameter("tipoEstudio"));
        ofertaBeca.setOfertaBecaActiva(1);
        Boolean exito=ofertaBecaDAO.modificar(ofertaBeca);
        if(exito){
            Utilidades.nuevaBitacora(2, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()), "Se modifico la oferta de beca: " + ofertaBeca.getNombreOferta() + " con id "+ofertaBeca.getIdOfertaBeca()+".", "");
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se modifico la oferta correctamente.");
        }else{
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo modificar la oferta de beca");
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

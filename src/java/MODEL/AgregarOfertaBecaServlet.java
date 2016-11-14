/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.OfertaBecaDAO;
import DAO.InstitucionDAO;
import DAO.DocumentoDAO;
import POJO.Institucion;
import POJO.OfertaBeca;
import POJO.Documento;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MauricioBC
 */
public class AgregarOfertaBecaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Date fechaHoy = new Date();
        OfertaBeca ofertaBeca = new OfertaBeca();
        OfertaBecaDAO ofertaBecaDAO = new OfertaBecaDAO();
        InstitucionDAO institucionDAO = new InstitucionDAO();

        //parte de lectura desde el jsp y guardado en bd     
        int idOfertaBeca = ofertaBecaDAO.getSiguienteId();
        ofertaBeca.setIdOfertaBeca(idOfertaBeca);
        ofertaBeca.setIdInstitucionEstudio(institucionDAO.consultarIdPorNombre(request.getParameter("institucionEstudio")));
        ofertaBeca.setIdInstitucionFinanciera(institucionDAO.consultarIdPorNombre(request.getParameter("institucionOferente")));
        ofertaBeca.setIdDocumento(1);
        ofertaBeca.setNombreOferta(request.getParameter("nombreOferta"));
        ofertaBeca.setTipoOfertaBeca(request.getParameter("tipoBeca"));
        ofertaBeca.setDuracion(Integer.parseInt(request.getParameter("duracion")));
         System.out.println(request.getParameter("fechaCierre"));
        ofertaBeca.setFechaCierre(StringAFecha(request.getParameter("fechaCierre")));
       
        ofertaBeca.setModalidad(request.getParameter("modalidad"));
        ofertaBeca.setFechaInicio(StringAFecha(request.getParameter("fechaInicio")));
        ofertaBeca.setIdioma(request.getParameter("idioma"));
        ofertaBeca.setPerfil(request.getParameter("perfilBeca"));
        ofertaBeca.setFechaIngreso(fechaHoy);
        ofertaBeca.setTipoEstudio(request.getParameter("tipoEstudio"));
        ofertaBeca.setOfertaBecaActiva(1);
        ofertaBecaDAO.ingresar(ofertaBeca);
    }

    public Date StringAFecha(String fecha) {
        DateFormat formatter = null;
        Date convertedDate = null;
        formatter =new SimpleDateFormat("dd/MM/yyyy");    
        try {
            convertedDate =(Date) formatter.parse(fecha);
            Date fechaConvertida =formatter.parse(fecha);
            System.out.println("XXXXXXXXXXXX" +convertedDate);
            return convertedDate;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
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

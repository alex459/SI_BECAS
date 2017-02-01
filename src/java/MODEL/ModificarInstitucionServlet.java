/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.InstitucionDAO;
import POJO.Institucion;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jose
 */
@WebServlet(name = "ModificarInstitucionServlet", urlPatterns = {"/ModificarInstitucionServlet"})
public class ModificarInstitucionServlet extends HttpServlet {

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
        
        try{
            
            Integer ID_INSTITUCION = Integer.parseInt(request.getParameter("ID_INSTITUCION"));
            String NOMBRE_INSTITUCION = request.getParameter("text_NomInstitucion");
            String PAIS = request.getParameter("tex_paisInstitucion");
            String URL = request.getParameter("tex_webInstitucion");
            String EMAIL = request.getParameter("tex_correoInstitucion");
            String TIPO_INSTITUCION = request.getParameter("select_tipoInstitucion");
            Integer INSTITUCION_ACTIVA = Integer.parseInt(request.getParameter("select_InstitucionActiva"));
            
            Institucion institucion = new Institucion();
            InstitucionDAO institucionDao = new InstitucionDAO();
            boolean bandera1 = false;
            
            institucion.setIdInstitucion(ID_INSTITUCION);
            institucion.setNombreInstitucion(NOMBRE_INSTITUCION);
            institucion.setPais(PAIS);
            institucion.setPaginaWeb(URL);
            institucion.setEmail(EMAIL);
            institucion.setTipoInstitucion(TIPO_INSTITUCION);
            institucion.setInstitucionActiva(INSTITUCION_ACTIVA);
            
            bandera1 = institucionDao.actualizar(institucion);
            
            
            if(bandera1){
                if(institucionDao.validarInstitucionRepetida(institucion.getNombreInstitucion(), institucion.getPais())){
                Utilidades.nuevaBitacora(2, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()) , "Se actualizo la institución "+ institucion.getNombreInstitucion() + ".","");
                Utilidades.mostrarMensaje(response, 1, "Exito", "Se modificó la institucion correctamente.");
                }else{
                    Utilidades.mostrarMensaje(response, 2, "Error", "Ya existe una institución con el mismo nombre en el mismo país.");
                }
            }else{
                Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo modificar la institucion.");
            }
            
        }catch(Exception ex){
            System.out.println("ERROR: "+ex);
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo modificar la institucion.");
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

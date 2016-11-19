/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.DetalleUsuarioDAO;
import DAO.UsuarioDAO;
import POJO.DetalleUsuario;
import POJO.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author next
 */
@WebServlet("/AgregarUsuarioServlet")
public class AgregarUsuarioServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        Usuario usuario = new Usuario();
        DetalleUsuario detalleUsuario = new DetalleUsuario();
        UsuarioDAO usuarioDao = new UsuarioDAO();
        DetalleUsuarioDAO detalleUsuarioDao = new DetalleUsuarioDAO();
        
        boolean bandera1 = false;
        boolean bandera2 = false;
        
        //parte de lectura desde el jsp y guardado en bd     
        int idUsuario = usuarioDao.getSiguienteId();
        usuario.setIdUsuario(idUsuario);
        usuario.setIdTipoUsuario(Integer.parseInt(request.getParameter("ID_TIPO_USUARIO")));
        usuario.setNombreUsuario(request.getParameter("CARNET"));
        usuario.setClave(request.getParameter("CLAVE"));
        bandera1 = usuarioDao.ingresar(usuario); //guardando usuario
        int idDetalleUsuario = detalleUsuarioDao.getSiguienteId();
        detalleUsuario.setIdDetalleUsuario(idDetalleUsuario);
        detalleUsuario.setIdUsuario(idUsuario);
        detalleUsuario.setIdFacultad(Integer.parseInt(request.getParameter("ID_FACULTAD")));
        detalleUsuario.setCarnet(request.getParameter("CARNET"));
        detalleUsuario.setNombre1Du(request.getParameter("NOMBRE1_DU"));
        detalleUsuario.setNombre2Du(request.getParameter("NOMBRE2_DU"));
        detalleUsuario.setApellido1Du(request.getParameter("APELLIDO1_DU"));
        detalleUsuario.setApellido2Du(request.getParameter("APELLIDO2_DU"));
        bandera2 = detalleUsuarioDao.ingresarOpcion2(detalleUsuario); //guardando detalle usuario
                
        //Redireccionando a la pagina de mensaje general    
        if(bandera1 && bandera2)
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se ingreso el usuario correctamente.");
        else
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo ingresar el usuario.");
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

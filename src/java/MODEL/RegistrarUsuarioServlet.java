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
 * @author jose
 */
@WebServlet(name = "RegistrarUsuarioServlet", urlPatterns = {"/RegistrarUsuarioServlet"})
public class RegistrarUsuarioServlet extends HttpServlet {

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

        Usuario usuario = new Usuario();
        DetalleUsuario detalleUsuario = new DetalleUsuario();
        UsuarioDAO usuarioDao = new UsuarioDAO();
        DetalleUsuarioDAO detalleUsuarioDao = new DetalleUsuarioDAO();
        String clave2 = new String();

        boolean bandera1 = false;
        boolean bandera2 = false;
        boolean validacion1 = true; //nombre de usuario identico                
        String mensaje = new String();

        //parte de lectura desde el jsp y guardado en bd     
        int idUsuario = usuarioDao.getSiguienteId();
        usuario.setIdUsuario(idUsuario);
        usuario.setIdTipoUsuario(1); //candidato
        usuario.setNombreUsuario(request.getParameter("CARNET"));
        usuario.setClave(request.getParameter("CLAVE"));
        int idDetalleUsuario = detalleUsuarioDao.getSiguienteId();
        detalleUsuario.setIdDetalleUsuario(idDetalleUsuario);
        detalleUsuario.setIdUsuario(idUsuario);
        detalleUsuario.setCarnet(request.getParameter("CARNET"));
        detalleUsuario.setEmail(request.getParameter("EMAIL"));
        detalleUsuario.setGenero(request.getParameter("GENERO"));
        detalleUsuario.setNombre1Du(request.getParameter("NOMBRE1_DU"));
        detalleUsuario.setNombre2Du(request.getParameter("NOMBRE2_DU"));
        detalleUsuario.setApellido1Du(request.getParameter("APELLIDO1_DU"));
        detalleUsuario.setApellido2Du(request.getParameter("APELLIDO2_DU"));
        usuario.setNombreUsuario(request.getParameter("CARNET"));
        detalleUsuario.setIdFacultad(Integer.parseInt(request.getParameter("ID_FACULTAD")));
        detalleUsuario.setCarnet(request.getParameter("CARNET"));
        detalleUsuario.setNombre1Du(request.getParameter("NOMBRE1_DU"));
        detalleUsuario.setNombre2Du(request.getParameter("NOMBRE2_DU"));
        detalleUsuario.setApellido1Du(request.getParameter("APELLIDO1_DU"));
        detalleUsuario.setApellido2Du(request.getParameter("APELLIDO2_DU"));

        //validacion 1
        validacion1 = usuarioDao.nombreDeUsuarioRepetido(usuario.getNombreUsuario());
        if (!validacion1) {
            mensaje = mensaje.concat(" El usuario no debe repetirse. ");
        }


        if (validacion1) {
            
            //id_usuario es para la bitacora.
            int id_user_login = Integer.parseInt(request.getSession().getAttribute("id_user_login").toString());
            bandera1 = usuarioDao.ingresar(usuario); //guardando usuario
            bandera2 = detalleUsuarioDao.ingresarOpcion2(detalleUsuario); //guardando detalle usuario

            //Redireccionando a la pagina de mensaje general    
            if (bandera1 && bandera2) {
                Utilidades.nuevaBitacora(1, usuario.getIdUsuario(), "Se ingreso el usuario " + usuario.getNombreUsuario() + ".","");                
                Utilidades.mostrarMensajeOpcion2(response, 1, "Exito", "Se ha registrado correctamente. Ingrese nuevamente.");                
            } else {
                Utilidades.mostrarMensajeOpcion2(response, 2, "Error", "No se pudo registrar correctamente.");
            }

        }else{
            Utilidades.mostrarMensajeOpcion2(response, 2, "Error", "No se pudo registrar correctamente.");
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

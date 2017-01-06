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
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author next
 */
@WebServlet("/ActualizarUsuarioServlet")
public class ActualizarUsuarioServlet extends HttpServlet {

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
        
        boolean validacion2 = false; //claves iguales
        boolean validacion3 = false; //tipo usuario con facultad
        String mensaje = new String();
        
        //parte de lectura desde el jsp y guardado en bd     
        
        usuario.setIdUsuario(Integer.parseInt(request.getParameter("ID_USUARIO")));
        usuario.setIdTipoUsuario(Integer.parseInt(request.getParameter("ID_TIPO_USUARIO")));
        usuario.setNombreUsuario(request.getParameter("CARNET"));
        usuario.setClave(request.getParameter("CLAVE"));
        clave2 = request.getParameter("CLAVE2");
        
        detalleUsuario.setIdDetalleUsuario(Integer.parseInt(request.getParameter("ID_DETALLE_USUARIO")));
        detalleUsuario.setIdUsuario(Integer.parseInt(request.getParameter("ID_USUARIO")));
        detalleUsuario.setIdFacultad(Integer.parseInt(request.getParameter("ID_FACULTAD")));
        detalleUsuario.setCarnet(request.getParameter("CARNET"));
        detalleUsuario.setNombre1Du(request.getParameter("NOMBRE1_DU"));
        detalleUsuario.setNombre2Du(request.getParameter("NOMBRE2_DU"));
        detalleUsuario.setApellido1Du(request.getParameter("APELLIDO1_DU"));
        detalleUsuario.setApellido2Du(request.getParameter("APELLIDO2_DU"));
        detalleUsuario.setEmail(request.getParameter("EMAIL"));
        detalleUsuario.setGenero(request.getParameter("GENERO"));
        
        
        //validacion 2
        if (clave2.equals(usuario.getClave())) {
            validacion2 = true;
        } else {
            mensaje = mensaje.concat("  Las claves no coniciden. ");
        }
        
        //validacion 3
        Integer t_u = usuario.getIdTipoUsuario();
        Integer fac = detalleUsuario.getIdFacultad();
        if(t_u==1 || t_u==2 || t_u==3 || t_u==4){
            if(fac == 13){
                mensaje = mensaje.concat("  Los candidatos, becarios, comisiones o juntas directivas deben tener una facultad que no sea Administrativa.");
            }else{
                validacion3 = true;
            }
        }else{            
                validacion3 = true;
                detalleUsuario.setIdFacultad(13);            
        }
        
        
        
        if (validacion2 && validacion3) {
            int id_user_login = Integer.parseInt(request.getSession().getAttribute("id_user_login").toString());
            bandera1 = usuarioDao.actualizar(usuario, id_user_login); //guardando usuario
            bandera2 = detalleUsuarioDao.actualizarOpcion2(detalleUsuario, id_user_login); //guardando detalle usuario

            //Redireccionando a la pagina de mensaje general    
            if (bandera1 && bandera2) {
                //Utilidades.nuevaBitacora(2, request.getSession().getAttribute("user").toString(), "Se actualizo el usuario "+usuario.getNombreUsuario()+".");
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se actualizo el usuario correctamente.");
            } else {
                Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo actualizar el usuario.");
            }

        }else{
            Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo actualizar el usuario. " + mensaje);
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

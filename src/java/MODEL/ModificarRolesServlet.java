/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.DetalleUsuarioDAO;
import DAO.ExpedienteDAO;
import DAO.TipoUsuarioDao;
import DAO.UsuarioDAO;
import POJO.DetalleUsuario;
import POJO.TipoUsuario;
import POJO.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ModificarRolesServlet")
public class ModificarRolesServlet extends HttpServlet {

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
        
        Usuario usuarioActualizado = new Usuario();
        DetalleUsuario detalleUsuarioActualizado = new DetalleUsuario();
        UsuarioDAO usuarioDao = new UsuarioDAO();
        DetalleUsuarioDAO detalleUsuarioDao = new DetalleUsuarioDAO();
        String clave2 = new String();
        
        boolean bandera1 = false;
        boolean bandera2 = false;
        
        boolean validacion1 = false; //no se puede actualizar candidatos ni becarios con procesos activos de becas        
        boolean validacion3 = false; //tipo usuario con facultad
        boolean validacion4 = false; //evitar autoactualizacion
        String mensaje = new String();
        
        //parte de lectura desde el jsp y guardado en bd     
        try{
        usuarioActualizado.setIdUsuario(Integer.parseInt(request.getParameter("ID_USUARIO")));
        usuarioActualizado.setIdTipoUsuario(Integer.parseInt(request.getParameter("ID_TIPO_USUARIO")));
        usuarioActualizado.setNombreUsuario(request.getParameter("CARNET"));        
        
        detalleUsuarioActualizado.setIdDetalleUsuario(Integer.parseInt(request.getParameter("ID_DETALLE_USUARIO")));
        detalleUsuarioActualizado.setIdFacultad(Integer.parseInt(request.getParameter("ID_FACULTAD")));
        
        }catch(Exception e){
            e.printStackTrace();            
        }
        
        //validacion 1 //que sea un becario o candidato que tiene un proceso de beca
        Usuario usuarioAnterior = new Usuario();
        DetalleUsuario detalleUsuarioAnterior = new DetalleUsuario();
        usuarioAnterior = usuarioDao.consultarPorId(usuarioActualizado.getIdUsuario());
        detalleUsuarioAnterior = detalleUsuarioDao.consultarPorId(detalleUsuarioActualizado.getIdDetalleUsuario());
        if(usuarioAnterior.getIdTipoUsuario() != usuarioActualizado.getIdTipoUsuario()){
            if(usuarioAnterior.getIdTipoUsuario() == 1 || usuarioAnterior.getIdTipoUsuario() == 2){
                ExpedienteDAO expedienteDao = new ExpedienteDAO();
                if(expedienteDao.expedienteAbiertoPorIdUsuario(usuarioAnterior.getIdUsuario())){
                    mensaje = mensaje.concat("No se puede cambiar el rol del usuario si tiene un proceso de beca en curso.");
                    validacion1 = false;
                }else{
                    validacion1 = true;
                }
            }else{
                validacion1 = true;
            }
        }else{
            validacion1 = true;
        }
                
        
        //validacion 3
        Integer t_u = usuarioActualizado.getIdTipoUsuario();
        Integer fac = detalleUsuarioActualizado.getIdFacultad();
        if(t_u==1 || t_u==2 || t_u==3 || t_u==4){
            if(fac == 13){
                mensaje = mensaje.concat("  Los candidatos, becarios, comisiones o juntas directivas deben tener una facultad diferente de Administrativa.");
            }else{
                validacion3 = true;
            }
        }else{            
                validacion3 = true;
                detalleUsuarioActualizado.setIdFacultad(13);            
        }
        
        //validacion 4
        if(request.getSession().getAttribute("user").equals(usuarioAnterior.getNombreUsuario())){
            mensaje = mensaje.concat("No se puede cambiar el rol de su usuario mientras se encuentra logeado.");
            validacion4 = false;
        }else{
            validacion4 = true;
        }
        
        if (validacion1 && validacion3 && validacion4) {
            int id_user_login = Integer.parseInt(request.getSession().getAttribute("id_user_login").toString());
            bandera1 = usuarioDao.actualizarRolPorIdUsuario(usuarioActualizado.getIdUsuario(), usuarioActualizado.getIdTipoUsuario());
            bandera2 = detalleUsuarioDao.actualizarFacultadPorIdDetalleUsuario(detalleUsuarioActualizado.getIdDetalleUsuario(), detalleUsuarioActualizado.getIdFacultad());

            //Redireccionando a la pagina de mensaje general    
            if (bandera1 && bandera2) {
            TipoUsuario tipoUsuario = new TipoUsuario();
            TipoUsuarioDao tipoUsuarioDao = new TipoUsuarioDao();
            tipoUsuario = tipoUsuarioDao.consultarPorId(usuarioActualizado.getIdTipoUsuario());
            Utilidades.nuevaBitacora(2, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()) , "Se cambio del rol del usuario "+usuarioActualizado.getNombreUsuario() +".",""); 
            Utilidades.mostrarMensaje(response, 1, "Exito", "Se ha cambiado el rol del usuario correctamente.");
            } else {
                Utilidades.mostrarMensaje(response, 2, "Error", "No se ha podido cambiar el rol del usuario.");
            usuarioDao.actualizarRolPorIdUsuario(usuarioAnterior.getIdUsuario(), usuarioAnterior.getIdTipoUsuario());
            detalleUsuarioDao.actualizarFacultadPorIdDetalleUsuario(detalleUsuarioAnterior.getIdDetalleUsuario(), detalleUsuarioAnterior.getIdFacultad());
            }

        }else{
            Utilidades.mostrarMensaje(response, 2, "Error", "No ha podido cambiar el rol del usuario. " + mensaje);
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

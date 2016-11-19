package MODEL;

import DAO.BitacoraDAO;
import DAO.UsuarioDAO;
import POJO.Bitacora;
import POJO.Usuario;
import java.util.Calendar;
import javax.servlet.http.HttpServletResponse;

public class Utilidades {

    /**
     * Metodo para redireccionar a una pagina con un mensaje. Este metodo se usa
     * dentro de un servlet. TIPO_MENSAJE 1-exito, 2-info, 3-warning, 4-error
     *
     * @param response
     * @param tipo_mensaje
     * @param titulo
     * @param mensaje
     */
    public static void mostrarMensaje(HttpServletResponse response, int tipo_mensaje, String titulo, String mensaje) {
        //TIPO_MENSAJE 1-exito, 2-info, 3-warning, 4-error        
        try {
            response.sendRedirect("115_mensaje_general.jsp?TIPO_MENSAJE=" + tipo_mensaje + "&TITULO=" + titulo + "&MENSAJE=" + mensaje);
        } catch (Exception ex) {

        }

    }
    
    /**
     * Metodo para registrar una bitacora nueva.
     * Id_Accion puede ser 1-INGRESAR, 2-ACTUALIZAR, 3-CONSULTAR, 4-ELIMINAR, 5-LOGIN, 6-LOGOUT, 7-REPORTE.
     * usuario_sesion es el usuario logeado, en jsp o en servlet se pude obtener con sesion.getParameter("user").
     * Ejemplo de Descripcion: "Se ingreso un nuevo usuario al sistema con carnet xxxx".
     * 
     * @param Id_accion
     * @param usuario_sesion
     * @param Descripcion 
     */
    public static void nuevaBitacora(Integer Id_accion, String usuario_sesion, String Descripcion) {
        Bitacora temp1 = new Bitacora();
        Usuario temp2 = new Usuario();
        UsuarioDAO temp3 = new UsuarioDAO();
        BitacoraDAO temp4 = new BitacoraDAO();        
        temp1.setIdBitacora(temp4.getSiguienteId());
        temp1.setIdAccion(Id_accion);
        temp2 = temp3.consultarPorNombreUsuario(usuario_sesion);
        temp1.setIdUsuario(temp2.getIdTipoUsuario());
        Calendar calendar = Calendar.getInstance();
        java.util.Date now = calendar.getTime();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());
        temp1.setFechaBitacora(currentTimestamp);
        temp1.setDescripcion(Descripcion);
        temp1.setSqlScript("");
        temp4.ingresar(temp1);
    }
    
    /**
     * Metodo para registrar una bitacora nueva.
     * Id_Accion puede ser 1-INGRESAR, 2-ACTUALIZAR, 3-CONSULTAR, 4-ELIMINAR, 5-LOGIN, 6-LOGOUT, 7-REPORTE.
     * usuario_sesion es el usuario logeado, en jsp o en servlet se pude obtener con request.getSession().getAttribute("user").toString().
     * Ejemplo de Descripcion: "Se ingreso un nuevo usuario al sistema con carnet xxxx".
     * Sql debe contener la sentencia sql.
     * 
     * @param Id_accion
     * @param usuario_sesion
     * @param Descripcion 
     */
    public static void nuevaBitacora(Integer Id_accion, String usuario_sesion, String Descripcion, String Sql) {
        Bitacora temp1 = new Bitacora();
        Usuario temp2 = new Usuario();
        UsuarioDAO temp3 = new UsuarioDAO();
        BitacoraDAO temp4 = new BitacoraDAO();        
        temp1.setIdBitacora(temp4.getSiguienteId());
        temp1.setIdAccion(Id_accion);
        temp2 = temp3.consultarPorNombreUsuario(usuario_sesion);
        temp1.setIdUsuario(temp2.getIdUsuario());
        Calendar calendar = Calendar.getInstance();
        java.util.Date now = calendar.getTime();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());
        temp1.setFechaBitacora(currentTimestamp);
        temp1.setDescripcion(Descripcion);
        temp1.setSqlScript(Sql);
        temp4.ingresar(temp1);
    }

}

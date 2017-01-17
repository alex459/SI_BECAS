package MODEL;

import DAO.BitacoraDAO;
import DAO.UsuarioDAO;
import POJO.Bitacora;
import POJO.Usuario;
import java.util.ArrayList;
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
     * Metodo para registrar una bitacora nueva. Id_Accion puede ser 1-INGRESAR,
     * 2-ACTUALIZAR, 3-CONSULTAR, 4-ELIMINAR, 5-LOGIN, 6-LOGOUT, 7-REPORTE.
     * usuario_sesion es el usuario logeado, en jsp o en servlet se pude obtener
     * con sesion.getParameter("user"). Ejemplo de Descripcion: "Se ingreso un
     * nuevo usuario al sistema con carnet xxxx".
     *
     * @param Id_accion
     * @param usuario_sesion
     * @param Descripcion
     */
    public static void nuevaBitacora(Integer Id_accion, Integer Id_usuario, String Descripcion, String Sql_Script) {
        Bitacora temp1 = new Bitacora();
        BitacoraDAO temp2 = new BitacoraDAO();
        temp1.setIdBitacora(temp2.getSiguienteId());
        temp1.setIdAccion(Id_accion);
        temp1.setIdUsuario(Id_usuario);
        Calendar calendar = Calendar.getInstance();
        java.util.Date now = calendar.getTime();
        java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());
        temp1.setFechaBitacora(currentTimestamp);
        temp1.setDescripcion(Descripcion);
        temp1.setSqlScript(Sql_Script.replaceAll("'", "''"));
        temp2.ingresar(temp1);
    }

    public static boolean verificarPermisos(Integer tipo_usuario_logeado, ArrayList<String> tipo_usuarios_permitidos) {
        boolean respuesta = false;
        
        if (tipo_usuarios_permitidos.size() != 0 || tipo_usuarios_permitidos!=null) {
            for (int i = 0; i < tipo_usuarios_permitidos.size(); i++) {
                if (Integer.parseInt(tipo_usuarios_permitidos.get(i).toString()) == tipo_usuario_logeado) {
                    respuesta = true;
                }
            }
            
        }
        return respuesta;
    }

}

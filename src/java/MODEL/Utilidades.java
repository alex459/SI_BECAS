package MODEL;

import DAO.BitacoraDAO;
import DAO.EnviarCorreo;
import DAO.UsuarioDAO;
import POJO.Bitacora;
import POJO.Usuario;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Properties;
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
    
    public static void mostrarMensajeOpcion2(HttpServletResponse response, int tipo_mensaje, String titulo, String mensaje) {
        //TIPO_MENSAJE 1-exito, 2-info, 3-warning, 4-error        
        try {
            response.sendRedirect("117_mensaje_registro.jsp?TIPO_MENSAJE=" + tipo_mensaje + "&TITULO=" + titulo + "&MENSAJE=" + mensaje);
        } catch (Exception ex) {

        }

    }

    /**
     * Metodo para registrar una bitacora nueva. Id_Accion puede ser 1-INGRESAR,
     * 2-ACTUALIZAR, 3-CONSULTAR, 4-ELIMINAR, 5-LOGIN, 6-LOGOUT, 7-REPORTE, 8-APROBADO, 9-DENEGADO, 10-CORRECCION, 11-SOLICITUD
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
        temp1.setDescripcion(Descripcion.toUpperCase());
        temp1.setSqlScript(Sql_Script.replaceAll("'", "''"));
        temp2.ingresar(temp1);
    }

    /**
     * Compara si el usuario logeado se encuentra en los
     * usuario permitidos dentro del sistema. Si el usuario
     * no tiene permiso retorna false sino true.
     *
     * @param tipo_usuario_logeado
     * @param tipo_usuarios_permitidos
     */
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
    
    /**
     * El metodo se utiliza para enviar correos electronicos
     * a los usuarios especificados. Si no se especifica los
     * usuarios el mensaje se enviara a todos los usuarios
     * del sistema. 
     * Ejemplo de id_usuarios = [1,2,3,4] (Enviando a los usuarios con id 1,2,3 y 4)
     * Ejemplo de id_usuarios = null (enviando a todos los usuarios del sistema.)
     *
     * @param tituloEmail
     * @param mensajeEmail
     * @param id_usuarios
     */
    public static void EnviarCorreo(String tituloEmail, String mensajeEmail, Integer [] id_usuarios){
                
        EnviarCorreo envcorreos = new EnviarCorreo();        
        envcorreos.enviarCorreos(tituloEmail, mensajeEmail, id_usuarios);                
        
    }
    
    //recibe la url de una pagina web y obtiene la raiz.
    public static String ObtenerUrlRaiz(String RequestURL){
        String respuesta = new String();
        for(int i = RequestURL.length()-1; i>=0; i--){
            if(RequestURL.charAt(i) == '/'){
                respuesta = RequestURL.substring(0, i);
                //System.out.println(respuesta);
                i = 0;                
            }
        }                
        return respuesta;
    }
    
    public static String ObtenerAyuda(){
         Properties prop = new Properties();
        String helpUrl = new String();        
        
        String resourceName = "config.properties";
            ClassLoader loader = Thread.currentThread().getContextClassLoader();
            try (InputStream resourceStream = loader.getResourceAsStream(resourceName)) {
                prop.load(resourceStream);
            } catch (Exception ex) {

                System.out.println("Error al leer archivo de configuracion. " + ex);
            }
            // obteniendo propiedades.
            helpUrl = prop.getProperty("helpUrl");
            return helpUrl;
    }

}

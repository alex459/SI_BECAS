
package MODEL;

import javax.servlet.http.HttpServletResponse;


public class Utilidades {
    
    /**
     * Metodo para redireccionar a una pagina con un mensaje.
     * Este metodo se usa dentro de un servlet. 
     * TIPO_MENSAJE 1-exito, 2-info, 3-warning, 4-error 
     * @param response
     * @param tipo_mensaje
     * @param titulo
     * @param mensaje 
     */
    public static void mostrarMensaje(HttpServletResponse response, int tipo_mensaje, String titulo, String mensaje){        
        //TIPO_MENSAJE 1-exito, 2-info, 3-warning, 4-error        
        try{
        response.sendRedirect("115_mensaje_general.jsp?TIPO_MENSAJE="+tipo_mensaje+"&TITULO="+titulo+"&MENSAJE="+mensaje);        
        }catch(Exception ex){
            
        }
                
    }
            
    
}


package DAO;

import MODEL.variablesDeSesion;
import POJO.Usuario;
import java.sql.ResultSet;


public class UsuarioDAO extends Conexion{
    
    //consultar por id
    public Usuario consultarUsuario(int id){
        Usuario usuario = new Usuario();        
        this.abrirConexion();
        try{
            stmt = conn.createStatement();        
            String sql = "SELECT ID_USUARIO, ID_TIPO_USUARIO, NOMBRE_USUARIO, CLAVE FROM usuario where ID_USUARIO = "+id;
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                
                int ID_USUARIO = rs.getInt("ID_USUARIO");
                int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                String NOMBRE_USUARIO = rs.getString("NOMBRE_USUARIO");
                String CLAVE = rs.getString("CLAVE");
                
                usuario.setIdUsuario(ID_USUARIO);
                usuario.setIdTipoUsuario(ID_TIPO_USUARIO);
                usuario.setNombreUsuario(NOMBRE_USUARIO);
                usuario.setClave(CLAVE);
            }                        
        }catch(Exception e){
            System.out.println("Error al consultar usuario con id: " +id);
        }
        
        return usuario;
    }
    
    
    
    public boolean login(String nombre, String clave){
        boolean logeo = false;
        Usuario usuario = new Usuario();        
        this.abrirConexion();
        try{
            stmt = conn.createStatement();        
            String sql = "SELECT ID_USUARIO, ID_TIPO_USUARIO, NOMBRE_USUARIO, CLAVE FROM usuario where NOMBRE_USUARIO = '"+nombre+"' AND CLAVE='"+clave+"'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                
                int ID_USUARIO = rs.getInt("ID_USUARIO");
                int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                String NOMBRE_USUARIO = rs.getString("NOMBRE_USUARIO");
                String CLAVE = rs.getString("CLAVE");
                
                usuario.setIdUsuario(ID_USUARIO);
                usuario.setIdTipoUsuario(ID_TIPO_USUARIO);
                usuario.setNombreUsuario(NOMBRE_USUARIO);
                usuario.setClave(CLAVE);
                logeo = true;
                
            }
                        
            if(logeo){
                variablesDeSesion.usuarioActual.setIdUsuario(usuario.getIdUsuario());
                variablesDeSesion.usuarioActual.setNombreUsuario(usuario.getNombreUsuario());
                variablesDeSesion.usuarioActual.setClave(usuario.getClave());
                variablesDeSesion.usuarioActual.setIdTipoUsuario(usuario.getIdTipoUsuario());
            }

        }catch(Exception e){
            System.out.println("Error : " +e);
        }        
        return logeo;
    }
    
}

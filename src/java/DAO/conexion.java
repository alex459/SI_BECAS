package DAO;

//import POJO.Usuario;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class conexion {

    private String enlace;
    private String controlador;
    private String error;
    private String usuario;
    private String contrasenia;
    public Connection conn = null;
    public Statement stmt = null;
    public ResultSet rs = null;

    public conexion() {
        this.enlace = "jdbc:mariadb://localhost:3306/bd_becas";
        this.controlador = "org.mariadb.jdbc.Driver";
        this.error = " ";
        this.usuario = "root";
        this.contrasenia = "";
    }

    public void abrirConexion() {
        try {
            Class.forName(controlador);
            conn = DriverManager.getConnection(enlace, usuario, contrasenia);
        } catch (Exception e) {
            System.out.println("error al abrir conexion: " + e);
        }        
    }
        
    public void cerrarConexion() {
        try {
            if(rs!=null)
                rs.close();
            if(stmt!=null)
                stmt.close();
            if(conn!=null)
                conn.close();
        } catch (Exception e) {
            System.out.println("error al cerrar conexion: " + e);
        }

    }  
    
    /*public Usuario consultarUsuario(int id){
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
                usuario.setTipoUsuario(ID_TIPO_USUARIO);
                usuario.setNombreUsuario(NOMBRE_USUARIO);
                usuario.setClave(CLAVE);
            }                        
        }catch(Exception e){
            System.out.println("Error al consultar usuario con id: " +id);
        }
        
        return usuario;
    }*/
    
    
}

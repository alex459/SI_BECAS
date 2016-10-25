package DAO;

//import POJO.Usuario;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Conexion {

    private String enlace;
    private String controlador;
    private String error;
    private String usuario;
    private String contrasenia;
    public Connection conn = null;
    public Statement stmt = null;
    public ResultSet rs = null;

    public Conexion() {
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
    
    
    
    
}
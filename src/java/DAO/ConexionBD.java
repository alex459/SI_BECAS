package DAO;

//import POJO.Usuario;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class ConexionBD {

    private String enlace;
    private String controlador;
    private String error;
    private String usuario;
    private String contrasenia;
    public Connection conn = null;
    public Statement stmt = null;
    public ResultSet rs = null;

    public ConexionBD() {
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
    
    //retorna un resulset de la consulta sql
    public ResultSet consultaSql(String consulta){
        ResultSet rs = null;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();                                    
            rs = stmt.executeQuery(consulta);
            this.cerrarConexion();            

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return rs;      
    }
    
    //retorna un resulset de la consulta sql
    public boolean ejecutarSql(String sentenciaSql){
        boolean respuesta = false;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();            
            stmt.execute(sentenciaSql);
            respuesta = true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }
        return respuesta;    
    }
    
    
}

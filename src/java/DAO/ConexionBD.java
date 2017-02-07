package DAO;

//import POJO.Usuario;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

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
        Properties prop = new Properties();
        String driver = new String();
        String ip_server = new String();
        String port_server = new String();
        String database_name = new String();
        String controller = new String();
        String database_user = new String();
        String database_password = new String();

        try {

            
            String resourceName = "config.properties";
            ClassLoader loader = Thread.currentThread().getContextClassLoader();
            try (InputStream resourceStream = loader.getResourceAsStream(resourceName)) {
                prop.load(resourceStream);
            } catch (Exception ex) {

                System.out.println("Error al leer archivo de configuracion. " + ex);
            }
            // obteniendo propiedades.
            driver = prop.getProperty("driver");
            ip_server = prop.getProperty("ip_server");
            port_server = prop.getProperty("port_server");
            database_name = prop.getProperty("database_name");
            controller = prop.getProperty("controller");
            database_user = prop.getProperty("database_user");
            database_password = prop.getProperty("database_password");

            //ejemplo this.enlace = "jdbc:mariadb://localhost:3306/bd_becas";
            this.enlace = driver.toString() + ip_server.toString() + port_server.toString() + database_name.toString();
            //ejemplo this.controlador = "org.mariadb.jdbc.Driver";
            this.controlador = controller.toString();
            this.error = " ";
            //ejemplo this.usuario = "root";
            this.usuario = database_user.toString();
            //ejemplo this.contrasenia = ""
            this.contrasenia = database_password.toString();

            //System.out.println("Enlace:"+enlace.toString()+" controlador:"+controller.toString()+" usuario:"+database_user.toString()+" clave:"+database_password.toString());
        } catch (Exception ex) {

            System.out.println("Error al leer archivo de configuracion. " + ex);
        }

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
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            System.out.println("error al cerrar conexion: " + e);
        }

    }

    //retorna un resulset de la consulta sql
    public ResultSet consultaSql(String consulta) {
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
    public boolean ejecutarSql(String sentenciaSql) {
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

package DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class conexion {

    private String enlace;
    private String controlador;
    private String error;
    private String usuario;
    private String contrasenia;

    public conexion() {
        this.enlace = "jdbc:mariadb://localhost:3306/bd_becas";
        this.controlador = "org.mariadb.jdbc.Driver";
        this.error = " ";
        this.usuario = "root";
        this.contrasenia = "";
    }

    public Connection abrirConexion() {
        try {
            Class.forName(controlador).newInstance();
            return DriverManager.getConnection(enlace, usuario, contrasenia);
        } catch (Exception e) {
            System.out.println("error al conectar " + e);
        }
        return null;
    }

    public void cerrarConexion(Connection salida) {
        try {
            salida.close();
        } catch (Exception e) {
            System.out.println("error al conectar " + e);
        }

    }
}

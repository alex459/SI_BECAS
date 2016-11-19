package DAO;

import POJO.Bitacora;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BitacoraDAO extends ConexionBD {

    public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_BITACORA), 0) AS X FROM BITACORA";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                siguienteId = rs.getInt("X") + 1;
            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return siguienteId;
    }

    public boolean ingresar(Bitacora temp) {
        boolean exito = false;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO BITACORA(ID_BITACORA, ID_ACCION, ID_USUARIO, FECHA_BITACORA, DESCRIPCION, SQL_SCRIPT) VALUES("+temp.getIdBitacora()+","+temp.getIdAccion()+","+temp.getIdUsuario()+",'"+temp.getFechaBitacora()+"','"+temp.getDescripcion()+"','"+temp.getSqlScript()+"')";            
            stmt.execute(sql);
            exito = true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }
        return exito;
    }
            

}

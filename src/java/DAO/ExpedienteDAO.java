/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Expediente;
import java.sql.ResultSet;

/**
 *
 * @author adminPC
 */
public class ExpedienteDAO extends ConexionBD {
        public Expediente consultarPorId(Integer id) {
        Expediente expediente = new Expediente();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_Expediente,ID_PROGRESO,ESTADO_EXPEDIENTE  FROM expediente where ID_EXPEDIENTE     = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                Integer ID_EXPEDIENTE = rs.getInt("ID_EXPEDIENTE");
                Integer ID_PROGRESO = rs.getInt("ID_PROGRESO");
                String EstadoExpediente = rs.getString("ESTADO_EXPEDIENTE");
                
                expediente.setIdExpediente(ID_EXPEDIENTE);
                expediente.setIdProgreso(ID_PROGRESO);
                expediente.setEstadoExpediente(EstadoExpediente);

            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return expediente;
    }
    
}

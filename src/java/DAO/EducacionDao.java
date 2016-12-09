/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.sql.ResultSet;

/**
 *
 * @author adminPC
 */
public class EducacionDao extends ConexionBD {

    public Integer ExisteEducacion(String tipoEducacion, String grado, String institucion, Integer anyo, Integer IdDetalleUsuario) {
        Integer idEducacion = 0;
        this.abrirConexion() ;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_EDUCACION FROM educacion where ID_DETALLE_USUARIO = " + IdDetalleUsuario +" AND TIPO_EDUCACION= '" + tipoEducacion +"' AND GRADO_ALCANZADO = '" + grado +"' AND NOMBRE_INSTITUCION= '" + institucion +"' AND ANIO = " + anyo ;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idEducacion = rs.getInt("ID_EDUCACION"); 
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return idEducacion;
    }
    
}

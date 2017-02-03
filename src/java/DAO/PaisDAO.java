/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Pais;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author jose
 */
public class PaisDAO extends ConexionBD{
    
    public ArrayList<Pais> consultarTodos() {
        ArrayList<Pais> lista = new ArrayList<Pais>();
        Pais temp = new Pais();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT * FROM PAIS";
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                temp = new Pais();

                int ID_PAIS = rs.getInt("ID_PAIS");
                String NOMBRE_PAIS = rs.getString("NOMBRE_PAIS");
                
                temp.setIdPais(ID_PAIS);
                temp.setNombrePais(NOMBRE_PAIS);                

                lista.add(temp);

            }

            this.cerrarConexion();

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
}

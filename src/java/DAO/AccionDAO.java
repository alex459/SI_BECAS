/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Accion;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author MauricioBC
 */
public class AccionDAO extends ConexionBD{

    public ArrayList<Accion> consultarTodos() {
        ArrayList<Accion> lista = new ArrayList<Accion>();
        Accion temp = new Accion();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT * FROM ACCION";
            ResultSet rs = stmt.executeQuery(sql);

            while (rs.next()) {
                temp = new Accion();

                int ID_ACCION = rs.getInt("ID_ACCION");
                String ACCION = rs.getString("ACCION");
                
                temp.setIdAccion(ID_ACCION);
                temp.setAccion(ACCION);                

                lista.add(temp);

            }

            this.cerrarConexion();

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }

}

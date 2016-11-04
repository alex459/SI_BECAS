/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Municipio;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author MauricioBC
 */
public class MunicipioDAO extends ConexionBD{
      public Municipio consultarPorId(int id) {
        Municipio temp = new Municipio();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_DEPARTAMENTO, NOMBRE_MUNICIPIO FROM MUNICIPIO WHERE ID_MUNICIPIO = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_MUNICIPIO=id;      
                int ID_DEPARTAMENTO=rs.getInt("ID_DEPARTAMENTO");                        
                String NOMBRE_MUNICIPIO=rs.getString("NOMBRE_MUNICIPIO");
                
                temp.setIdMunicipio(ID_MUNICIPIO);
                temp.setNombreMunicipio(NOMBRE_MUNICIPIO);
                temp.setIdDepartamento(ID_DEPARTAMENTO);
                
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<Municipio> consultarTodos() {
        ArrayList<Municipio> lista = new ArrayList<Municipio>();
        Municipio temp = new Municipio();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_MUNICIPIO, ID_DEPARTAMENTO, NOMBRE_MUNICIPIO FROM MUNICIPIO;" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new Municipio();
                
                int ID_MUNICIPIO=rs.getInt("ID_MUNICIPIO");      
                int ID_DEPARTAMENTO=rs.getInt("ID_DEPARTAMENTO");                        
                String NOMBRE_MUNICIPIO=rs.getString("NOMBRE_MUNICIPIO");
                
                temp.setIdMunicipio(ID_MUNICIPIO);
                temp.setNombreMunicipio(NOMBRE_MUNICIPIO);
                temp.setIdDepartamento(ID_DEPARTAMENTO);
                
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return lista;
    }
}


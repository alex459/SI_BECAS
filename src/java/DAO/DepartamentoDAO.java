/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;
import POJO.Departamento;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
/**
 *
 * @author MauricioBC
 */
public class DepartamentoDAO extends ConexionBD{
      public Departamento consultarPorId(int id) {
        Departamento temp = new Departamento();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_DEPARTAMENTO, NOMBRE_DEPARTAMENTO FROM DEPARTAMENTO WHERE ID_DEPARTAMENTO = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
    
                int ID_DEPARTAMENTO=rs.getInt("ID_DEPARTAMENTO");                        
                String NOMBRE_DEPARTAMENTO=rs.getString("NOMBRE_DEPARTAMENTO");
                
                temp.setIdDepartamento(ID_DEPARTAMENTO);
                temp.setNombreDepartamento(NOMBRE_DEPARTAMENTO);
                
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<Departamento> consultarTodos() {
        ArrayList<Departamento> lista = new ArrayList<Departamento>();
        Departamento temp = new Departamento();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_MUNICIPIO, ID_DEPARTAMENTO, NOMBRE_MUNICIPIO FROM MUNICIPIO;" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new Departamento();
                
                 int ID_DEPARTAMENTO=rs.getInt("ID_DEPARTAMENTO");                        
                String NOMBRE_DEPARTAMENTO=rs.getString("NOMBRE_DEPARTAMENTO");
                
                temp.setIdDepartamento(ID_DEPARTAMENTO);
                temp.setNombreDepartamento(NOMBRE_DEPARTAMENTO);
                
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return lista;
    }
}

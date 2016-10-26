
package DAO;

import POJO.Facultad;
import java.sql.ResultSet;
import java.util.ArrayList;


public class FacultadDAO extends ConexionBD{
    
    //consultar por id
    public Facultad consultarPorId(int id) {
        Facultad temp = new Facultad();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_FACULTAD, FACULTAD FROM FACULTAD where ID_FACULTAD = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_FACULTAD = rs.getInt("ID_FACULTAD");                
                String FACULTAD = rs.getString("FACULTAD");

                temp.setIdFacultad(ID_FACULTAD);
                temp.setFacultad(FACULTAD);
                
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<Facultad> consultarTodos() {
        ArrayList<Facultad> lista = new ArrayList<Facultad>();
        Facultad temp = new Facultad();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_FACULTAD, FACULTAD FROM FACULTAD" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new Facultad();
                int ID_FACULTAD = rs.getInt("ID_FACULTAD");                
                String FACULTAD = rs.getString("FACULTAD");

                temp.setIdFacultad(ID_FACULTAD);
                temp.setFacultad(FACULTAD);
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
    
}

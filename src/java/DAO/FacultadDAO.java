
package DAO;

import POJO.Facultad;
import java.sql.ResultSet;
import java.util.ArrayList;


public class FacultadDAO extends ConexionBD{
    
    //consultar por id
    public Facultad consultarPorId(int id) {
        Facultad facultad = new Facultad();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_FACULTAD, FACULTAD FROM FACULTAD where ID_FACULTAD = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_FACULTAD = rs.getInt("ID_FACULTAD");                
                String FACULTAD = rs.getString("FACULTAD");

                facultad.setIdFacultad(ID_FACULTAD);
                facultad.setFacultad(FACULTAD);
                
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return facultad;
    }
    
    //consultar todos
    public ArrayList<Facultad> consultarTodos() {
        ArrayList<Facultad> listaFacultades = new ArrayList<Facultad>();
        Facultad facultad = new Facultad();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_FACULTAD, FACULTAD FROM FACULTAD" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                facultad = new Facultad();
                int ID_FACULTAD = rs.getInt("ID_FACULTAD");                
                String FACULTAD = rs.getString("FACULTAD");

                facultad.setIdFacultad(ID_FACULTAD);
                facultad.setFacultad(FACULTAD);
                listaFacultades.add(facultad);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return listaFacultades;
    }
    
    
}

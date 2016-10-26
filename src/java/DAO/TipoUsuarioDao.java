/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.TipoUsuario;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author next
 */
public class TipoUsuarioDao extends ConexionBD{
    
    //consultar por id
    public TipoUsuario consultarPorId(int id){
        TipoUsuario temp = new TipoUsuario();        
        this.abrirConexion();
        try{
            stmt = conn.createStatement();        
            String sql = "SELECT * FROM TIPO_USUARIO where ID_TIPO_USUARIO = "+id;
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                
                int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                String TIPO_USUARIO = rs.getString("TIPO_USUARIO");
                String DESCRIPCION_TIPO_USUARIO = rs.getString("DESCRIPCION_TIPO_USUARIO");
                
                
                temp.setIdTipoUsuario(ID_TIPO_USUARIO);
                temp.setTipoUsuario(TIPO_USUARIO);
                temp.setDescripcionTipoUsuario(DESCRIPCION_TIPO_USUARIO);
                
            }                        
        }catch(Exception e){
            System.out.println("Error al consultar usuario con id: " +id);
        }
        
        return temp;
    }
    
    //consultar todos
    public ArrayList<TipoUsuario> consultarTodos() {
        ArrayList<TipoUsuario> lista = new ArrayList<TipoUsuario>();
        TipoUsuario temp = new TipoUsuario();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT * FROM TIPO_USUARIO" ;
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                temp = new TipoUsuario();
                
                int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                String TIPO_USUARIO = rs.getString("TIPO_USUARIO");
                String DESCRIPCION_TIPO_USUARIO = rs.getString("DESCRIPCION_TIPO_USUARIO");
                                
                temp.setIdTipoUsuario(ID_TIPO_USUARIO);
                temp.setTipoUsuario(TIPO_USUARIO);
                temp.setDescripcionTipoUsuario(DESCRIPCION_TIPO_USUARIO);
                
                lista.add(temp);
                
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
}

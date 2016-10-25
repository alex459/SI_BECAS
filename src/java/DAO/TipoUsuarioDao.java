/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.TipoUsuario;
import java.sql.ResultSet;

/**
 *
 * @author next
 */
public class TipoUsuarioDao extends Conexion{
    
    //consultar por id
    public TipoUsuario consultarUsuario(int id){
        TipoUsuario tipoUsuario = new TipoUsuario();        
        this.abrirConexion();
        try{
            stmt = conn.createStatement();        
            String sql = "SELECT ID_USUARIO, ID_TIPO_USUARIO, NOMBRE_USUARIO, CLAVE FROM usuario where ID_USUARIO = "+id;
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                
                int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                String TIPO_USUARIO = rs.getString("TIPO_USUARIO");
                String DESCRIPCION_TIPO_USUARIO = rs.getString("DESCRIPCION_TIPO_USUARIO");
                
                
                tipoUsuario.setIdTipoUsuario(ID_TIPO_USUARIO);
                tipoUsuario.setTipoUsuario(TIPO_USUARIO);
                
            }                        
        }catch(Exception e){
            System.out.println("Error al consultar usuario con id: " +id);
        }
        
        return tipoUsuario;
    }
    
}

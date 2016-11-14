/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

/**
 *
 * @author MauricioBC
 */

import POJO.Idioma;
import java.sql.ResultSet;
import java.util.ArrayList;
public class IdiomaDAO extends ConexionBD{
    public Idioma consultarPorId(int id) {
        Idioma temp = new Idioma();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_DETALLE_USUARIO, IDIOMA, NIVEL_HABLA, NIVEL_LECTURA, NIVEL_ESCRITO FROM IDIOMA WHERE ID_IDIOMA = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                int ID_IDIOMA=id;      
                int ID_DETALLE_USUARIO=rs.getInt("ID_DETALLE_USUARIO");                        
                String IDIOMA=rs.getString("IDIOMA");
                String NIVEL_HABLA=rs.getString("NIVEL_HABLA");
                String NIVEL_LECTURA=rs.getString("NIVEL_LECTURA");
                String NIVEL_ESCRITO=rs.getString("NIVEL_ESCRITO");                
                temp.setIdIdioma(ID_IDIOMA);
                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setIdioma(IDIOMA);
                temp.setNivelHabla(NIVEL_HABLA);
                temp.setNivelEscrito(NIVEL_ESCRITO);
                temp.setNivelLectura(NIVEL_LECTURA);                
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return temp;
    }
    
    //consultar todos
    public ArrayList<Idioma> consultarTodos() {
        ArrayList<Idioma> lista = new ArrayList<Idioma>();
        Idioma temp = new Idioma();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_IDIOMA, ID_DETALLE_USUARIO, IDIOMA, NIVEL_HABLA, NIVEL_LECTURA, NIVEL_ESCRITO FROM IDIOMA;" ;
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                temp = new Idioma();
                int ID_IDIOMA=rs.getInt("ID_IDIOMA");  ;      
                int ID_DETALLE_USUARIO=rs.getInt("ID_DETALLE_USUARIO");                        
                String IDIOMA=rs.getString("IDIOMA");
                String NIVEL_HABLA=rs.getString("NIVEL_HABLA");
                String NIVEL_LECTURA=rs.getString("NIVEL_LECTURA");
                String NIVEL_ESCRITO=rs.getString("NIVEL_ESCRITO");                
                temp.setIdIdioma(ID_IDIOMA);
                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setIdioma(IDIOMA);
                temp.setNivelHabla(NIVEL_HABLA);
                temp.setNivelEscrito(NIVEL_ESCRITO);
                temp.setNivelLectura(NIVEL_LECTURA);                
                lista.add(temp);
            }            
            this.cerrarConexion();            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return lista;
    }
    
    public boolean ingresar(Idioma idioma){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO IDIOMA(ID_IDIOMA,ID_DETALLE_USUARIO,IDIOMA,NIVEL_HABLA,NIVEL_LECTURA,NIVEL_ESCRITO) VALUES("+idioma.getIdIdioma()+", "+idioma.getIdDetalleUsuario()+", '"+idioma.getIdioma()+"','"+idioma.getNivelHabla()+"','"+idioma.getNivelLectura()+"','"+idioma.getNivelEscrito()+"');";
            stmt.execute(sql);
            exito = true;
            this.cerrarConexion();
        }catch (Exception e) {
            System.out.println("Error " + e);
        }finally{
            this.cerrarConexion();
        }
        return exito;
    }
    
    public boolean actualizar(Idioma idioma){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE IDIOMA SET ID_DETALLE_USUARIO="+idioma.getIdDetalleUsuario()+", IDIOMA='"+idioma.getIdioma()+"',NIVEL_HABLA='"+idioma.getNivelHabla()+"', NIVEL_LECTURA='"+idioma.getNivelLectura()+"', NIVEL_ESCRITO='"+idioma.getNivelEscrito()+"' WHERE ID_IDIOMA="+idioma.getIdIdioma()+";";
            stmt.execute(sql);
            exito = true;
            this.cerrarConexion();
        }catch (Exception e) {
            System.out.println("Error " + e);
        }finally{
            this.cerrarConexion();
        }
        return exito;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Progreso;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author MauricioBC
 */
public class ProgresoDAO extends ConexionBD{
    public Progreso consultarPorId(int id) {
        Progreso temp = new Progreso();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT NOMBRE_PROGRESO, DESCRIPCION_PROGRESO, ESTADO_BECARIO, ESTADO_PROGRESO FROM PROGRESO where ID_PROGRESO = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                String NOMBRE_PROGRESO=rs.getString("NOMBRE_PROGRESO");
                String DESCRIPCION_PROGRESO=rs.getString("DESCRIPCION_PROGRESO");
                String ESTADO_BECARIO=rs.getString("ESTADO_BECARIO");
                String ESTADO_PROGRESO=rs.getString("ESTADO_PROGRESO");

                temp.setNombreProgreso(NOMBRE_PROGRESO);
                temp.setDescripcionProgreso(DESCRIPCION_PROGRESO);
                temp.setEstadoBecario(ESTADO_BECARIO);
                temp.setEstadoProgreso(ESTADO_PROGRESO);
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<Progreso> consultarTodos() {
        ArrayList<Progreso> lista = new ArrayList<Progreso>();
        Progreso temp = new Progreso();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_PROGRESO, NOMBRE_PROGRESO, DESCRIPCION_PROGRESO, ESTADO_BECARIO FROM PROGRESO" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new Progreso();
                int ID_PROGRESO=rs.getInt("ID_PROGRESO");
                String NOMBRE_PROGRESO=rs.getString("NOMBRE_PROGRESO");
                String DESCRIPCION_PROGRESO=rs.getString("DESCRIPCION_PROGRESO");
                String ESTADO_BECARIO=rs.getString("ESTADO_BECARIO");
                temp.setIdProgreso(ID_PROGRESO);
                temp.setNombreProgreso(NOMBRE_PROGRESO);
                temp.setDescripcionProgreso(DESCRIPCION_PROGRESO);
                temp.setEstadoBecario(ESTADO_BECARIO);
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
    public boolean ingresar(Progreso progreso){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO PROGRESO(ID_PROGRESO,NOMBRE_PROGRESO,DESCRIPCION_PROGRESO,ESTADO_BECARIO,ESTADO_PROGRESO) VALUES("+progreso.getIdProgreso()+", '"+progreso.getNombreProgreso()+"', '"+progreso.getDescripcionProgreso()+"', '"+progreso.getEstadoBecario()+"','"+progreso.getEstadoProgreso()+"');";
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
    
    public boolean actualizar(Progreso progreso){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE PROGRESO SET NOMBRE_PROGRESO='"+progreso.getNombreProgreso()+"', DESCRIPCION_PROGRESO='"+progreso.getDescripcionProgreso()+"', ESTADO_BECARIO='"+progreso.getEstadoProgreso()+"',ESTADO_PROGRESO='"+progreso.getEstadoProgreso()+"' WHERE ID_BECA="+progreso.getIdProgreso()+";";
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
    
    public Integer consultarId(String progresoName) {
        Progreso temp = new Progreso();
        Integer idProgreso = 0;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_PROGRESO FROM PROGRESO where NOMBRE_PROGRESO = '" +progresoName+"'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idProgreso = rs.getInt("ID_PROGRESO");
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return idProgreso;
    }
}

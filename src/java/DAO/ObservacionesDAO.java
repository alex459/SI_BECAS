/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Observaciones;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author MauricioBC
 */
public class ObservacionesDAO extends ConexionBD{
    public Observaciones consultarPorId(int id) {
        Observaciones temp = new Observaciones();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_OBSERVACION, ID_EXPEDIENTE, OBSERVACION FROM OBSERVACIONES where ID_OBSERVACION = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                int ID_OBSERVACION = rs.getInt("ID_OBSERVACION");        
                int ID_EXPEDIENTE = rs.getInt("ID_EXPEDIENTE");  
                String OBSERVACION = rs.getString("OBSERVACION");

                temp.setIdObservacion(ID_OBSERVACION);
                temp.setIdExpediente(ID_EXPEDIENTE);
                temp.setObservacion(OBSERVACION);
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<Observaciones> consultarTodos() {
        ArrayList<Observaciones> lista = new ArrayList<Observaciones>();
        Observaciones temp = new Observaciones();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_OBSERVACION, ID_EXPEDIENTE, OBSERVACION FROM OBSERVACIONES" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new Observaciones();
                int ID_OBSERVACION = rs.getInt("ID_OBSERVACION");        
                int ID_EXPEDIENTE = rs.getInt("ID_EXPEDIENTE");  
                String OBSERVACION = rs.getString("OBSERVACION");
                temp.setIdObservacion(ID_OBSERVACION);
                temp.setIdExpediente(ID_EXPEDIENTE);
                temp.setObservacion(OBSERVACION);
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
    public boolean ingresar(Observaciones observaciones){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO OBSERVACIONES(ID_OBSERVACION, ID_EXPEDIENTE, OBSERVACION_O) VALUES("+observaciones.getIdObservacion()+", "+observaciones.getIdExpediente()+", '"+observaciones.getObservacion()+"')";
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
    
    public boolean actualizar(Observaciones observaciones){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE OBSERVACIONES SET ID_EXPEDIENTE="+observaciones.getIdExpediente()+", OBSERVACION='"+observaciones.getObservacion()+"' WHERE ID_OBSERVACION="+observaciones.getIdObservacion()+";";
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
    
    //Consultar todas las observaciones de un expediente
    public ArrayList<Observaciones> consultarPorExpediente(int id) {
        ArrayList<Observaciones> lista = new ArrayList<Observaciones>();
        Observaciones temp = new Observaciones();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_OBSERVACION, ID_EXPEDIENTE, OBSERVACION_O FROM OBSERVACIONES WHERE ID_EXPEDIENTE = "+ id ;
            ResultSet rs = stmt.executeQuery(sql); 
            

            while (rs.next()) {
                temp = new Observaciones();
                int ID_OBSERVACION = rs.getInt("ID_OBSERVACION");        
                int ID_EXPEDIENTE = rs.getInt("ID_EXPEDIENTE");  
                String OBSERVACION = rs.getString("OBSERVACION_O");
                temp.setIdObservacion(ID_OBSERVACION);
                temp.setIdExpediente(ID_EXPEDIENTE);
                temp.setObservacion(OBSERVACION);
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
    //Permite obtener el siguiente id de la Observacion
     public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_OBSERVACION), 0) AS X FROM OBSERVACIONES";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                siguienteId = rs.getInt("X") + 1;                
            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return siguienteId;
    }
     
     //Elimina una observacion por su id
    public Boolean eliminarObservacion(Integer id) {
        this.abrirConexion();
        Boolean exito =false;
        try {
            stmt = conn.createStatement();
            String sql = "DELETE FROM OBSERVACIONES WHERE ID_OBSERVACION =" +id;
            ResultSet rs = stmt.executeQuery(sql);
            exito=true;
            this.cerrarConexion();
            
            
            
            
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return exito;
    }
}

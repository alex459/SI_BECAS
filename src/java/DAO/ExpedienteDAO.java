/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Expediente;
import java.sql.ResultSet;

/**
 *
 * @author adminPC
 */
public class ExpedienteDAO extends ConexionBD {
    
    //Obtener un expediente por Id
        public Expediente consultarPorId(Integer id) {
        Expediente expediente = new Expediente();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_Expediente,ID_PROGRESO,ESTADO_EXPEDIENTE,ESTADO_PROGRESO FROM expediente where ID_EXPEDIENTE     = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                Integer ID_EXPEDIENTE = rs.getInt("ID_EXPEDIENTE");
                Integer ID_PROGRESO = rs.getInt("ID_PROGRESO");
                String EstadoExpediente = rs.getString("ESTADO_EXPEDIENTE");
                String EstadoProgreso = rs.getString("ESTADO_PROGRESO");
                
                expediente.setIdExpediente(ID_EXPEDIENTE);
                expediente.setIdProgreso(ID_PROGRESO);
                expediente.setEstadoExpediente(EstadoExpediente);
                expediente.setEstadoProgreso(EstadoProgreso);

            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return expediente;
    }
        
        //Permite consultar si un usuario posee expediente abierto
        public boolean expedienteAbierto(String user){
            boolean expediente = false;
            this.abrirConexion();
            try {
                stmt = conn.createStatement();
                String sql = "SELECT ex.ID_EXPEDIENTE from expediente ex join solicitud_de_beca sb on ex.ID_EXPEDIENTE = sb.ID_EXPEDIENTE join usuario u on u.ID_USUARIO = sb.ID_USUARIO where ex.ESTADO_EXPEDIENTE = \"ABIERTO\" and u.NOMBRE_USUARIO =\"" +user +"\"";
                ResultSet rs = stmt.executeQuery(sql);
                this.cerrarConexion();
                expediente = rs.next();
            }catch (Exception e) {
            System.out.println("Error " + e);
        }
            
            return expediente;
        }
        
        //Permite obtener el nuevo Id del expediente
        public Integer getSiguienteId() {
        Integer siguiente = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_EXPEDIENTE), 0) AS X FROM EXPEDIENTE";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            
            while (rs.next()) {
                siguiente = rs.getInt("X") + 1;
            }
            
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return siguiente;
    }
        
    
        //Permite crear un nuevo expediente
        public boolean ingresar(Expediente expediente){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO expediente(ID_EXPEDIENTE,ID_PROGRESO,ESTADO_EXPEDIENTE, ESTADO_PROGRESO) VALUES(" + expediente.getIdExpediente()+ "," +expediente.getIdProgreso()+ ", '"+ expediente.getEstadoExpediente()+ "','"+ expediente.getEstadoProgreso() +"');";
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
        
        //Elimina un expediente PERMANENTEMENTE de la BD
        public Boolean eliminarPermanentemente(Integer id) {
        this.abrirConexion();
        Boolean exito =false;
        try {
            stmt = conn.createStatement();
            String sql = "DELETE FROM EXPEDIENTE WHERE ID_EXPEDIENTE =" +id;
            ResultSet rs = stmt.executeQuery(sql);
            exito=true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return exito;
    }
        
    //Permite obtener el expediente abierto de un usuario
        public Expediente obtenerExpedienteAbierto(String user){
            Expediente expediente = new Expediente();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ex.ID_EXPEDIENTE, ex.ID_PROGRESO,ex.ESTADO_EXPEDIENTE, ex.ESTADO_PROGRESO from expediente ex join solicitud_de_beca sb on ex.ID_EXPEDIENTE = sb.ID_EXPEDIENTE join usuario u on u.ID_USUARIO = sb.ID_USUARIO where ex.ESTADO_EXPEDIENTE = \"ABIERTO\" and u.NOMBRE_USUARIO =\"" +user +"\"";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                Integer ID_EXPEDIENTE = rs.getInt("ID_EXPEDIENTE");
                Integer ID_PROGRESO = rs.getInt("ID_PROGRESO");
                String EstadoExpediente = rs.getString("ESTADO_EXPEDIENTE");
                String EstadoProgreso = rs.getString("ESTADO_PROGRESO");
                
                expediente.setIdExpediente(ID_EXPEDIENTE);
                expediente.setIdProgreso(ID_PROGRESO);
                expediente.setEstadoExpediente(EstadoExpediente);
                expediente.setEstadoProgreso(EstadoProgreso);
            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return expediente;
        }
        
        public boolean actualizarExpediente(Expediente expediente){
        boolean exito = false;
        
        this.abrirConexion(); 
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE EXPEDIENTE SET ID_PROGRESO = "+ expediente.getIdProgreso()+ ", ESTADO_PROGRESO = '"+expediente.getEstadoProgreso()+"',ESTADO_EXPEDIENTE ='"+ expediente.getEstadoExpediente()+"' WHERE ID_EXPEDIENTE =" +expediente.getIdExpediente();
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
        
    public boolean actualizarIdProgreso(Expediente expediente){
        boolean exito = false;

        this.abrirConexion(); 
        try {
            stmt = conn.createStatement();

            String sql = "UPDATE EXPEDIENTE SET ID_PROGRESO = "+ expediente.getIdProgreso()+" WHERE ID_EXPEDIENTE =" +expediente.getIdExpediente();
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

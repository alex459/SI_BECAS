/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Prorroga;
import java.sql.ResultSet;

/**
 *
 * @author adminPC
 */
public class ProrrogaDAO extends ConexionBD{
    
    //Permite obtener el nuevo Id de la prorroga
        public Integer getSiguienteId() {
        Integer siguiente = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_PRORROGA), 0) AS X FROM PRORROGA";
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
        
    public Integer ExisteProrroga(Integer idBeca, Integer idDocumento) {
        Integer idProrroga = 0;
        this.abrirConexion() ;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(P.ID_PRORROGA), 0) AS ID_PRORROGA FROM `prorroga` P WHERE `ID_BECA` = "+idBeca+" AND ID_DOCUMENTO ="+idDocumento;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idProrroga = rs.getInt("ID_PRORROGA"); 
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return idProrroga;
    }
    
    public boolean ingresar(Prorroga prorroga){
        boolean exito = false;        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO prorroga(ID_PRORROGA, ID_BECA, ID_DOCUMENTO, FECHA_INICIO_PRORROGA, FECHA_FIN_PRORROGA, ESTADO_PRORROGA) VALUES ( " +prorroga.getIdProrroga()+ ", "+prorroga.getIdBeca()+", "+prorroga.getIdDocumento()+", '"+prorroga.getFechaInicio()+"', '"+prorroga.getFechaFin()+"', '"+prorroga.getEstado()+"')";
            System.out.println(sql);
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
    
    public Prorroga consultarPorId(int id) {
        Prorroga temp = new Prorroga();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT `ID_PRORROGA`, `ID_BECA`, `ID_DOCUMENTO`, `FECHA_INICIO_PRORROGA`, `FECHA_FIN_PRORROGA`, `ESTADO_PRORROGA` FROM `prorroga` WHERE ID_PRORROGA = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                int ID_PRORROGA=id;
                temp.setIdProrroga(ID_PRORROGA);
                temp.setIdBeca(rs.getInt("ID_BECA"));
                temp.setIdBeca(rs.getInt("ID_DOCUMENTO"));
                temp.setFechaInicio(rs.getDate("FECHA_INICIO_PRORROGA"));
                temp.setFechaFin(rs.getDate("FECHA_FIN_PRORROGA"));
                temp.setEstado("ESTADO_PRORROGA");
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return temp;
    }
    
    public boolean actualizarProrroga(Prorroga prorroga){
        boolean exito = false;        
        this.abrirConexion();
        try {
            stmt = conn.createStatement(); 
            String sql = "UPDATE prorroga SET FECHA_INICIO_PRORROGA= "+prorroga.getFechaInicio()+" ,FECHA_FIN_PRORROGA= "+prorroga.getFechaFin()+",ESTADO_PRORROGA= "+prorroga.getFechaFin()+" WHERE ID_PRORROGA=" +prorroga.getIdProrroga();
                 
            System.out.println(sql);
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
    
    public Integer ExisteProrrogaAnterior(Integer idBeca) {
        Integer idProrroga = 0;
        this.abrirConexion() ;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(P.ID_PRORROGA), 0) AS ID_PRORROGA FROM `prorroga` P WHERE `ID_BECA` = "+idBeca+" AND ESTADO_PRORROGA = 'APROBADO'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idProrroga = rs.getInt("ID_PRORROGA"); 
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return idProrroga;
    }
    
    public Integer obtenerProrrogaAprobada(Integer idBeca) {
        Integer idProrroga = 0;
        this.abrirConexion() ;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(P.ID_PRORROGA), 0) AS ID_PRORROGA FROM `prorroga` P WHERE `ID_BECA` = "+idBeca+" AND ESTADO_PRORROGA = 'APROBADO'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idProrroga = rs.getInt("ID_PRORROGA"); 
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return idProrroga;
    }
}

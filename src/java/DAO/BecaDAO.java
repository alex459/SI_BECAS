/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Beca;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author MauricioBC
 */
public class BecaDAO extends ConexionBD{
    public Beca consultarPorId(int id) {
        Beca temp = new Beca();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_BECA, ID_EXPEDIENTE, FECHA_INICIO, FECHA_FIN FROM BECA where ID_BECA = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_BECA = rs.getInt("ID_BECA");        
                int ID_EXPEDIENTE = rs.getInt("ID_EXPEDIENTE");  
                Date FECHA_INICIO = rs.getDate("FECHA_INICIO");
                Date FECHA_FIN = rs.getDate("FECHA_FIN");

                temp.setIdBeca(ID_BECA);
                temp.setIdExpediente(ID_EXPEDIENTE);
                temp.setFechaInicio(FECHA_INICIO);
                temp.setFechaFin(FECHA_FIN);
                
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<Beca> consultarTodos() {
        ArrayList<Beca> lista = new ArrayList<Beca>();
        Beca temp = new Beca();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_BECA, ID_EXPEDIENTE, FECHA_INICIO, FECHA_FIN FROM BECA" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new Beca();
                int ID_BECA = rs.getInt("ID_BECA");        
                int ID_EXPEDIENTE = rs.getInt("ID_EXPEDIENTE");
                Date FECHA_FIN = rs.getDate("FECHA_FIN");
                Date FECHA_INICIO = rs.getDate("FECHA_INICIO");

                temp.setIdBeca(ID_BECA);
                temp.setIdExpediente(ID_EXPEDIENTE);
                temp.setFechaInicio(FECHA_INICIO);
                temp.setFechaFin(FECHA_FIN);
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
    public boolean ingresar(Beca beca){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO BECA(ID_BECA, ID_EXPEDIENTE, FECHA_INICIO, FECHA_FIN) VALUES("+beca.getIdBeca()+", "+beca.getIdExpediente()+", '"+beca.getFechaInicio()+"', '"+beca.getFechaFin()+"')";
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
    
    public boolean actualizar(Beca beca){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE BECA SET ID_EXPEDIENTE="+beca.getIdExpediente()+", FECHA_INICIO='"+beca.getFechaInicio()+"', FECHA_FIN='"+beca.getFechaFin()+"' WHERE ID_BECA="+beca.getIdBeca()+";";
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

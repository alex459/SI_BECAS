/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.SolicitudDeBeca;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author MauricioBC
 */
public class SolocitudBecaDAO extends ConexionBD{
    
    //Permite obtener el Id de la nueva solicitud
    public Integer getSiguienteId() {
        Integer siguiente = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_SOLICITUD), 0) AS X FROM SOLICITUD_DE_BECA";
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
    
    
    //
     public SolicitudDeBeca consultarPorId(int id) {
        SolicitudDeBeca temp = new SolicitudDeBeca();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_USUARIO, ID_EXPEDIENTE, ID_OFERTA_BECA, FECHA_SOLICITUD, BENEFICIOS FROM SOLICITUD_DE_BECA where ID_SOLICITUD = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_SOLICITUD=rs.getInt("ID_SOLICITUD");
                int ID_USUARIO=rs.getInt("ID_USUARIO");
                int ID_EXPEDIENTE=rs.getInt("ID_SOLICITUD");
                int ID_OFERTA_BECA=rs.getInt("ID_OFERTA_BECA");
                Date FECHA_SOLICITUD =rs.getDate("FECHA_SOLICITUD");
                String BENEFICIOS=rs.getString("BENEFICIOS");
                
                temp.setIdSolicitud(ID_SOLICITUD);
                temp.setIdUsuario(ID_USUARIO);
                temp.setIdExpediente(ID_EXPEDIENTE);
                temp.setIdOfertaBeca(ID_OFERTA_BECA);
                temp.setFechaSolicitud(FECHA_SOLICITUD);
                temp.setBeneficios(BENEFICIOS);
                
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<SolicitudDeBeca> consultarTodos() {
        ArrayList<SolicitudDeBeca> lista = new ArrayList<SolicitudDeBeca>();
        SolicitudDeBeca temp = new SolicitudDeBeca();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_SOLICITUD, ID_USUARIO, ID_EXPEDIENTE, ID_OFERTA_BECA, FECHA_SOLICITUD, BENEFICIOS FROM SOLICITUD_DE_BECA;" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new SolicitudDeBeca();
                
                
                int ID_SOLICITUD=rs.getInt("ID_SOLICITUD");
                int ID_USUARIO=rs.getInt("ID_USUARIO");
                int ID_EXPEDIENTE=rs.getInt("ID_SOLICITUD");
                int ID_OFERTA_BECA=rs.getInt("ID_OFERTA_BECA");
                Date FECHA_SOLICITUD =rs.getDate("FECHA_SOLICITUD");
                String BENEFICIOS=rs.getString("BENEFICIOS");
                
                temp.setIdSolicitud(ID_SOLICITUD);
                temp.setIdUsuario(ID_USUARIO);
                temp.setIdExpediente(ID_EXPEDIENTE);
                temp.setIdOfertaBeca(ID_OFERTA_BECA);
                temp.setFechaSolicitud(FECHA_SOLICITUD);
                temp.setBeneficios(BENEFICIOS);
                
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
    public boolean ingresar(SolicitudDeBeca solicitudDeBeca){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO SOLICITUD_DE_BECA(ID_SOLICITUD,ID_USUARIO,ID_EXPEDIENTE,ID_OFERTA_BECA,FECHA_SOLICITUD,BENEFICIOS) VALUES("+solicitudDeBeca.getIdSolicitud()+", "+solicitudDeBeca.getIdUsuario()+", "+solicitudDeBeca.getIdExpediente()+", "+solicitudDeBeca.getIdOfertaBeca()+",'"+solicitudDeBeca.getFechaSolicitud()+"','"+solicitudDeBeca.getBeneficios()+"');";
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
    
    public boolean actualizar(SolicitudDeBeca solicitudDeBeca){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE SOLICITUD_DE_BECA SET ID_USUARIO="+solicitudDeBeca.getIdUsuario()+", ID_EXPEDIENTE="+solicitudDeBeca.getIdExpediente()+", ID_OFERTA_BECA="+solicitudDeBeca.getIdOfertaBeca()+",FECHA_SOLICITUD='"+solicitudDeBeca.getFechaSolicitud()+"', BENEFICIOS='"+solicitudDeBeca.getBeneficios()+"' WHERE ID_SOLICITUD="+solicitudDeBeca.getIdSolicitud()+";";
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
    
    //Elimina una solicitud de beca con el id de expediente enviado PERMANENTEMENTE de la BD
        public Boolean eliminarDocumentosExpediente(Integer id) {
        this.abrirConexion();
        Boolean exito =false;
        try {
            stmt = conn.createStatement();
            String sql = "DELETE FROM SOLICITUD_DE_BECA WHERE ID_EXPEDIENTE =" +id;
            ResultSet rs = stmt.executeQuery(sql);
            exito=true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return exito;
    }
        
    //obtener solicitud por expediente y idusuario
     public SolicitudDeBeca consultarPorExpedienteUsuario(Integer idExpediente, Integer idUsuario) {
        SolicitudDeBeca temp = new SolicitudDeBeca();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_SOLICITUD, ID_USUARIO, ID_EXPEDIENTE, ID_OFERTA_BECA, FECHA_SOLICITUD, BENEFICIOS FROM SOLICITUD_DE_BECA where ID_USUARIO = " + idUsuario +" AND ID_EXPEDIENTE =" +idExpediente;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_SOLICITUD=rs.getInt("ID_SOLICITUD");
                int ID_USUARIO=rs.getInt("ID_USUARIO");
                int ID_EXPEDIENTE=rs.getInt("ID_SOLICITUD");
                int ID_OFERTA_BECA=rs.getInt("ID_OFERTA_BECA");
                Date FECHA_SOLICITUD =rs.getDate("FECHA_SOLICITUD");
                String BENEFICIOS=rs.getString("BENEFICIOS");
                
                temp.setIdSolicitud(ID_SOLICITUD);
                temp.setIdUsuario(ID_USUARIO);
                temp.setIdExpediente(ID_EXPEDIENTE);
                temp.setIdOfertaBeca(ID_OFERTA_BECA);
                temp.setFechaSolicitud(FECHA_SOLICITUD);
                temp.setBeneficios(BENEFICIOS);
                
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
}

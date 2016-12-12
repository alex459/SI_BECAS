/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Referencias;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author MauricioBC
 */
public class ReferenciasDAO extends ConexionBD{
     public Referencias consultarPorId(int id) {
        Referencias temp = new Referencias();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_SOLICITUD, ID_MUNICIPIO, NOMBRE1, NOMBRE2, APELLIDO1, APELLIDO2, DOMICILIO, TELEFONO_MOVIl FROM REFERENCIAS WHERE ID_REFERENCIA = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_REFERENCIA=id;      
                int ID_SOLICITUD=rs.getInt("ID_SOLICITUD");
                int ID_MUNICIPIO=rs.getInt("ID_MUNICIPIO");                          
                String NOMBRE1=rs.getString("NOMBRE1");
                String NOMBRE2=rs.getString("NOMBRE2");
                String APELLIDO1=rs.getString("APELLIDO1");
                String APELLIDO2=rs.getString("APELLIDO2");
                String DOMICILIO=rs.getString("DOMICILIO");
                String TELEFONO_MOVIl=rs.getString("TELEFONO_MOVIl");
                
                temp.setIdReferencia(ID_REFERENCIA);
                temp.setIdSolicitud(ID_SOLICITUD);
                temp.setIdMunicipio(ID_MUNICIPIO);
                temp.setNombre1Du(NOMBRE1);
                temp.setNombre2Du(NOMBRE2);
                temp.setApellido1Du(APELLIDO1);
                temp.setApellido2Du(APELLIDO2);
                temp.setDomicilio(DOMICILIO);
                temp.setTelefonoMovil(TELEFONO_MOVIl);
                
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<Referencias> consultarTodos() {
        ArrayList<Referencias> lista = new ArrayList<Referencias>();
        Referencias temp = new Referencias();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_REFERENCIAS, ID_SOLICITUD, ID_MUNICIPIO, NOMBRE1,NOMBRE2,APELLIDO1,APELLIDO2,DOMICILIO,TELEFONO_MOVIL FROM REFERENCIAS;" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new Referencias();
                
                
                int ID_REFERENCIA=rs.getInt("ID_REFERENCIA");      
                int ID_SOLICITUD=rs.getInt("ID_SOLICITUD");
                int ID_MUNICIPIO=rs.getInt("ID_MUNICIPIO");                          
                String NOMBRE1=rs.getString("NOMBRE1");
                String NOMBRE2=rs.getString("NOMBRE2");
                String APELLIDO1=rs.getString("APELLIDO1");
                String APELLIDO2=rs.getString("APELLIDO2");
                String DOMICILIO=rs.getString("DOMICILIO");
                String TELEFONO_MOVIl=rs.getString("TELEFONO_MOVIl");
                
                temp.setIdReferencia(ID_REFERENCIA);
                temp.setIdSolicitud(ID_SOLICITUD);
                temp.setIdMunicipio(ID_MUNICIPIO);
                temp.setNombre1Du(NOMBRE1);
                temp.setNombre2Du(NOMBRE2);
                temp.setApellido1Du(APELLIDO1);
                temp.setApellido2Du(APELLIDO2);
                temp.setDomicilio(DOMICILIO);
                temp.setTelefonoMovil(TELEFONO_MOVIl);
                
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
    public boolean ingresar(Referencias referencias){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO referencias(ID_REFERENCIA, ID_SOLICITUD, ID_MUNICIPIO, NOMBRE1_DU, NOMBRE2_DU, APELLIDO1_DU, APELLIDO2_DU, DOMICILIO, TELEFONO_MOVIL) VALUES ("+referencias.getIdReferencia()+", "+referencias.getIdSolicitud()+", "+referencias.getIdMunicipio()+", '"+referencias.getNombre1Du()+"','"+referencias.getNombre2Du()+"','"+referencias.getApellido1Du()+"','"+referencias.getApellido2Du()+"','"+referencias.getDomicilio()+"','"+referencias.getTelefonoMovil()+"');";
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
    
    public boolean actualizar(Referencias referencias){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE REFERENCIAS SET ID_SOLICITUD="+referencias.getIdSolicitud()+", ID_MUNICIPIO="+referencias.getIdMunicipio()+", NOMBRE1='"+referencias.getNombre1Du()+"',NOMBRE2='"+referencias.getNombre2Du()+"', APELLIDO1='"+referencias.getApellido1Du()+"', APELLIDO2='"+referencias.getApellido2Du()+"',DOMICILIO='"+referencias.getDomicilio()+"', TELEFONO_MOVIL='"+referencias.getTelefonoMovil()+"' WHERE ID_REFERENCIA="+referencias.getIdReferencia()+";";
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

    public Integer ExisteReferencia(Integer idSolicitud, String nombre1, String nombre2, String apellido1, String apellido2) {
        Integer idReferencia = 0;
        this.abrirConexion() ;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_REFERENCIA FROM REFERENCIAS where ID_SOLICITUD = " + idSolicitud +" AND NOMBRE1= '" + nombre1 +"' AND NOMBRE2 = '"+ nombre2+ "' AND APELLIDO1 = '"+ apellido1+ "' AND APELLIDO2 = '"+ apellido2 +"'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idReferencia = rs.getInt("ID_REFERENCIA"); 
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return idReferencia;
    }
    
    //obtener el siguiente id (autoincremental)
    public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_REFERENCIA), 0) AS X FROM REFERENCIAS";
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
}

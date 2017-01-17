/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;
import POJO.Asociaciones;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author MauricioBC
 */
public class AsociacionesDAO extends ConexionBD{
     public Asociaciones consultarPorId(int id) {
        Asociaciones temp = new Asociaciones();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_DETALLE_USUARIO, NOMBRE_ASOCIACION FROM ASOCIACIONES WHERE ID_ASOCIACION = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_ASOCIACION=id;      
                int ID_DETALLE_USUARIO=rs.getInt("ID_DETALLE_USUARIO");                        
                String NOMBRE_ASOCIACION=rs.getString("NOMBRE_ASOCIACION");
                
                temp.setIdAsociacion(ID_ASOCIACION);
                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setNombreAsociacion(NOMBRE_ASOCIACION);
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<Asociaciones> consultarTodos() {
        ArrayList<Asociaciones> lista = new ArrayList<Asociaciones>();
        Asociaciones temp = new Asociaciones();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_ASOCIACION, ID_DETALLE_USUARIO, NOMBRE_ASOCIACION FROM ASOCIACIONES;" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new Asociaciones();
                
                int ID_ASOCIACION=rs.getInt("ID_ASOCIACION");        
                int ID_DETALLE_USUARIO=rs.getInt("ID_DETALLE_USUARIO");                        
                String NOMBRE_ASOCIACION=rs.getString("NOMBRE_ASOCIACION");
                
                temp.setIdAsociacion(ID_ASOCIACION);
                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setNombreAsociacion(NOMBRE_ASOCIACION);
                
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return lista;
    }
    
     public boolean ingresar(Asociaciones asociaciones){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO ASOCIACIONES(ID_ASOCIACION,ID_DETALLE_USUARIO,NOMBRE_ASOCIACION) VALUES("+asociaciones.getIdAsociacion()+", "+asociaciones.getIdDetalleUsuario()+", '"+asociaciones.getNombreAsociacion()+"');";
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
    
    public boolean actualizar(Asociaciones asociaciones){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE ASOCIACIONES SET ID_DETALLE_USUARIO="+asociaciones.getIdDetalleUsuario()+", NOMBRE_ASOCIACION='"+asociaciones.getNombreAsociacion()+"' WHERE ID_ASOCIACION="+asociaciones.getIdAsociacion()+";";
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
    
    //Permite obtener el siguiente id de la Asociacion
     public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_ASOCIACION), 0) AS X FROM ASOCIACIONES";
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

    public Integer ExisteAsociacion(Integer idDetalleUsuario, String nombreAsociacion) {
        Integer idAsociacion = 0;
        this.abrirConexion() ;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_ASOCIACION FROM ASOCIACIONES where ID_DETALLE_USUARIO = " + idDetalleUsuario +" AND NOMBRE_ASOCIACION= '" + nombreAsociacion +"'" ;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idAsociacion = rs.getInt("ID_IDIOMA"); 
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return idAsociacion;
    }
    
    public ArrayList<Asociaciones> consultarPorIdDetalle(int id) {
        ArrayList<Asociaciones> asociacion = new ArrayList<Asociaciones>();        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_ASOCIACION, ID_DETALLE_USUARIO, NOMBRE_ASOCIACION FROM asociaciones WHERE ID_DETALLE_USUARIO = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                Asociaciones temp = new Asociaciones();
                int ID_ASOCIACION = rs.getInt("ID_ASOCIACION"); 
                int ID_DETALLE_USUARIO = rs.getInt("ID_DETALLE_USUARIO"); 
                String NOMBRE_ASOCIACION = rs.getString("NOMBRE_ASOCIACION");              

                temp.setIdAsociacion(ID_ASOCIACION);
                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setNombreAsociacion(NOMBRE_ASOCIACION);
                asociacion.add(temp);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return asociacion;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Cargo;
import java.sql.ResultSet;
import java.util.Date;

/**
 *
 * @author adminPC
 */
public class CargoDAO extends ConexionBD{
    
     
    //obtener el siguiente id (autoincremental)
    public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_CARGO), 0) AS X FROM CARGO";
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
    
    //Permite insertar un cargo Actual
    public boolean ingresarCargoActual(Cargo temp) {
        boolean exito = false;

        this.abrirConexion();
        try {
            stmt = conn.createStatement();

            String sql = "INSERT INTO cargo (ID_CARGO, ID_DETALLE_USUARIO, NOMBRE_CARGO) VALUES (" + temp.getIdCargo()+ "," + temp.getIdDetalleUsuario()+ ",'" + temp.getNombreCargo()+ "')";
            stmt.execute(sql);
            exito = true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }
        return exito;
    }
    
    //Permite insertar un cargo 
    public boolean ingresarCargo(Cargo temp) {
        boolean exito = false;

        this.abrirConexion();
        try {
            stmt = conn.createStatement();

            String sql = "INSERT INTO cargo (ID_CARGO, ID_DETALLE_USUARIO, NOMBRE_CARGO, FECHA_INICIO, FECHA_FIN, LUGAR, RESPONSABILIDADES) VALUES (" + temp.getIdCargo()+ "," + temp.getIdDetalleUsuario()+ ",'" + temp.getNombreCargo()+ "','" + temp.getFechaInicio()+ "','" + temp.getFechaFin()+ "','" + temp.getLugar()+ "','" + temp.getResponsabilidades()+ "')";
            stmt.execute(sql);
            exito = true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }
        return exito;
    }
    
    //Permite Obtener el Cargo actual de un usuario
    public Cargo obtenerCargoActual(String user) {
        Cargo temp = new Cargo();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_CARGO, C.ID_DETALLE_USUARIO, NOMBRE_CARGO,FECHA_INICIO, FECHA_FIN, LUGAR,RESPONSABILIDADES FROM CARGO c join DETALLE_USUARIO DU \n" +
                         "on DU.ID_DETALLE_USUARIO = C.ID_DETALLE_USUARIO \n" +
                         "JOIN USUARIO US ON US.ID_USUARIO  = DU.ID_USUARIO\n" +
                         "where FECHA_FIN is NULL AND NOMBRE_USUARIO = '" + user+"'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_DETALLE_USUARIO = rs.getInt("ID_DETALLE_USUARIO");
                int ID_CARGO = rs.getInt("ID_CARGO");
                String NOMBRE_CARGO = rs.getString("NOMBRE_CARGO");
                Date FECHA_INICIO = rs.getDate("FECHA_INICIO");
                Date FECHA_FIN = rs.getDate("FECHA_FIN");
                String LUGAR = rs.getString("LUGAR");
                String RESPONSABILIDADES = rs.getString("RESPONSABILIDADES");
                
                temp.setIdCargo(ID_CARGO);
                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setNombreCargo(NOMBRE_CARGO);
                temp.setFechaInicio(FECHA_INICIO);
                temp.setFechaFin(FECHA_FIN);
                temp.setLugar(LUGAR);
                temp.setResponsabilidades(RESPONSABILIDADES);
            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return temp;
    }
    
    //
    public boolean actualizarCargoActual(Cargo temp) {
        boolean exito = false;

        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "UPDATE CARGO SET NOMBRE_CARGO='"+temp.getNombreCargo()+ "' WHERE ID_CARGO = " +temp.getIdCargo();                         
            
            stmt.execute(sql);
            exito = true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }
        return exito;
    }

    public Integer ExisteAsociacionAnterior(Integer idDetalleUsuario, String lugarCargo, String cargoAnterior, Date fechaInicioCargo, Date fechaFinCargo) {
        Integer idCargo = 0;
        this.abrirConexion() ;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_CARGO FROM CARGO where ID_DETALLE_USUARIO = " + idDetalleUsuario +" AND LUGAR= '" + lugarCargo +"'" +" AND NOMBRE_CARGO= '" + cargoAnterior +"'" +" AND FECHA_INICIO= '" + fechaInicioCargo +"'" +" AND FECHA_FIN= '" + fechaFinCargo +"'" ;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idCargo = rs.getInt("ID_IDIOMA"); 
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return idCargo;
    }
    
    //Permite insertar un cargo Anterior
    public boolean ingresarCargoAnterior(Cargo temp) {
        boolean exito = false;

        this.abrirConexion();
        try {
            stmt = conn.createStatement();

            String sql = "INSERT INTO cargo (ID_CARGO, ID_DETALLE_USUARIO, NOMBRE_CARGO, LUGAR, FECHA_INICIO, FECHA_FIN, RESPONSABILIDADES) VALUES (" + temp.getIdCargo()+ "," + temp.getIdDetalleUsuario()+ ",'" + temp.getNombreCargo()+ "','" + temp.getLugar()+ "','" + temp.getFechaInicio()+ "','" + temp.getFechaFin()+ "','" + temp.getResponsabilidades()+"')";
            stmt.execute(sql);
            exito = true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }
        return exito;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Educacion;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author adminPC
 */
public class EducacionDao extends ConexionBD {
    
    //Permite obtener el idEducacion si ya existe en la base de datos una educacion
    public Integer ExisteEducacion(String tipoEducacion, String grado, String institucion, Integer anyo, Integer IdDetalleUsuario) {
        Integer idEducacion = 0;
        this.abrirConexion() ;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_EDUCACION FROM educacion where ID_DETALLE_USUARIO = " + IdDetalleUsuario +" AND TIPO_EDUCACION= '" + tipoEducacion +"' AND GRADO_ALCANZADO = '" + grado +"' AND NOMBRE_INSTITUCION= '" + institucion +"' AND ANIO = " + anyo ;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idEducacion = rs.getInt("ID_EDUCACION"); 
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return idEducacion;
    }
    
    //Permite obtener el siguiente id de la Educacion
     public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_EDUCACION), 0) AS X FROM EDUCACION";
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
    
    //Permite agregar una Educacion a la base de datos
     public boolean ingresar(Educacion educacion){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO educacion(ID_EDUCACION, ID_DETALLE_USUARIO, TIPO_EDUCACION, GRADO_ALCANZADO, NOMBRE_INSTITUCION, ANIO) VALUES("+educacion.getIdEducacion()+","+educacion.getIdDetalleUsuario()+",'"+educacion.getTipoEducacion()+"','"+educacion.getGradoAlcanzado()+"', '"+educacion.getNombreInstitucion()+"',"+educacion.getAnio()+");";
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
    
    //Permite actualizar una Educacion en la base de datos
     
     //consultar por id
    public ArrayList<Educacion> consultarPorIdDetalle(int id) {
        ArrayList<Educacion> educacion = new ArrayList<Educacion>();        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT `ID_EDUCACION`, `ID_DETALLE_USUARIO`, `TIPO_EDUCACION`, `GRADO_ALCANZADO`, `NOMBRE_INSTITUCION`, `ANIO` FROM `educacion` WHERE `ID_DETALLE_USUARIO` = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                Educacion temp = new Educacion();
                int ID_EDUCACION = rs.getInt("ID_EDUCACION"); 
                int ID_DETALLE_USUARIO = rs.getInt("ID_DETALLE_USUARIO"); 
                String TIPO_EDUCACION = rs.getString("TIPO_EDUCACION");
                String GRADO_ALCANZADO = rs.getString("GRADO_ALCANZADO");
                String NOMBRE_INSTITUCION = rs.getString("NOMBRE_INSTITUCION");
                int ANIO = rs.getInt("ANIO"); 

                temp.setIdEducacion(ID_EDUCACION);
                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setTipoEducacion(TIPO_EDUCACION);
                temp.setGradoAlcanzado(GRADO_ALCANZADO);
                temp.setNombreInstitucion(NOMBRE_INSTITUCION);
                temp.setAnio(ANIO);
                
                educacion.add(temp);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return educacion;
    }
    
}

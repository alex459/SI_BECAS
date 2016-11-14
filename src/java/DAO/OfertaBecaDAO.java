/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;
import POJO.OfertaBeca;
import java.sql.ResultSet;

/**
 *
 * @author MauricioBC
 */
public class OfertaBecaDAO extends ConexionBD{
     public boolean ingresar(OfertaBeca ofertaBeca){
        boolean exito = false;        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO OFERTA_BECA(ID_OFERTA_BECA,ID_INSTITUCION_ESTUDIO,ID_INSTITUCION_FINANCIERA,"
                    + "ID_DOCUMENTO, NOMBRE_OFERTA,TIPO_OFERTA_BECA,DURACION,FECHA_CIERRE,MODALIDAD,FECHA_INICIO,"
                    + "IDIOMA,FINANCIAMIENTO,PERFIL,FECHA_INGRESO,TIPO_ESTUDIO,OFERTA_BECA_ACTIVA)"
                    + " VALUES("+ofertaBeca.getIdOfertaBeca()+", "+ofertaBeca.getIdInstitucionEstudio()+", "+ofertaBeca.getIdInstitucionFinanciera()+","
                    + ""+ofertaBeca.getIdDocumento()+",'"+ofertaBeca.getNombreOferta()+"','"+ofertaBeca.getTipoOfertaBeca()+"',"
                    + ""+ofertaBeca.getDuracion()+",'"+ofertaBeca.getFechaCierre().toString()+"','"+ofertaBeca.getModalidad()+"',"
                    + "'"+ofertaBeca.getFechaInicio()+"','"+ofertaBeca.getIdioma()+"','"+ofertaBeca.getFinanciamiento()+"',"
                    + "'"+ofertaBeca.getPerfil()+"','"+ofertaBeca.getFechaIngreso()+"','"+ofertaBeca.getTipoEstudio()+"',"+ofertaBeca.getOfertaBecaActiva()+");";
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
    
    public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_OFERTA_BECA), 0) AS X FROM OFERTA_BECA";
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



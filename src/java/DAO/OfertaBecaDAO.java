/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;
import POJO.OfertaBeca;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author MauricioBC
 */
public class OfertaBecaDAO extends ConexionBD{
    
    //Metodo que permite el ingreso de una oferta de beca
    public boolean ingresar(OfertaBeca ofertaBeca){
        //variable que permite saber si se ingreso correctamente el nuevo registro
        boolean exito = false;        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO OFERTA_BECA(ID_OFERTA_BECA,ID_INSTITUCION_ESTUDIO,ID_INSTITUCION_FINANCIERA,"
                    + "ID_DOCUMENTO, NOMBRE_OFERTA,TIPO_OFERTA_BECA,DURACION,FECHA_CIERRE,MODALIDAD,FECHA_INICIO,"
                    + "IDIOMA,FINANCIAMIENTO,PERFIL,FECHA_INGRESO,TIPO_ESTUDIO,OFERTA_BECA_ACTIVA)"
                    + " VALUES("+ofertaBeca.getIdOfertaBeca()+", "+ofertaBeca.getIdInstitucionEstudio()+", "+ofertaBeca.getIdInstitucionFinanciera()+","
                    + ""+ofertaBeca.getIdDocumento()+",'"+ofertaBeca.getNombreOferta()+"','"+ofertaBeca.getTipoOfertaBeca()+"',"
                    + ""+ofertaBeca.getDuracion()+",'"+ofertaBeca.getFechaCierre()+"','"+ofertaBeca.getModalidad()+"',"
                    + "'"+ofertaBeca.getFechaInicio()+"','"+ofertaBeca.getIdioma()+"','"+ofertaBeca.getFinanciamiento()+"','"+ofertaBeca.getPerfil()+"','"+ofertaBeca.getFechaIngreso()+"','"+ofertaBeca.getTipoEstudio()+"',"+ofertaBeca.getOfertaBecaActiva()+");";
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
     
    
    public ArrayList<OfertaBeca> consultarTodos() {
        ArrayList<OfertaBeca> lista = new ArrayList<OfertaBeca>();
        OfertaBeca temp = new OfertaBeca();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_OFERTA_BECA,ID_INSTITUCION_ESTUDIO,ID_INSTITUCION_FINANCIERA,ID_DOCUMENTO,NOMBRE_OFERTA,"
                    + "TIPO_OFERTA_BECA,DURACION,FECHA_CIERRE,MODALIDAD,FECHA_INICIO,IDIOMA,FINANCIAMIENTO,"
                    + "PERFIL,FECHA_INGRESO,TIPO_ESTUDIO,OFERTA_BECA_ACTIVA FROM OFERTA_BECA";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                temp = new OfertaBeca();
                temp.setIdOfertaBeca(rs.getInt("ID_OFERTA_BECA"));
                temp.setIdInstitucionEstudio(rs.getInt("ID_INSTITUCION_ESTUDIO"));
                temp.setIdInstitucionFinanciera(rs.getInt("ID_INSTITUCION_FINANCIERA"));
                temp.setIdDocumento(rs.getInt("ID_DOCUMENTO"));
                temp.setNombreOferta(rs.getString("NOMBRE_OFERTA"));
                temp.setTipoOfertaBeca(rs.getString("TIPO_OFERTA_BECA"));
                temp.setDuracion(rs.getInt("DURACION"));
                temp.setFechaCierre(rs.getDate("FECHA_CIERRE"));
                temp.setModalidad(rs.getString("MODALIDAD"));
                temp.setFechaInicio(rs.getDate("FECHA_INICIO"));
                temp.setIdioma(rs.getString("IDIOMA"));
                temp.setFinanciamiento(rs.getString("FINANCIAMIENTO"));
                temp.setPerfil(rs.getString("PERFIL"));
                temp.setFechaIngreso(rs.getDate("FECHA_INGRESO"));
                temp.setTipoEstudio(rs.getString("TIPO_ESTUDIO"));
                temp.setOfertaBecaActiva(rs.getInt("OFERTA_BECA_ACTIVA"));          
                lista.add(temp);
            }            
            this.cerrarConexion();            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return lista;
    }
    
     public OfertaBeca consultarPorId(int id) {
        OfertaBeca temp = new OfertaBeca();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_INSTITUCION_ESTUDIO,ID_INSTITUCION_FINANCIERA,ID_DOCUMENTO,NOMBRE_OFERTA,"
                    + "TIPO_OFERTA_BECA,DURACION,FECHA_CIERRE,MODALIDAD,FECHA_INICIO,IDIOMA,FINANCIAMIENTO,"
                    + "PERFIL,FECHA_INGRESO,TIPO_ESTUDIO,OFERTA_BECA_ACTIVA FROM OFERTA_BECA WHERE ID_OFERTA_BECA = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_OFERTA_BECA=id;
                temp.setIdOfertaBeca(ID_OFERTA_BECA);
                temp.setIdInstitucionEstudio(rs.getInt("ID_INSTITUCION_ESTUDIO"));
                temp.setIdInstitucionFinanciera(rs.getInt("ID_INSTITUCION_FINANCIERA"));
                temp.setIdDocumento(rs.getInt("ID_DOCUMENTO"));
                temp.setNombreOferta(rs.getString("NOMBRE_OFERTA"));
                temp.setTipoOfertaBeca(rs.getString("TIPO_OFERTA_BECA"));
                temp.setDuracion(rs.getInt("DURACION"));
                temp.setFechaCierre(rs.getDate("FECHA_CIERRE"));
                temp.setModalidad(rs.getString("MODALIDAD"));
                temp.setFechaInicio(rs.getDate("FECHA_INICIO"));
                temp.setIdioma(rs.getString("IDIOMA"));
                temp.setFinanciamiento(rs.getString("FINANCIAMIENTO"));
                temp.setPerfil(rs.getString("PERFIL"));
                temp.setFechaIngreso(rs.getDate("FECHA_INGRESO"));
                temp.setTipoEstudio(rs.getString("TIPO_ESTUDIO"));
                temp.setOfertaBecaActiva(rs.getInt("OFERTA_BECA_ACTIVA"));
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    
     
    public boolean modificar(OfertaBeca ofertaBeca){
        boolean exito = false;        
        this.abrirConexion();
        try {
            stmt = conn.createStatement(); 
            String sql = "UPDATE OFERTA_BECA SET ID_INSTITUCION_ESTUDIO="+ofertaBeca.getIdInstitucionEstudio()
                    +",ID_INSTITUCION_FINANCIERA="+ofertaBeca.getIdInstitucionFinanciera()
                    +",ID_DOCUMENTO="+ofertaBeca.getIdDocumento()+",NOMBRE_OFERTA='"+ofertaBeca.getNombreOferta()
                    +"',TIPO_OFERTA_BECA='"+ofertaBeca.getTipoOfertaBeca()+"',DURACION="+ofertaBeca.getDuracion()
                    +",FECHA_CIERRE='"+ofertaBeca.getFechaCierre()+"',MODALIDAD='"+ofertaBeca.getModalidad()+"'"
                    +",FECHA_INICIO='"+ofertaBeca.getFechaInicio()+"',IDIOMA='"+ofertaBeca.getIdioma()+"'"
                    +",FINANCIAMIENTO='"+ofertaBeca.getFinanciamiento()+"',PERFIL='"+ofertaBeca.getPerfil()+"'"
                    +",FECHA_INGRESO='"+ofertaBeca.getFechaIngreso()+"',TIPO_ESTUDIO='"+ofertaBeca.getTipoEstudio()+"'"
                    +",OFERTA_BECA_ACTIVA="+ofertaBeca.getOfertaBecaActiva()+" WHERE ID_OFERTA_BECA="+ofertaBeca.getIdOfertaBeca()+";";
                 
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
    
     public boolean eliminar(OfertaBeca ofertaBeca){
        boolean exito = false;        
        this.abrirConexion();
        try {
            stmt = conn.createStatement(); 
            String sql = "UPDATE OFERTA_BECA SET OFERTA_BECA_ACTIVA=0 WHERE ID_OFERTA_BECA="+ofertaBeca.getIdOfertaBeca()+";";                 
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
    
     public String ObtenerTipoBeca(Integer id) {
        
        String tipo = "";
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT TIPO_OFERTA_BECA FROM oferta_beca ob JOIN solicitud_de_beca sb ON ob.ID_OFERTA_BECA= sb.ID_OFERTA_BECA where sb.ID_EXPEDIENTE = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            
            while (rs.next()) {
                tipo = rs.getString("TIPO_OFERTA_BECA");
            }
            
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return tipo;
    }
     
     //Permite consultar el id de la oferta de beca de un expediente
     public Integer consultarPorExpediente(int id) {
        Integer idOferta = 0;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT OB.ID_OFERTA_BECA FROM oferta_beca OB JOIN solicitud_de_beca SB ON OB.ID_OFERTA_BECA = SB.ID_OFERTA_BECA WHERE SB.ID_EXPEDIENTE = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idOferta = rs.getInt("ID_OFERTA_BECA");             
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return idOferta;
    }
     
     public String obtenerTituloBeca(int idExpediente) {
        String titulo = null;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT NOMBRE_OFERTA FROM `oferta_beca` OB JOIN solicitud_de_beca SB ON SB.ID_OFERTA_BECA = OB.ID_OFERTA_BECA WHERE SB.ID_EXPEDIENTE =" +idExpediente;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                titulo = rs.getString("NOMBRE_OFERTA");                
            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return titulo;
    } 
     
     //Metodo que permite el ingreso de una oferta de beca para la migracion de datos
    public boolean ingresarOfertaMigracion(OfertaBeca ofertaBeca){
        //variable que permite saber si se ingreso correctamente el nuevo registro
        boolean exito = false;        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO OFERTA_BECA(ID_OFERTA_BECA,ID_INSTITUCION_ESTUDIO,ID_INSTITUCION_FINANCIERA,"
                    + " NOMBRE_OFERTA,TIPO_OFERTA_BECA, TIPO_ESTUDIO,OFERTA_BECA_ACTIVA)"
                    + " VALUES("+ofertaBeca.getIdOfertaBeca()+", "+ofertaBeca.getIdInstitucionEstudio()+", "+ofertaBeca.getIdInstitucionFinanciera()+","
                    + ""+ofertaBeca.getNombreOferta()+"','"+ofertaBeca.getTipoOfertaBeca()+"',"
                    + "'"+ofertaBeca.getTipoEstudio()+"',0);";
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
    
    //Permite obtener si la oferta de beca es interna o externa segun el el id de la institucion
    public String ObtenerTipoOfertaBeca(int idInstitucionEstudio) {
        String tipo = null;
        this.abrirConexion();
        try {
            String pais =  "";
            stmt = conn.createStatement();
            String sql = "SELECT PAIS FROM institucion WHERE ID_INSTITUCION = " + idInstitucionEstudio;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                pais = rs.getString("PAIS");
                if (pais.equals("EL SALVADOR")){
                    tipo = "INTERNA";
                }else{
                    tipo = "EXTERNA";
                }                
            }
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        return tipo;
    } 
}



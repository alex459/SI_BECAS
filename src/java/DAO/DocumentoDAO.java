/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Documento;
import POJO.TipoDocumento;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author MauricioBC
 */
public class DocumentoDAO extends ConexionBD{

    public Integer getSiguienteId() {
        Integer siguiente = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_DOCUMENTO), 0) AS X FROM DOCUMENTO";
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

    public boolean Ingresar(Documento documento) {
        boolean exito = false;
        
        this.abrirConexion();
        try {
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
            
            String sql = "INSERT INTO DOCUMENTO(ID_DOCUMENTO, ID_TIPO_DOCUMENTO,DOCUMENTO_DIGITAL, OBSERVACION_O,ID_EXPEDIENTE,ESTADO_DOCUMENTO,FECHA_INGRESO) VALUES(?,?,?,?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, documento.getIdDocumento());
            statement.setInt(2, documento.getIdTipoDocumento().getIdTipoDocumento());     
            if (documento.getDocumentoDigital() != null) {
                statement.setBlob(3, documento.getDocumentoDigital());
            }
            statement.setString(4, documento.getObservacion());
            statement.setInt(5, documento.getIdExpediente().getIdExpediente());
            statement.setString(6, documento.getEstadoDocumento());
            statement.setDate(7, sqlDate);
            int row = statement.executeUpdate();
            
            exito = true;
            this.cerrarConexion();
        }catch (Exception e) {
            e.printStackTrace();
        }finally{
            this.cerrarConexion();
        }
        return exito;
    }
    
    //Actualiza un Documento
    public boolean ActualizarDocumentoObservacion(Documento documento) {
        boolean exito = false;
        
        this.abrirConexion();
        try {
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
            String sql = "UPDATE DOCUMENTO SET DOCUMENTO_DIGITAL=?,OBSERVACION_O=?, FECHA_INGRESO=? WHERE ID_DOCUMENTO=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            if (documento.getDocumentoDigital() != null) {
                statement.setBlob(1, documento.getDocumentoDigital());
            }
            statement.setString(2, documento.getObservacion());
            statement.setDate(3, sqlDate);
            statement.setInt(4, documento.getIdDocumento());     
      
            int row = statement.executeUpdate();
            
            exito = true;
            this.cerrarConexion();
        }catch (Exception e) {
            e.printStackTrace();
        }finally{
            this.cerrarConexion();
        }
        return exito;
    }
    
    //Actualiza la observacion de un Documento
    public boolean ActualizarObservacion(Documento documento) {
        boolean exito = false;
        
        this.abrirConexion();
        try {
            
            String sql = "UPDATE DOCUMENTO SET OBSERVACION_O=? WHERE ID_DOCUMENTO=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, documento.getObservacion());
            statement.setInt(2, documento.getIdDocumento());     
      
            int row = statement.executeUpdate();
            
            exito = true;
            this.cerrarConexion();
        }catch (Exception e) {
            e.printStackTrace();
        }finally{
            this.cerrarConexion();
        }
        return exito;
    }
    
     //Actualiza la observacion de un Documento
    public boolean ActualizarDocDig(Documento documento) {
        boolean exito = false;
        System.out.println(documento.getIdDocumento()+" "+documento.getDocumentoDigital());
        this.abrirConexion();
        try {            
            String sql = "UPDATE DOCUMENTO SET DOCUMENTO_DIGITAL=? WHERE ID_DOCUMENTO=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setBinaryStream(1, documento.getDocumentoDigital());
            statement.setInt(2, documento.getIdDocumento());    
            int row = statement.executeUpdate();
            exito = true;
            this.cerrarConexion();
        }catch (Exception e) {
            e.printStackTrace();
        }finally{
            this.cerrarConexion();
        }
        return exito;
    }
    
    //Consulta Todos los Documentos Publicos
    public ArrayList<Documento> consultarTodos() {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ESTADO_DOCUMENTO = \"Publico\"" ;
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Documento temp = new Documento();
                TipoDocumento temp2 = new TipoDocumento();                
                int ID_DOCUMENTO=rs.getInt("ID_DOCUMENTO");        
                Integer ID_TIPO_DOCUMENTO=rs.getInt("ID_TIPO_DOCUMENTO");                        
                String OBSERVACION=rs.getString("OBSERVACION_O");
                String TIPO_DOCUMENTO = rs.getString("TIPO_DOCUMENTO");                
                temp.setIdDocumento(ID_DOCUMENTO);
                temp2.setIdTipoDocumento(ID_TIPO_DOCUMENTO);
                temp2.setTipoDocumento(TIPO_DOCUMENTO);
                temp.setIdTipoDocumento(temp2);
                temp.setObservacion(OBSERVACION);               
                lista.add(temp);
            }            
            this.cerrarConexion();            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return lista;
    }
    
    public Boolean eliminarDocumento(Integer id) {
        this.abrirConexion();
        Boolean exito =false;
        try {
            stmt = conn.createStatement();
            String sql = "DELETE FROM DOCUMENTO WHERE ID_DOCUMENTO =" +id;
            ResultSet rs = stmt.executeQuery(sql);
            exito=true;
            this.cerrarConexion();
            
            
            
            
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return exito;
    }
    
    public Documento ObtenerPorId(Integer id) {
        
        this.abrirConexion();
        Documento doc= new Documento();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO,D.DOCUMENTO_DIGITAL, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ESTADO_DOCUMENTO = \"Publico\" AND D.ID_DOCUMENTO=" +id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            Blob blob = rs.getBlob("D.DOCUMENTO_DIGITAL");
            InputStream DOCUMENTO_DIGITAL = blob.getBinaryStream();
            doc.setDocumentoDigital(DOCUMENTO_DIGITAL);
            
            
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return doc;
    }
    
    public Documento consultarPorId2(Integer id) {
        this.abrirConexion();
        Documento temp = new Documento();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ESTADO_DOCUMENTO = \"Publico\" AND D.ID_DOCUMENTO=" +id;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                
                TipoDocumento temp2 = new TipoDocumento();
                
                int ID_DOCUMENTO=rs.getInt("ID_DOCUMENTO");        
                Integer ID_TIPO_DOCUMENTO=rs.getInt("ID_TIPO_DOCUMENTO");                        
                String OBSERVACION=rs.getString("OBSERVACION_O");
                String TIPO_DOCUMENTO = rs.getString("TIPO_DOCUMENTO");
                
                temp.setIdDocumento(ID_DOCUMENTO);
                temp2.setIdTipoDocumento(ID_TIPO_DOCUMENTO);
                temp2.setTipoDocumento(TIPO_DOCUMENTO);
                temp.setIdTipoDocumento(temp2);
                temp.setObservacion(OBSERVACION);
                
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return temp;
    }
    
    public Documento consultarPorId(Integer id) {
        this.abrirConexion();
        Documento temp = new Documento();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.DOCUMENTO_DIGITAL,D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ESTADO_DOCUMENTO = \"Publico\" AND D.ID_DOCUMENTO=" +id;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                
                TipoDocumento temp2 = new TipoDocumento();
                
                int ID_DOCUMENTO=rs.getInt("ID_DOCUMENTO");        
                Integer ID_TIPO_DOCUMENTO=rs.getInt("ID_TIPO_DOCUMENTO");                        
                String OBSERVACION=rs.getString("OBSERVACION_O");
                String TIPO_DOCUMENTO = rs.getString("TIPO_DOCUMENTO");
                Blob blob= rs.getBlob("DOCUMENTO_DIGITAL");
                InputStream DOCUMENTO_DIGITAL = blob.getBinaryStream();
                
                temp.setIdDocumento(ID_DOCUMENTO);
                temp2.setIdTipoDocumento(ID_TIPO_DOCUMENTO);
                temp2.setTipoDocumento(TIPO_DOCUMENTO);
                temp.setIdTipoDocumento(temp2);
                temp.setObservacion(OBSERVACION);
                temp.setDocumentoDigital(DOCUMENTO_DIGITAL);
                
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return temp;
    }
    
    public Documento consultarOfertaPorId(Integer id) {
        this.abrirConexion();
        Documento temp = new Documento();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.DOCUMENTO_DIGITAL,D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ID_DOCUMENTO=" +id;
            ResultSet rs = stmt.executeQuery(sql);
            System.out.println(sql);

            while (rs.next()) {
                
                TipoDocumento temp2 = new TipoDocumento();
                
                int ID_DOCUMENTO=rs.getInt("ID_DOCUMENTO");        
                Integer ID_TIPO_DOCUMENTO=rs.getInt("ID_TIPO_DOCUMENTO");                        
                String OBSERVACION=rs.getString("OBSERVACION_O");
                String TIPO_DOCUMENTO = rs.getString("TIPO_DOCUMENTO");
                Blob blob= rs.getBlob("DOCUMENTO_DIGITAL");
                InputStream DOCUMENTO_DIGITAL = blob.getBinaryStream();
                
                temp.setIdDocumento(ID_DOCUMENTO);
                temp2.setIdTipoDocumento(ID_TIPO_DOCUMENTO);
                temp2.setTipoDocumento(TIPO_DOCUMENTO);
                temp.setIdTipoDocumento(temp2);
                temp.setObservacion(OBSERVACION);
                temp.setDocumentoDigital(DOCUMENTO_DIGITAL);
                
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return temp;
    }
    
    //Obtiene el id del documento publico enviandole el id del tipo de Documento
    public Integer ObtenerIdDocumento(Integer id) {
        
        Integer idDoc = 0;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_DOCUMENTO AS X FROM DOCUMENTO WHERE ID_TIPO_DOCUMENTO=" + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            
            while (rs.next()) {
                idDoc = rs.getInt("X");
            }
            
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return idDoc;
    }
    
    //Permite crear un nuevo expediente
        public boolean solicitarDocumento(Documento acuerdo){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO DOCUMENTO (ID_DOCUMENTO, ID_TIPO_DOCUMENTO, ID_EXPEDIENTE, FECHA_SOLICITUD, OBSERVACION_O, ESTADO_DOCUMENTO) VALUES ( " + acuerdo.getIdDocumento()+"," + acuerdo.getIdTipoDocumento().getIdTipoDocumento()+"," + acuerdo.getIdExpediente().getIdExpediente()+",'" + acuerdo.getFechaSolicitud()+"','" + acuerdo.getObservacion()+"','" + acuerdo.getEstadoDocumento()+"')";
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
        
    //Elimina los Documentos de un expediente PERMANENTEMENTE de la BD
        public Boolean eliminarDocumentosExpediente(Integer id) {
        this.abrirConexion();
        Boolean exito =false;
        try {
            stmt = conn.createStatement();
            String sql = "DELETE FROM DOCUMENTOS WHERE ID_EXPEDIENTE =" +id;
            ResultSet rs = stmt.executeQuery(sql);
            exito=true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return exito;
    }
    
}

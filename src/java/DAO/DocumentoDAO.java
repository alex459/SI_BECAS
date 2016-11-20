/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Documento;
import POJO.TipoDocumento;
import java.io.InputStream;
import java.sql.ResultSet;
import java.util.ArrayList;

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
            stmt = conn.createStatement();
            String sql = "INSERT INTO DOCUMENTO(ID_DOCUMENTO, ID_TIPO_DOCUMENTO,DOCUMENTO_DIGITAL, OBSERVACION_O,ID_EXPEDIENTE,ESTADO_DOCUMENTO) VALUES("+documento.getIdDocumento()+", "+documento.getIdTipoDocumento().getIdTipoDocumento()+", '"+documento.getDocumentoDigital()+"', '"+documento.getObservacion()+"', '"+documento.getIdExpediente().getIdExpediente()+"', '"+documento.getEstadoDocumento()+"')";
            stmt.execute(sql);
            exito = true;
            System.out.println(sql);
            this.cerrarConexion();
        }catch (Exception e) {
            System.out.println("Error " + e);
        }finally{
            this.cerrarConexion();
        }
        return exito;
    }
    
    public ArrayList<Documento> consultarTodos() {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO,D.DOCUMENTO_DIGITAL, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ESTADO_DOCUMENTO = \"Publico\"" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                Documento temp = new Documento();
                TipoDocumento temp2 = new TipoDocumento();
                
                int ID_DOCUMENTO=rs.getInt("ID_DOCUMENTO");        
                Integer ID_TIPO_DOCUMENTO=rs.getInt("ID_TIPO_DOCUMENTO");                        
                String OBSERVACION=rs.getString("OBSERVACION_O");
                InputStream DOCUMENTO_DIGITAL = rs.getBinaryStream("DOCUMENTO_DIGITAL");
                String TIPO_DOCUMENTO = rs.getString("TIPO_DOCUMENTO");
                
                temp.setIdDocumento(ID_DOCUMENTO);
                temp2.setIdTipoDocumento(ID_TIPO_DOCUMENTO);
                temp2.setTipoDocumento(TIPO_DOCUMENTO);
                temp.setIdTipoDocumento(temp2);
                temp.setObservacion(OBSERVACION);
                temp.setDocumentoDigital(DOCUMENTO_DIGITAL);
                
                
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
            
            InputStream DOCUMENTO_DIGITAL = rs.getBinaryStream("DOCUMENTO_DIGITAL");
            doc.setDocumentoDigital(DOCUMENTO_DIGITAL);
            
            
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return doc;
    }
    
    public Documento consultarPorId(Integer id) {
        this.abrirConexion();
        Documento temp = new Documento();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO,D.DOCUMENTO_DIGITAL, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ESTADO_DOCUMENTO = \"Publico\" AND D.ID_DOCUMENTO=" +id;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                
                TipoDocumento temp2 = new TipoDocumento();
                
                int ID_DOCUMENTO=rs.getInt("ID_DOCUMENTO");        
                Integer ID_TIPO_DOCUMENTO=rs.getInt("ID_TIPO_DOCUMENTO");                        
                String OBSERVACION=rs.getString("OBSERVACION_O");
                InputStream DOCUMENTO_DIGITAL = rs.getBinaryStream("DOCUMENTO_DIGITAL");
                String TIPO_DOCUMENTO = rs.getString("TIPO_DOCUMENTO");
                
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
    
}

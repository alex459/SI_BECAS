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
            System.out.println("DOC "+sql);
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
    
    //Consulta Todos los Documentos Publicos
    public ArrayList<Documento> consultarComisionExpe(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (105,106, 107, 108, 109, 110, 111) ";
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
    
    //Elimina un documento por su id
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
        
    //Conultar documentos con un tipo de documento y expediente especificos
        public Documento ObtenerPorExpedienteProgreso(int exp, int idProg, int idTipoDoc) {        
        this.abrirConexion();
        Documento doc= new Documento();
        TipoDocumento tipo= new TipoDocumento();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT DOCUMENTO.ID_DOCUMENTO AS ID_DOCUMENTO,DOCUMENTO_DIGITAL FROM DOCUMENTO,EXPEDIENTE WHERE "
                    + " EXPEDIENTE.ID_EXPEDIENTE=DOCUMENTO.ID_EXPEDIENTE AND EXPEDIENTE.ID_EXPEDIENTE="+exp+" "
                    + " AND EXPEDIENTE.ID_PROGRESO="+idProg+" AND DOCUMENTO.ID_TIPO_DOCUMENTO="+idTipoDoc+";";
            System.out.println(sql);
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            if(rs.next()){
                tipo.setIdTipoDocumento(100);
            Blob blob = rs.getBlob("DOCUMENTO_DIGITAL");
            InputStream DOCUMENTO_DIGITAL = blob.getBinaryStream();
            doc.setIdDocumento(rs.getInt("ID_DOCUMENTO"));
            doc.setIdTipoDocumento(tipo);
            doc.setDocumentoDigital(DOCUMENTO_DIGITAL);    }  
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return doc;
    }

    public Integer ExisteDocumento(Integer idExpediente, Integer idTipo) {
        Integer idDocumento = 0;
        this.abrirConexion() ;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_DOCUMENTO FROM DOCUMENTO where ID_EXPEDIENTE = " + idExpediente +" AND ID_TIPO_DOCUMENTO= " + idTipo;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idDocumento = rs.getInt("ID_DOCUMENTO"); 
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return idDocumento;
    }
    
    public Documento obtenerDocumentoExpediente(Integer id) {
        this.abrirConexion();
        Documento temp = new Documento();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.DOCUMENTO_DIGITAL,D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ID_DOCUMENTO=" +id;
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
    
    public Documento obtenerInformacionDocumentoPorId(Integer id) {
        this.abrirConexion();
        Documento temp = new Documento();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO, D.ESTADO_DOCUMENTO ,TD.DEPARTAMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ID_DOCUMENTO=" +id;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                
                TipoDocumento temp2 = new TipoDocumento();
                
                int ID_DOCUMENTO=rs.getInt("ID_DOCUMENTO");        
                Integer ID_TIPO_DOCUMENTO=rs.getInt("ID_TIPO_DOCUMENTO");                        
                String OBSERVACION=rs.getString("OBSERVACION_O");
                String TIPO_DOCUMENTO = rs.getString("TIPO_DOCUMENTO");
                String ESTADO_DOCUMENTO = rs.getString("ESTADO_DOCUMENTO");
                String DEPARTAMENTO = rs.getString("DEPARTAMENTO");
                
                
                temp.setIdDocumento(ID_DOCUMENTO);
                temp2.setIdTipoDocumento(ID_TIPO_DOCUMENTO);
                temp2.setTipoDocumento(TIPO_DOCUMENTO);
                temp2.setDepartamento(DEPARTAMENTO);
                temp.setIdTipoDocumento(temp2);
                temp.setObservacion(OBSERVACION);
                temp.setEstadoDocumento(ESTADO_DOCUMENTO);
                
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return temp;
    }  
    
    
    //Actualiza un Documento de ingresado a aprobado o denegado
    public boolean ActualizarResolver(Documento documento) {
        boolean exito = false;
        
        this.abrirConexion();
        try {
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
            String sql = "UPDATE DOCUMENTO SET DOCUMENTO_DIGITAL=?,OBSERVACION_O=?, FECHA_INGRESO=?,ESTADO_DOCUMENTO=? WHERE ID_DOCUMENTO=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            if (documento.getDocumentoDigital() != null) {
                statement.setBlob(1, documento.getDocumentoDigital());
            }
            statement.setString(2, documento.getObservacion());
            statement.setDate(3, sqlDate);
            statement.setString(4, documento.getEstadoDocumento());
            statement.setInt(5, documento.getIdDocumento());     
      
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
    
    //Actualiza un Documento de ingresado a aprobado o denegado
    public boolean ActualizarResolverCorreccion(Documento documento) {
        boolean exito = false;
        
        this.abrirConexion();
        try {
            Date fechaHoy = new Date();
            java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
            String sql = "UPDATE DOCUMENTO SET OBSERVACION_O=?, FECHA_INGRESO=?,ESTADO_DOCUMENTO=? WHERE ID_DOCUMENTO=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, documento.getObservacion());
            statement.setDate(2, sqlDate);
            statement.setString(3, documento.getEstadoDocumento());
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
    
    //Obtiene el id del expediente de un Documento
    public Integer ObtenerIdExpedientePorIdDocumento(Integer id) {
        
        Integer idExp = 0;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_EXPEDIENTE AS X FROM DOCUMENTO WHERE ID_DOCUMENTO=" + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            
            while (rs.next()) {
                idExp = rs.getInt("X");
            }
            
        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        
        return idExp;
    }
       
     //obtener documentos de junta directiva por progreso   1. ACUERDO DE PERMISO INICIAL
    public ArrayList<Documento> consultarJuntaDirectivaExpeProceso1(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE D.ID_EXPEDIENTE='" + exp + "' AND D.ID_TIPO_DOCUMENTO IN (100,101,102)";
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
    
    //obtener documentos de junta directiva por progreso   4. ACUERDOS DE PERMISOS DE BECA JUNTA DIRECTIVA
     public ArrayList<Documento> consultarJuntaDirectivaExpeProceso4(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (103, 105, 112) ";
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
    //obtener documentos de junta directiva por progreso   10. ACUERDO FISCAL
    public ArrayList<Documento> consultarJuntaDirectivaExpeProceso10(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO = 135 ";
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
    //obtener documentos de junta directiva por progreso   12. CUMPLIMIENTO DE SERVICIO CONTRACTUAL 
    public ArrayList<Documento> consultarJuntaDirectivaExpeProceso12(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (147, 148, 149)";
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
     //obtener documentos de junta directiva por progreso   13. ACUERDO DE GESTION DE COMPROMISO CONTRACTUAL
    public ArrayList<Documento> consultarJuntaDirectivaExpeProceso13(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (153, 154)";
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
     //obtener documentos de junta directiva por progreso   20. ACUERDO DE PRORROGA DE JUNTA DIRECTIVA
    public ArrayList<Documento> consultarJuntaDirectivaExpeProceso20(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (137, 138, 139, 140)";
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
    //obtener documentos de consejo superior universitario   7. ACUERDOS DEL CONSEJO SUPERIOR UNIVERSITARIO
    public ArrayList<Documento> consultarConsejoSuperiorUniversitario7(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (131)";
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
    
    //obtener documentos de consejo superior universitario   15. ACUERDO DE LIBERACION DE BECARIO
    public ArrayList<Documento> consultarConsejoSuperiorUniversitario15(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (156,157) ";
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
    
    //obtener documentos de consejo superior universitario   22. ACUERDO DE PRORROGA CONSEJO SUPERIOR UNIVERSITARIO
    public ArrayList<Documento> consultarConsejoSuperiorUniversitario22(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (141) ";
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
    
    //obtener documentos de consejo de becas   2. ACUERDO DE AUTORIZACION INICIAL
    public ArrayList<Documento> consultarConsejoBecas2(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (101, 102, 103,104 )";
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
    //obtener documentos de consejo de becas   5. SOLICITUD DE BECAS
    public ArrayList<Documento> consultarConsejoBecas5(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (103,105,119,120,121,122, 123,124,125,126,127,128,129,130)";
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
    //obtener documentos de consejo de becas   5. CUMPLIMIENTO DE SERVICIO CONTRACTUAL
    public ArrayList<Documento> consultarConsejoBecas12(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (147,148,150,151 )";
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
     //obtener documentos de consejo de becas   15. ACUERDO DE LIBERACION DE BECARIO
    public ArrayList<Documento> consultarConsejoBecas15(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (155, 156 )";
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
     //obtener documentos de consejo de becas   15. ACUERDO DE PRORROGA CONSEJO DE BECAS
    public ArrayList<Documento> consultarConsejoBecas21(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE='" + exp + "' AND TD.ID_TIPO_DOCUMENTO IN (138,139,140 )";
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
     //obtener documentos de expediente   8. CONTRATO DE BECA
    public ArrayList<Documento> consultarFiscaliaContratoBeca(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE = " + exp + " AND D.ESTADO_DOCUMENTO IN ('APROBADO','INGRESADO')" ;
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
   
//obtener documentos de expediente   8. CONTRATO DE BECA
    public ArrayList<Documento> consultarFiscaliaReintegroBeca(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE E.ID_EXPEDIENTE = " + exp + " AND D.ESTADO_DOCUMENTO NOT IN ('PENDIENTE')" ;
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
    
    //Actualiza un Documento de ingresado a aprobado o denegado
    public boolean ActualizarEstadoDocumento(Documento documento) {
        boolean exito = false;
        
        this.abrirConexion();
        try {
            String sql = "UPDATE DOCUMENTO SET ESTADO_DOCUMENTO=?, OBSERVACION_O = ? WHERE ID_DOCUMENTO=?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, documento.getEstadoDocumento());
            statement.setString(2, documento.getObservacion());
            statement.setInt(3, documento.getIdDocumento());     
      
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
    
    //Consulta Todos las solicitudes de un becario
    public ArrayList<Documento> consultarSolicitudesBecario(int idExpediente) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ID_TIPO_DOCUMENTO IN (135,137,149,153,156) AND D.ID_EXPEDIENTE = " +idExpediente ;
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
    
    //Consulta Todos las solicitudes de un candidato
    public ArrayList<Documento> consultarSolicitudesCandidato(int idExpediente) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT D.ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO, D.ESTADO_DOCUMENTO FROM DOCUMENTO D INNER JOIN TIPO_DOCUMENTO TD ON D.ID_TIPO_DOCUMENTO = TD.ID_TIPO_DOCUMENTO WHERE D.ID_TIPO_DOCUMENTO IN (103,105,112,131) AND D.ID_EXPEDIENTE = " +idExpediente ;
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Documento temp = new Documento();
                TipoDocumento temp2 = new TipoDocumento();                
                int ID_DOCUMENTO=rs.getInt("ID_DOCUMENTO");        
                Integer ID_TIPO_DOCUMENTO=rs.getInt("ID_TIPO_DOCUMENTO");                        
                String OBSERVACION=rs.getString("OBSERVACION_O");
                String TIPO_DOCUMENTO = rs.getString("TIPO_DOCUMENTO");  
                String ESTADO_DOCUMENTO = rs.getString("ESTADO_DOCUMENTO");
                temp.setIdDocumento(ID_DOCUMENTO);
                temp2.setIdTipoDocumento(ID_TIPO_DOCUMENTO);
                temp2.setTipoDocumento(TIPO_DOCUMENTO);
                temp.setIdTipoDocumento(temp2);
                temp.setObservacion(OBSERVACION);
                temp.setEstadoDocumento(ESTADO_DOCUMENTO);
                lista.add(temp);
            }            
            this.cerrarConexion();            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return lista;
    }
    
    public ArrayList<Documento> documentosPermisoInicial(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(D.ID_DOCUMENTO), 0) AS ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE D.ID_EXPEDIENTE='" + exp + "' AND D.ID_TIPO_DOCUMENTO IN (100,101,102) GROUP BY  D.ID_TIPO_DOCUMENTO";
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
    
    public ArrayList<Documento> documentosAutorizacionInicial(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(D.ID_DOCUMENTO), 0) AS ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE D.ID_EXPEDIENTE='" + exp + "' AND D.ID_TIPO_DOCUMENTO IN (101,102,104) GROUP BY  D.ID_TIPO_DOCUMENTO";
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
    
    public ArrayList<Documento> documentosDictamenPropuesta(int exp) {
        ArrayList<Documento> lista = new ArrayList<Documento>();
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(D.ID_DOCUMENTO), 0) AS ID_DOCUMENTO, D.ID_TIPO_DOCUMENTO, D.OBSERVACION_O, TD.TIPO_DOCUMENTO FROM TIPO_DOCUMENTO TD JOIN DOCUMENTO D ON TD.ID_TIPO_DOCUMENTO = D.ID_TIPO_DOCUMENTO JOIN EXPEDIENTE E ON D.ID_EXPEDIENTE = E.ID_EXPEDIENTE WHERE D.ID_EXPEDIENTE='" + exp + "' AND D.ID_TIPO_DOCUMENTO IN (106,107,108,109,110,111) GROUP BY  D.ID_TIPO_DOCUMENTO";
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
}

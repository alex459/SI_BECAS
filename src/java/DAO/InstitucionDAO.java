/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.Institucion;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author MauricioBC
 */
public class InstitucionDAO extends ConexionBD{
     public Institucion consultarPorId(int id) {
        Institucion temp = new Institucion();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT NOMBRE_INSTITUCION, TIPO_INSITUCION, PAIS, PAGINA_WEB, EMAIL, INSTITUCION_ACTIVA FROM INSTITUCION WHERE ID_INSTITUCION = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_INSTITUCION=id;                                
                String NOMBRE_INSTITUCION=rs.getString("NOMBRE_INSTITUCION");
                String TIPO_INSITUCION=rs.getString("TIPO_INSITUCION");
                String PAIS=rs.getString("PAIS");
                String PAGINA_WEB=rs.getString("PAGINA_WEB");
                String EMAIL=rs.getString("EMAIL");
                int INSTITUCION_ACTIVA=rs.getInt("INSTITUCION_ACTIVA");
                
                temp.setIdInstitucion(ID_INSTITUCION);
                temp.setNombreInstitucion(NOMBRE_INSTITUCION);
                temp.setTipoInstitucion(TIPO_INSITUCION);
                temp.setPais(PAIS);
                temp.setPaginaWeb(PAGINA_WEB);
                temp.setEmail(EMAIL);
                temp.setInstitucionActiva(INSTITUCION_ACTIVA);
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<Institucion> consultarTodos() {
        ArrayList<Institucion> lista = new ArrayList<Institucion>();
        Institucion temp = new Institucion();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "ID_INSTITUCION, NOMBRE_INSTITUCION, TIPO_INSITUCION, PAIS, PAGINA_WEB, EMAIL, INSTITUCION_ACTIVA FROM INSTITUCION;" ;
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                temp = new Institucion();
                int ID_INSTITUCION=rs.getInt("ID_INSTITUCION");                                
                String NOMBRE_INSTITUCION=rs.getString("NOMBRE_INSTITUCION");
                String TIPO_INSITUCION=rs.getString("TIPO_INSITUCION");
                String PAIS=rs.getString("PAIS");
                String PAGINA_WEB=rs.getString("PAGINA_WEB");
                String EMAIL=rs.getString("EMAIL");
                int INSTITUCION_ACTIVA=rs.getInt("INSTITUCION_ACTIVA");                
                temp.setIdInstitucion(ID_INSTITUCION);
                temp.setNombreInstitucion(NOMBRE_INSTITUCION);
                temp.setTipoInstitucion(TIPO_INSITUCION);
                temp.setPais(PAIS);
                temp.setPaginaWeb(PAGINA_WEB);
                temp.setEmail(EMAIL);
                temp.setInstitucionActiva(INSTITUCION_ACTIVA);                
                lista.add(temp);
            }            
            this.cerrarConexion();            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return lista;
    }
    
    //consultar nombre de insitucion por tipo de insitucion
    public ArrayList<Institucion> consultarPorTipo(String tipo) {
        ArrayList<Institucion> lista = new ArrayList<Institucion>();
        Institucion temp = new Institucion();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_INSTITUCION, NOMBRE_INSTITUCION, PAIS, PAGINA_WEB, EMAIL, INSTITUCION_ACTIVA FROM INSTITUCION WHERE TIPO_INSTITUCION='"+tipo+"';";
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                temp = new Institucion();
                int ID_INSTITUCION=rs.getInt("ID_INSTITUCION");                                
                String NOMBRE_INSTITUCION=rs.getString("NOMBRE_INSTITUCION");
                String TIPO_INSITUCION=tipo;
                String PAIS=rs.getString("PAIS");
                String PAGINA_WEB=rs.getString("PAGINA_WEB");
                String EMAIL=rs.getString("EMAIL");
                int INSTITUCION_ACTIVA=rs.getInt("INSTITUCION_ACTIVA");                
                temp.setIdInstitucion(ID_INSTITUCION);
                temp.setNombreInstitucion(NOMBRE_INSTITUCION);
                temp.setTipoInstitucion(TIPO_INSITUCION);
                temp.setPais(PAIS);
                temp.setPaginaWeb(PAGINA_WEB);
                temp.setEmail(EMAIL);
                temp.setInstitucionActiva(INSTITUCION_ACTIVA);                
                lista.add(temp);
            }            
            this.cerrarConexion();            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return lista;
    }
    
    //consultar nombre de insitucion por tipo de insitucion
    public int consultarIdPorNombre(String nombre) {
        Institucion temp = new Institucion();        
        this.abrirConexion();        
        try {
            stmt = conn.createStatement();            
            String sql = "SELECT ID_INSTITUCION FROM INSTITUCION WHERE NOMBRE_INSTITUCION='"+nombre+"';";
            ResultSet rs = stmt.executeQuery(sql);
            if(rs.next()) {                
                int ID_INSTITUCION=rs.getInt("ID_INSTITUCION");                  
                temp.setIdInstitucion(ID_INSTITUCION);
            }            
            this.cerrarConexion();            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        System.out.println("AAAAAAAAAAAAAAA");
        System.out.println("BBBBBBBB "+temp.getIdInstitucion());
        return temp.getIdInstitucion();
    }
    
     //obtener el siguiente id (autoincremental)
    public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_INSTITUCION), 0) AS X FROM INSTITUCION";
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
    
    public boolean ingresar(Institucion insitucion){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO INSTITUCION(ID_INSTITUCION,NOMBRE_INSTITUCION,TIPO_INSTITUCION,PAIS,PAGINA_WEB,EMAIL,INSTITUCION_ACTIVA) VALUES ('"+insitucion.getIdInstitucion()+"','"+insitucion.getNombreInstitucion()+"','"+insitucion.getTipoInstitucion()+"','"+insitucion.getPais()+"', '"+insitucion.getPaginaWeb()+"','"+insitucion.getEmail()+"',"+insitucion.getInstitucionActiva()+");";
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
    
    public boolean actualizar(Institucion insitucion){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE INSTITUCION SET NOMBRE_INSITUCION='"+insitucion.getNombreInstitucion()+"', TIPO_INSTITUCION='"+insitucion.getTipoInstitucion()+"',PAIS='"+insitucion.getPais()+"',PAGINA_WEB='"+insitucion.getPaginaWeb()+"',EMAIL='"+insitucion.getPaginaWeb()+"', INSTITUCION_ACTIVA="+insitucion.getInstitucionActiva()+" WHERE ID_INSTITUCION="+insitucion.getIdInstitucion()+";";
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
}

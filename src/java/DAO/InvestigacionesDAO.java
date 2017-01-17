/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

/**
 *
 * @author MauricioBC
 */
import POJO.Investigaciones;
import java.sql.ResultSet;
import java.util.ArrayList;
public class InvestigacionesDAO extends ConexionBD{
    
    //Permite consultar una investigacion por id
    public Investigaciones consultarPorId(int id) {
        Investigaciones temp = new Investigaciones();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_DETALLE_USUARIO, TITULO_INVESTIGACION, PUBLICADO FROM INVESTIGACIONES WHERE ID_INVESTIGACION = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_INVESTIGACION=id;      
                int ID_DETALLE_USUARIO=rs.getInt("ID_DETALLE_USUARIO");                        
                String TITULO_INVESTIGACION=rs.getString("TITULO_INVESTIGACION");
                int PUBLICADO=rs.getInt("PUBLICADO");
                
                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setIdInvestigacion(ID_INVESTIGACION);
                temp.setTituloInvestigacion(TITULO_INVESTIGACION);
                temp.setPublicado(PUBLICADO);
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<Investigaciones> consultarTodos() {
        ArrayList<Investigaciones> lista = new ArrayList<Investigaciones>();
        Investigaciones temp = new Investigaciones();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_INVESTIGACION,ID_DETALLE_USUARIO,TITULO_INVESTIGACION,PUBLICADO FROM INVESTIGACIONES;" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new Investigaciones();
                int ID_INVESTIGACION=rs.getInt("ID_INVESTIGACION");
                int ID_DETALLE_USUARIO=rs.getInt("ID_DETALLE_USUARIO");                        
                String TITULO_INVESTIGACION=rs.getString("TITULO_INVESTIGACION");
                int PUBLICADO=rs.getInt("PUBLICADO");
                
                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setIdInvestigacion(ID_INVESTIGACION);
                temp.setTituloInvestigacion(TITULO_INVESTIGACION);
                temp.setPublicado(PUBLICADO);
                
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
    //ingresar investigacion
    public boolean ingresar(Investigaciones investigaciones){
        boolean exito = false;        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO INVESTIGACIONES(ID_INVESTIGACION,ID_DETALLE_USUARIO,TITULO_INVESTIGACION,PUBLICADO) VALUES("+investigaciones.getIdInvestigacion()+", "+investigaciones.getIdDetalleUsuario()+", '"+investigaciones.getTituloInvestigacion()+"','"+investigaciones.getPublicado()+"');";
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
    
    //actualizar investigacion
    public boolean actualizar(Investigaciones investigaciones){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE INVESTIGACIONES SET ID_DETALLE_USUARIO="+investigaciones.getIdDetalleUsuario()+", TITULO_INVESTIGACION='"+investigaciones.getTituloInvestigacion()+"',PUBLICADO='"+investigaciones.getPublicado()+"' WHERE ID_INVESTIGACION="+investigaciones.getIdInvestigacion()+";";
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
    
    //comprobar si existe investigacion en la base
    public Integer ExisteInvestigacion(Integer idDetalleUsuario, String tituloProyecto, Integer publicado) {
         Integer idInvestigacion = 0;
        this.abrirConexion() ;
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_INVESTIGACION FROM INVESTIGACIONES where ID_DETALLE_USUARIO = " + idDetalleUsuario +" AND TITULO_INVESTIGACION= '" + tituloProyecto +"' AND PUBLICADO = " + publicado ;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                idInvestigacion = rs.getInt("ID_INVESTIGACION"); 
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        
        return idInvestigacion;
    }
    
    //Permite obtener el siguiente id de la Investigacion
     public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_INVESTIGACION), 0) AS X FROM INVESTIGACIONES";
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
     
     public ArrayList<Investigaciones> consultarPorIdDetalle(int id) {
        ArrayList<Investigaciones> investigacion = new ArrayList<Investigaciones>();        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_INVESTIGACION, ID_DETALLE_USUARIO, TITULO_INVESTIGACION, PUBLICADO FROM investigaciones WHERE ID_DETALLE_USUARIO = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {
                Investigaciones temp = new Investigaciones();
                int ID_INVESTIGACION = rs.getInt("ID_INVESTIGACION"); 
                int ID_DETALLE_USUARIO = rs.getInt("ID_DETALLE_USUARIO"); 
                String TITULO_INVESTIGACION = rs.getString("TITULO_INVESTIGACION");
                int PUBLICADO = rs.getInt("PUBLICADO");


                temp.setIdInvestigacion(ID_INVESTIGACION);
                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setTituloInvestigacion(TITULO_INVESTIGACION);
                temp.setPublicado(PUBLICADO);
                
                investigacion.add(temp);
            }
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }
        return investigacion;
    }
}

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
                Boolean PUBLICADO=rs.getBoolean("PUBLICADO");
                
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
                Boolean PUBLICADO=rs.getBoolean("PUBLICADO");
                
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
}

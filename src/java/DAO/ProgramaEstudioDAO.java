/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.ProgramaEstudio;
import POJO.SolicitudDeBeca;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author MauricioBC
 */
public class ProgramaEstudioDAO extends ConexionBD{
    public ProgramaEstudio consultarPorId(int id) {
        ProgramaEstudio temp = new ProgramaEstudio();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_SOLICITUD,SEMESTRE,PROGRAMA_ESTUDIO FROM PROGRAMA_ESTUDIO WHERE ID_PROGRAMA_ESTUDIO = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_PROGRAMA_ESTUDIO=id;      
                int ID_SOLICITUD=rs.getInt("ID_SOLICITUD");
                int SEMESTRE=rs.getInt("SEMESTRE");     
                String PROGRAMA_ESTUDIO=rs.getString("PROGRAMA_ESTUDIO");
                
               temp.setIdProgramaEstudio(ID_PROGRAMA_ESTUDIO);
               SolicitudDeBeca sol=new SolicitudDeBeca();
               sol.setIdSolicitud(ID_SOLICITUD);
               temp.setIdSolicitud(sol);
               temp.setSemestre(SEMESTRE);
               temp.setProgramaEstudio(PROGRAMA_ESTUDIO);
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<ProgramaEstudio> consultarTodos() {
        ArrayList<ProgramaEstudio> lista = new ArrayList<ProgramaEstudio>();
        ProgramaEstudio temp = new ProgramaEstudio();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_PROGRAMA_ESTUDIO,ID_SOLICITUD,SEMESTRE,PROGRAMA_ESTUDIO;" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new ProgramaEstudio();
                
               int ID_PROGRAMA_ESTUDIO=rs.getInt("ID_PROGRAMA_ESTUDIO");      
                int ID_SOLICITUD=rs.getInt("ID_SOLICITUD");
                int SEMESTRE=rs.getInt("SEMESTRE");     
                String PROGRAMA_ESTUDIO=rs.getString("PROGRAMA_ESTUDIO");
                
               temp.setIdProgramaEstudio(ID_PROGRAMA_ESTUDIO);
               SolicitudDeBeca sol=new SolicitudDeBeca();
               sol.setIdSolicitud(ID_SOLICITUD);
               temp.setIdSolicitud(sol);
               temp.setSemestre(SEMESTRE);
               temp.setProgramaEstudio(PROGRAMA_ESTUDIO);
                
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
    
    public boolean ingresar(ProgramaEstudio programaEstudio){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO PROGRAMA_ESTUDIO(ID_PROGRAMA_ESTUDIO,ID_SOLICITUD,SEMESTRE,PROGRAMA_ESTUDIO) VALUES("+programaEstudio.getIdProgramaEstudio()+", "+programaEstudio.getIdSolicitud()+", "+programaEstudio.getSemestre()+", '"+programaEstudio.getProgramaEstudio()+"');";
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
    
    public boolean actualizar(ProgramaEstudio programaEstudio){
        boolean exito = false;
        
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            
            String sql = "UPDATE PROGRAMA_ESTUDIO SET ID_SOLICITUD="+programaEstudio.getIdSolicitud()+", SEMESTRE="+programaEstudio.getSemestre()+", PROGRAMA_ESTUDIO='"+programaEstudio.getIdProgramaEstudio()+"' WHERE ID_PROGRAMA_ESTUDIO="+programaEstudio.getIdProgramaEstudio()+";";
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

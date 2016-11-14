/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import POJO.TipoDocumento;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author MauricioBC
 */
public class TipoDocumentoDAO extends ConexionBD{
     public TipoDocumento consultarPorId(int id) {
        TipoDocumento temp = new TipoDocumento();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT TIPO_DOCUMENTO, DEPARTAMENTO, DESCRIPCION FROM TIPO_DOCUMENTO where ID_TIPO_DOCUMENTO = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                String TIPO_DOCUMENTO=rs.getString("TIPO_DOCUMENTO");
                String DEPARTAMENTO=rs.getString("DEPARTAMENTO");
                String DESCRIPCION=rs.getString("DESCRIPCION");
                temp.setTipoDocumento(TIPO_DOCUMENTO);
                temp.setDepartamento(DEPARTAMENTO);
                temp.setDescripcion(DESCRIPCION);
            }

        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return temp;
    }
    
    //consultar todos
    public ArrayList<TipoDocumento> consultarTodos() {
        ArrayList<TipoDocumento> lista = new ArrayList<TipoDocumento>();
        TipoDocumento temp = new TipoDocumento();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_TIPO_DOCUMENTO, TIPO_DOCUMENTO, DEPARTAMENTO, DESCRIPCION FROM TIPO_DOCUMENTO;" ;
            ResultSet rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
                temp = new TipoDocumento();
                int ID_TIPO_DOCUMENTO=rs.getInt("ID_TIPO_DOCUMENTO");
                String TIPO_DOCUMENTO=rs.getString("TIPO_DOCUMENTO");
                String DEPARTAMENTO=rs.getString("DEPARTAMENTO");
                String DESCRIPCION=rs.getString("DESCRIPCION");
                temp.setIdTipoDocumento(ID_TIPO_DOCUMENTO);
                temp.setTipoDocumento(TIPO_DOCUMENTO);
                temp.setDepartamento(DEPARTAMENTO);
                temp.setDescripcion(DESCRIPCION);
                lista.add(temp);
            }
            
            this.cerrarConexion();
            
        } catch (Exception e) {
            System.out.println("Error: " + e);
        }

        return lista;
    }
   
}
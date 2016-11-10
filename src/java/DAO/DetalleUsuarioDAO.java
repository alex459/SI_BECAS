package DAO;

import POJO.DetalleUsuario;
import java.sql.ResultSet;
import java.sql.Date;
import java.util.ArrayList;

public class DetalleUsuarioDAO extends ConexionBD {

    //consultar por id
    public DetalleUsuario consultarPorId(int id) {
        DetalleUsuario temp = new DetalleUsuario();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT * FROM detalle_usuario where ID_DETALLE_USUARIO = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            while (rs.next()) {

                int ID_DETALLE_USUARIO = rs.getInt("ID_DETALLE_USUARIO");
                int ID_USUARIO = rs.getInt("ID_USUARIO");
                int ID_MUNICIPIO = rs.getInt("ID_MUNICIPIO");
                int ID_FACULTAD = rs.getInt("ID_FACULTAD");
                int ID_MUNICIPIO_NACIMIENTO = rs.getInt("ID_MUNICIPIO_NACIMIENTO");
                String NOMBRE1_DU = rs.getString("NOMBRE1_DU");
                String NOMBRE2_DU = rs.getString("NOMBRE2_DU");
                String APELLIDO1_DU = rs.getString("APELLIDO1_DU");
                String APELLIDO2_DU = rs.getString("APELLIDO2_DU");
                String DEPARTAMENTO = rs.getString("DEPARTAMENTO");
                Date FECHA_NACIMIENTO = rs.getDate("FECHA_NACIMIENTO");
                String PROFESION = rs.getString("PROFESION");
                String FECHA_CONTRATACION = rs.getString("FECHA_CONTRATACION");
                String TELEFONO_MOVIL = rs.getString("TELEFONO_MOVIL");
                String TELEFONO_CASA = rs.getString("TELEFONO_CASA");
                String TELEFONO_OFICINA = rs.getString("TELEFONO_OFICINA");

                temp.setIdDetalleUsuario(ID_DETALLE_USUARIO);
                temp.setIdUsuario(ID_USUARIO);
                temp.setIdMunicipio(ID_MUNICIPIO);
                temp.setIdFacultad(ID_FACULTAD);
                temp.setIdMunicipio(ID_MUNICIPIO);
                temp.setNombre1Du(NOMBRE1_DU);
                temp.setNombre2Du(NOMBRE2_DU);
                temp.setApellido1Du(APELLIDO1_DU);
                temp.setApellido2Du(APELLIDO2_DU);
                temp.setDepartamento(DEPARTAMENTO);
                temp.setFechaNacimiento(FECHA_NACIMIENTO);
                temp.setProfesion(PROFESION);
                temp.setFechaContratacion(FECHA_NACIMIENTO);
                temp.setTelefonoMovil(TELEFONO_MOVIL);
                temp.setTelefonoCasa(TELEFONO_CASA);
                temp.setTelefonoOficina(TELEFONO_OFICINA);

            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return temp;
    }
    
    public ArrayList<DetalleUsuario> consultarPorParametros(String nombre1, String nombre2, String apellido1, String apellido2, String carnet, Integer id_facultad, Integer id_tipo_de_usuario){
        ArrayList<DetalleUsuario> temp = new ArrayList<DetalleUsuario>();
        DetalleUsuario temp2 = new DetalleUsuario();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql1 = "SELECT * FROM DETALLE_USUARIO DU NATURAL JOIN USUARIO U WHERE DU.NOMBRE1_DU LIKE '%"+nombre1+"%' OR DU.NOMBRE2_DU LIKE '%"+nombre2+"%' OR DU.APELLIDO1_DU LIKE '%"+apellido1+"%' OR DU.APELLIDO2_DU LIKE '%"+apellido2+"%' OR DU.CARNET LIKE '%"+carnet+"%'";
            String sql2;
            String sql3;
            if(id_tipo_de_usuario==0){
                sql2 = "";
            }else{
                sql2 = " OR U.ID_TIPO_USUARIO = "+id_facultad+" ";
            }
            if(id_facultad==0){
                sql3 = "";
            }else{
                sql3 = " OR DU.ID_FACULTAD = "+id_facultad;
            }
            
            String sql = sql1.concat(sql2).concat(sql3);
            System.out.println("SENTENCIA SQL : "+sql);
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();

            /*while (rs.next()) {

                

            }*/

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return null;        
    }

    //obtener el siguiente id (autoincremental)
    public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_DETALLE_USUARIO), 0) AS X FROM DETALLE_USUARIO";
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

    public boolean ingresar(DetalleUsuario temp) {
        boolean exito = false;

        this.abrirConexion();
        try {
            stmt = conn.createStatement();

            String sql = "INSERT INTO DETALLE_USUARIO(ID_DETALLE_USUARIO, ID_USUARIO, ID_MUNICIPIO, ID_FACULTAD, ID_MUNICIPIO_NACIMIENTO, CARNET, NOMBRE1_DU, NOMBRE2_DU, APELLIDO1_DU, APELLIDO2_DU, DEPARTAMENTO, FECHA_NACIMIENTO, PROFESION, FECHA_CONTRATACION, TELEFONO_MOVIL, TELEFONO_CASA, TELEFONO_OFICINA) VALUES (" + temp.getIdDetalleUsuario() + "," + temp.getIdUsuario() + "," + temp.getIdMunicipio() + "," + temp.getIdFacultad() + "," + temp.getIdMunicipioNacimiento() + ",'" + temp.getCarnet() + "','" + temp.getNombre1Du() + "','" + temp.getNombre2Du() + "','" + temp.getApellido1Du() + "','" + temp.getApellido2Du() + "','" + temp.getDepartamento() + "','" + temp.getFechaNacimiento() + "','" + temp.getProfesion() + "','" + temp.getFechaContratacion() + "','" + temp.getTelefonoMovil() + "','" + temp.getTelefonoCasa() + "','" + temp.getTelefonoOficina() + "')";
            stmt.execute(sql);
            exito = true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }
        return exito;
    }
    
    //solo se usa en la pantalla de agregar_usuario.jsp
    public boolean ingresarOpcion2(DetalleUsuario temp) {
        boolean exito = false;

        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO DETALLE_USUARIO(ID_DETALLE_USUARIO, ID_USUARIO, ID_FACULTAD, CARNET, NOMBRE1_DU, NOMBRE2_DU, APELLIDO1_DU, APELLIDO2_DU) VALUES("+temp.getIdDetalleUsuario()+","+temp.getIdUsuario()+","+temp.getIdFacultad()+", '"+temp.getCarnet()+"', '"+temp.getNombre1Du()+"', '"+temp.getNombre2Du()+"', '"+temp.getApellido1Du()+"', '"+temp.getApellido2Du()+"')";
            stmt.execute(sql);
            exito = true;
            this.cerrarConexion();
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }
        return exito;
    }

}

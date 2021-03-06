package DAO;

import MODEL.Utilidades;
import MODEL.variablesDeSesion;
import POJO.TipoUsuario;
import POJO.Usuario;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class UsuarioDAO extends ConexionBD {

    //consultar por id
    public Usuario consultarPorId(int id) {
        Usuario usuario = new Usuario();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_USUARIO, ID_TIPO_USUARIO, NOMBRE_USUARIO, CLAVE FROM usuario where ID_USUARIO = " + id;
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                int ID_USUARIO = rs.getInt("ID_USUARIO");
                int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                String NOMBRE_USUARIO = rs.getString("NOMBRE_USUARIO");
                String CLAVE = rs.getString("CLAVE");
                usuario.setIdUsuario(ID_USUARIO);
                usuario.setIdTipoUsuario(ID_TIPO_USUARIO);
                usuario.setNombreUsuario(NOMBRE_USUARIO);
                usuario.setClave(CLAVE);
            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return usuario;
    }

    //obtener el siguiente id (autoincremental)
    public Integer getSiguienteId() {
        Integer siguienteId = -1;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT IFNULL(MAX(ID_USUARIO), 0) AS X FROM USUARIO";
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

    public boolean ingresar(Usuario usuario) {
        boolean exito = false;

        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "INSERT INTO USUARIO(ID_USUARIO, ID_TIPO_USUARIO, NOMBRE_USUARIO, CLAVE) VALUES(" + usuario.getIdUsuario() + ", " + usuario.getIdTipoUsuario() + ", '" + usuario.getNombreUsuario() + "', MD5('" + usuario.getClave() + "'))";
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

    public boolean login(String nombre, String clave) {
        boolean logeo = false;
        Usuario usuario = new Usuario();
        TipoUsuario tipoUsuario = new TipoUsuario();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_USUARIO, ID_TIPO_USUARIO, NOMBRE_USUARIO, CLAVE FROM usuario where NOMBRE_USUARIO = '" + nombre + "' AND CLAVE= MD5('" + clave + "')";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            if (rs.next()) {

                int ID_USUARIO = rs.getInt("ID_USUARIO");
                int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                String NOMBRE_USUARIO = rs.getString("NOMBRE_USUARIO");
                String CLAVE = rs.getString("CLAVE");

                usuario.setIdUsuario(ID_USUARIO);
                usuario.setIdTipoUsuario(ID_TIPO_USUARIO);
                usuario.setNombreUsuario(NOMBRE_USUARIO);
                usuario.setClave(CLAVE);
                logeo = true;
                Utilidades.nuevaBitacora(5, ID_USUARIO, "usuario logeado con id " + ID_USUARIO + " y nombre " + NOMBRE_USUARIO, sql);

            }

            if (logeo) {

                this.abrirConexion();
                stmt = conn.createStatement();
                sql = "SELECT ID_TIPO_USUARIO, TIPO_USUARIO, DESCRIPCION_TIPO_USUARIO FROM TIPO_USUARIO where ID_TIPO_USUARIO = " + usuario.getIdTipoUsuario();
                rs = stmt.executeQuery(sql);
                this.cerrarConexion();

                while (rs.next()) {

                    int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                    String TIPO_USUARIO = rs.getString("TIPO_USUARIO");
                    String DESCRIPCION_TIPO_USUARIO = rs.getString("DESCRIPCION_TIPO_USUARIO");

                    tipoUsuario.setIdTipoUsuario(ID_TIPO_USUARIO);
                    tipoUsuario.setTipoUsuario(TIPO_USUARIO);
                    tipoUsuario.setDescripcionTipoUsuario(DESCRIPCION_TIPO_USUARIO);
                }

                variablesDeSesion.usuarioActual.setIdUsuario(usuario.getIdUsuario());
                variablesDeSesion.usuarioActual.setNombreUsuario(usuario.getNombreUsuario());
                variablesDeSesion.usuarioActual.setClave(usuario.getClave());
                variablesDeSesion.usuarioActual.setIdTipoUsuario(usuario.getIdTipoUsuario());

                variablesDeSesion.tipoUsuarioActual.setIdTipoUsuario(tipoUsuario.getIdTipoUsuario());
                variablesDeSesion.tipoUsuarioActual.setTipoUsuario(tipoUsuario.getTipoUsuario());
                variablesDeSesion.tipoUsuarioActual.setDescripcionTipoUsuario(tipoUsuario.getDescripcionTipoUsuario());

            }

        } catch (Exception e) {
            System.out.println("Error : " + e);
        }
        return logeo;
    }

    public boolean login_ldap(String nombre) {
        boolean logeo = false;
        Usuario usuario = new Usuario();
        TipoUsuario tipoUsuario = new TipoUsuario();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_USUARIO, ID_TIPO_USUARIO, NOMBRE_USUARIO, CLAVE FROM usuario where NOMBRE_USUARIO = '" + nombre + "'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            if (rs.next()) {

                int ID_USUARIO = rs.getInt("ID_USUARIO");
                int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                String NOMBRE_USUARIO = rs.getString("NOMBRE_USUARIO");
                String CLAVE = rs.getString("CLAVE");

                usuario.setIdUsuario(ID_USUARIO);
                usuario.setIdTipoUsuario(ID_TIPO_USUARIO);
                usuario.setNombreUsuario(NOMBRE_USUARIO);
                usuario.setClave(CLAVE);
                logeo = true;
                Utilidades.nuevaBitacora(5, ID_USUARIO, "usuario logeado con id " + ID_USUARIO + " y nombre " + NOMBRE_USUARIO, sql);

            }

            if (logeo) {

                this.abrirConexion();
                stmt = conn.createStatement();
                sql = "SELECT ID_TIPO_USUARIO, TIPO_USUARIO, DESCRIPCION_TIPO_USUARIO FROM TIPO_USUARIO where ID_TIPO_USUARIO = " + usuario.getIdTipoUsuario();
                rs = stmt.executeQuery(sql);
                this.cerrarConexion();

                while (rs.next()) {

                    int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                    String TIPO_USUARIO = rs.getString("TIPO_USUARIO");
                    String DESCRIPCION_TIPO_USUARIO = rs.getString("DESCRIPCION_TIPO_USUARIO");

                    tipoUsuario.setIdTipoUsuario(ID_TIPO_USUARIO);
                    tipoUsuario.setTipoUsuario(TIPO_USUARIO);
                    tipoUsuario.setDescripcionTipoUsuario(DESCRIPCION_TIPO_USUARIO);
                }

                variablesDeSesion.usuarioActual.setIdUsuario(usuario.getIdUsuario());
                variablesDeSesion.usuarioActual.setNombreUsuario(usuario.getNombreUsuario());
                variablesDeSesion.usuarioActual.setClave(usuario.getClave());
                variablesDeSesion.usuarioActual.setIdTipoUsuario(usuario.getIdTipoUsuario());

                variablesDeSesion.tipoUsuarioActual.setIdTipoUsuario(tipoUsuario.getIdTipoUsuario());
                variablesDeSesion.tipoUsuarioActual.setTipoUsuario(tipoUsuario.getTipoUsuario());
                variablesDeSesion.tipoUsuarioActual.setDescripcionTipoUsuario(tipoUsuario.getDescripcionTipoUsuario());

            }

        } catch (Exception e) {
            System.out.println("Error : " + e);
        }
        return logeo;
    }

    public boolean actualizar(Usuario usuario) {
        boolean exito = false;

        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = new String();
            if (usuario.getClave().length() > 0) {
                sql = "UPDATE USUARIO SET ID_TIPO_USUARIO = " + usuario.getIdTipoUsuario() + ", NOMBRE_USUARIO = '" + usuario.getNombreUsuario() + "', CLAVE =MD5('" + usuario.getClave() + "') WHERE ID_USUARIO = " + usuario.getIdUsuario();
            } else {
                sql = "UPDATE USUARIO SET ID_TIPO_USUARIO = " + usuario.getIdTipoUsuario() + ", NOMBRE_USUARIO = '" + usuario.getNombreUsuario() + "' WHERE ID_USUARIO = " + usuario.getIdUsuario();
            }
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

    //cambia el rol del usuario a inactivo
    public boolean darDeBajaUsuario(Usuario usuario, Integer id_user_login) {

        boolean exito = false;

        boolean validacion = false;
        validacion = this.validarParaDarDeBaja(usuario);

        if (validacion) {
            usuario.setIdTipoUsuario(10); //pasa a ser inactivo
            this.abrirConexion();
            try {
                stmt = conn.createStatement();
                String sql = "UPDATE USUARIO SET ID_TIPO_USUARIO = " + usuario.getIdTipoUsuario() + " WHERE ID_USUARIO = '" + usuario.getIdUsuario() + "'";
                stmt.execute(sql);
                exito = true;
                this.cerrarConexion();
            } catch (Exception e) {
                System.out.println("Error " + e);
            } finally {
                this.cerrarConexion();
            }
        } else {
            exito = false;
        }
        return exito;
    }

    public boolean validarParaDarDeBaja(Usuario usuario) {
        boolean respuesta = true;

        //validando que no sea becario.
        this.abrirConexion();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT * FROM usuario where ID_USUARIO = '" + usuario.getIdUsuario() + " AND ID_TIPO_USUARIO NOT IN (2)'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                respuesta = false;
            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }

        //validando que no sea un candidato con expediente abierto.
        ExpedienteDAO expDao = new ExpedienteDAO();
        respuesta = !expDao.expedienteAbierto(usuario.getNombreUsuario());

        //validando que si es administrador entonces que almenos exista otro administrador.
        boolean admin = false;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT * FROM usuario where ID_USUARIO = '" + usuario.getIdUsuario() + " AND ID_TIPO_USUARIO IN (9)'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                //si es administrador
                admin = true;
            }

            int N_ADMIN = 1;
            if (admin) {
                stmt = conn.createStatement();
                String sql2 = "SELECT count(*) as N_ADMIN FROM usuario where ID_TIPO_USUARIO IN (9)'";
                ResultSet rs2 = stmt.executeQuery(sql);
                this.cerrarConexion();

                while (rs.next()) {
                    //verificando que sean mas de 1 administrador
                    N_ADMIN = rs.getInt("N_ADMIN");
                }
            }

            if (N_ADMIN == 1) {
                respuesta = false;
            }
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }

        //validando que si usuario del consejo de becas entonces que almenos exista otro usuario del consejo de becas.
        boolean cbic = false;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT * FROM usuario where ID_USUARIO = '" + usuario.getIdUsuario() + " AND ID_TIPO_USUARIO IN (8)'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                //si es usuario del consejo de becas
                cbic = true;
            }

            int N_CBIC = 1;
            if (admin) {
                stmt = conn.createStatement();
                String sql2 = "SELECT count(*) as N_CBIC FROM usuario where ID_TIPO_USUARIO IN (8)'";
                ResultSet rs2 = stmt.executeQuery(sql);
                this.cerrarConexion();

                while (rs.next()) {
                    //verificando que sean mas de 1 usuario de consejo de becas
                    N_CBIC = rs.getInt("N_CBIC");
                }
            }

            if (N_CBIC == 1) {
                respuesta = false;
            }
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }

        return respuesta;
    }

    public Usuario consultarPorNombreUsuario(String nombre_usuario) {
        Usuario usuario = new Usuario();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_USUARIO, ID_TIPO_USUARIO, NOMBRE_USUARIO, CLAVE FROM usuario where NOMBRE_USUARIO = '" + nombre_usuario + "'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                int ID_USUARIO = rs.getInt("ID_USUARIO");
                int ID_TIPO_USUARIO = rs.getInt("ID_TIPO_USUARIO");
                String NOMBRE_USUARIO = rs.getString("NOMBRE_USUARIO");
                String CLAVE = rs.getString("CLAVE");
                usuario.setIdUsuario(ID_USUARIO);
                usuario.setIdTipoUsuario(ID_TIPO_USUARIO);
                usuario.setNombreUsuario(NOMBRE_USUARIO);
                usuario.setClave(CLAVE);
            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return usuario;
    }

    //sirve para detectar si el nombre de usuario ya esta repetido en la base de datos.
    public boolean nombreDeUsuarioRepetido(String nombre_usuario) {
        boolean respuesta = true;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT NOMBRE_USUARIO FROM usuario where NOMBRE_USUARIO = '" + nombre_usuario + "'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                respuesta = false;
                break;
            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }
        return respuesta;
    }

    public Integer obtenerIdUsuario(String nombre_usuario) {
        Integer idUsuario = 0;
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT ID_USUARIO FROM usuario where NOMBRE_USUARIO = '" + nombre_usuario + "'";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                idUsuario = rs.getInt("ID_USUARIO");

            }

        } catch (Exception e) {
            System.out.println("Error " + e);
        }

        return idUsuario;
    }

    public boolean actualizarRolPorIdUsuario(int id, int idRol) {
        boolean exito = false;

        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "UPDATE USUARIO SET ID_TIPO_USUARIO = " + idRol + " WHERE ID_USUARIO = " + id;
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

    //consultar todos los correos de los usuarios
    public ArrayList<String> consultarTodosLosCorreos() {
        ArrayList<String> lista = new ArrayList<String>();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT EMAIL FROM USUARIO, DETALLE_USUARIO WHERE USUARIO.ID_USUARIO = DETALLE_USUARIO.ID_USUARIO";
            ResultSet rs = stmt.executeQuery(sql);
            this.cerrarConexion();
            while (rs.next()) {
                String email = rs.getString("EMAIL");
                lista.add(email);
            }
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }

        return lista;
    }

    public ArrayList<String> consultarCorreosPorID(Integer[] userID) {
        ArrayList<String> lista = new ArrayList<String>();
        this.abrirConexion();
        try {
            stmt = conn.createStatement();
            String sql = "SELECT EMAIL FROM USUARIO, DETALLE_USUARIO WHERE USUARIO.ID_USUARIO = DETALLE_USUARIO.ID_USUARIO AND USUARIO.ID_USUARIO IN (";
            for (int i = 0; i < userID.length; i++) {
                sql = sql + userID[i] + ",";
            }
            String newSQL = sql.substring(0, sql.length() - 1) + ")";

            ResultSet rs = stmt.executeQuery(newSQL);
            this.cerrarConexion();
            while (rs.next()) {
                String email = rs.getString("EMAIL");
                lista.add(email);
            }
        } catch (Exception e) {
            System.out.println("Error " + e);
        } finally {
            this.cerrarConexion();
        }

        return lista;
    }
}

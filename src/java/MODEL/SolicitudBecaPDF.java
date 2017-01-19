/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.ConexionBD;
import DAO.DepartamentoDAO;
import DAO.MunicipioDAO;
import POJO.Departamento;
import POJO.Municipio;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "SolicitudBecaPDF", urlPatterns = {"/SolicitudBecaPDF"})
@MultipartConfig(maxFileSize = 16177215)
public class SolicitudBecaPDF extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8"); //lineas importantes para leer tildes y ñ
        request.setCharacterEncoding("UTF-8"); //lineas importantes para leer tildes y ñ

        try {
            //pojos y daos
            DepartamentoDAO departamentoDao = new DepartamentoDAO();
            MunicipioDAO municipioDao = new MunicipioDAO();

            //leyendo parametros del jsp
            String nombre1 = request.getParameter("nombre1");
            String nombre2 = request.getParameter("nombre2");
            String apellido1 = request.getParameter("apellido1");
            String apellido2 = request.getParameter("apellido2");
            String fechaNacimiento = request.getParameter("fechaNacimiento");
            String departamentoN = request.getParameter("departamentoNacimiento");
            String municipioN = request.getParameter("municipioNacimiento");
            String departamentoNacimiento = departamentoDao.consultarNombrePorId(Integer.parseInt(departamentoN));
            String municipioNacimiento = municipioDao.consultarNombrePorId(Integer.parseInt(municipioN));
            String genero = request.getParameter("genero");
            String direccion = request.getParameter("direccion");
            String departamentoD = request.getParameter("departamentoDireccion");
            String municipioD = request.getParameter("municipioDireccion");
            String departamentoDireccion = departamentoDao.consultarNombrePorId(Integer.parseInt(departamentoD));
            String municipioDireccion = municipioDao.consultarNombrePorId(Integer.parseInt(municipioD));
            String telCasa = request.getParameter("telCasa");
            String telMovil = request.getParameter("telMovil");
            String telOficina = request.getParameter("telOficina");
            //Falta calcular la edad
            String edad = "100";

            String profesion = request.getParameter("profesion");
            String cargo = request.getParameter("cargo");
            String unidad = request.getParameter("unidad");
            String facultad = request.getParameter("facultad");
            String fechaContratacion = request.getParameter("fechaContratacion");
            //calcular tiempo de servicio
            String tiempoServicio = "";
 
            boolean checkProyecto = Boolean.parseBoolean(request.getParameter("checkProyecto"));
            boolean checkAsociacion = Boolean.parseBoolean(request.getParameter("checkAsociacion"));
            Integer nEducacion = Integer.parseInt(request.getParameter("nEducacion"));
            Integer nInvestigacion = 0;
            Integer nIdioma = Integer.parseInt(request.getParameter("nIdioma"));
            Integer nAsociacion = 0;
            Integer nCargos = Integer.parseInt(request.getParameter("nCargos"));
            Integer nPrograma = Integer.parseInt(request.getParameter("nPrograma"));
            if (checkProyecto == false) {
                nInvestigacion = Integer.parseInt(request.getParameter("nInvestigacion"));
            } else {
            }
            if (checkAsociacion == false) {
                nAsociacion = Integer.parseInt(request.getParameter("nAsociacion"));
            } else {
            }

            //Listas
            List<String> ListaTipoEducacion = new ArrayList<>();
            List<String> ListaGrado = new ArrayList<>();
            List<String> ListaInstitucionEducacion = new ArrayList<>();
            List<String> ListaAnyoEducacion = new ArrayList<>();
            List<String> ListaTituloProyecto = new ArrayList<>();
            List<String> ListaPublicado = new ArrayList<>();
            List<String> ListaNombreAsociacion = new ArrayList<>();
            List<String> ListaIdioma = new ArrayList<>();
            List<String> ListaNivelHabla = new ArrayList<>();
            List<String> ListaNivelLectura = new ArrayList<>();
            List<String> ListaNivelEscritura = new ArrayList<>();
            List<String> ListaLugarCargo = new ArrayList<>();
            List<String> ListaCargoAnterior = new ArrayList<>();
            List<String> ListaFechaInicioCargo = new ArrayList<>();
            List<String> ListaFechaFinCargo = new ArrayList<>();
            List<String> ListaResponsabilidad = new ArrayList<>();
            List<String> ListaSemestre = new ArrayList<>();
            List<String> ListaProgramaEstudio = new ArrayList<>();
            List<String> ListaBecasAnteriores = new ArrayList<>();

            if (nEducacion > 0) {
                for (int i = 1; i < nEducacion + 1; i++) {
                    String vartipoEducacion = "tipoEducacion" + i;
                    String vargrado = "grado" + i;
                    String varinstitucion = "institucion" + i;
                    String varanyo = "anyo" + i;
                    //Recuperando informacion
                    String tipoEducacion = request.getParameter(vartipoEducacion);
                    String grado = request.getParameter(vargrado);
                    String institucion = request.getParameter(varinstitucion);
                    String anyo = request.getParameter(varanyo);
                    //Agregando a Lista
                    ListaTipoEducacion.add(tipoEducacion);
                    ListaGrado.add(grado);
                    ListaInstitucionEducacion.add(institucion);
                    ListaAnyoEducacion.add(anyo);
                }
            }

            if (nInvestigacion > 0) {
                for (int i = 1; i < nInvestigacion + 1; i++) {
                    String vartitulo = "tituloProyecto" + i;
                    String varpublicado = "publicado" + i;
                    //Recuperando informacion
                    String tituloProyecto = request.getParameter(vartitulo);
                    String publicado = request.getParameter(varpublicado);
                    //Agregando a Lista
                    ListaTituloProyecto.add(tituloProyecto);
                    ListaPublicado.add(publicado);
                }
            }

            if (nAsociacion > 0) {
                for (int i = 1; i < nAsociacion + 1; i++) {
                    String varasociacion = "asociacion" + i;
                    //Recuperando informacion
                    String nombreAsociacion = request.getParameter(varasociacion);
                    //Agregando a Lista
                    ListaNombreAsociacion.add(nombreAsociacion);
                }
            }

            if (nIdioma > 0) {
                for (int i = 1; i < nIdioma + 1; i++) {
                    String varidioma = "idioma" + i;
                    String varnivelHabla = "nivelHabla" + i;
                    String varnivelEscritura = "nivelEscritura" + i;
                    String varnivelLectura = "nivelLectura" + i;
                    //Recuperando informacion
                    String idioma = request.getParameter(varidioma);
                    String nivelHabla = request.getParameter(varnivelHabla);
                    String nivelEscritura = request.getParameter(varnivelEscritura);
                    String nivelLectura = request.getParameter(varnivelLectura);
                    //Agregando a Lista
                    ListaIdioma.add(idioma);
                    ListaNivelHabla.add(nivelHabla);
                    ListaNivelEscritura.add(nivelEscritura);
                    ListaNivelLectura.add(nivelLectura);
                }
            }

            if (nCargos > 0) {
                for (int i = 1; i < nCargos + 1; i++) {
                    String varlugar = "lugarCargo" + i;
                    String varcargo = "cargoAnterior" + i;
                    String varfechaInicio = "fechaInicioCargo" + i;
                    String varfechaFin = "fechaFinCargo" + i;
                    String varresponsabilidades = "responsabilidad" + i;
                    //Recuperando informacion
                    String lugarCargo = request.getParameter(varlugar);
                    String cargoAnterior = request.getParameter(varcargo);
                    String fechaInicioCargo = request.getParameter(varfechaInicio);
                    String fechaFinCargo = request.getParameter(varfechaFin);
                    String responsabilidad = request.getParameter(varresponsabilidades);
                    //Agregando a Lista
                    ListaLugarCargo.add(lugarCargo);
                    ListaCargoAnterior.add(cargoAnterior);
                    ListaFechaInicioCargo.add(fechaInicioCargo);
                    ListaFechaFinCargo.add(fechaFinCargo);
                    ListaResponsabilidad.add(responsabilidad);
                }
            }

            if (nPrograma > 0) {
                for (int i = 1; i < nPrograma + 1; i++) {
                    String varsemestre = "semestre" + i;
                    String varprograma = "programa" + i;
                    //Recuperando informacion
                    String semestre = request.getParameter(varsemestre);
                    String programaEstudio = request.getParameter(varprograma);
                    //Agregando a Lista
                    ListaSemestre.add(semestre);
                    ListaProgramaEstudio.add(programaEstudio);
                }
            }
            String beneficios = request.getParameter("beneficios");

            //Falta obtener Becas Anteriores ListaBecasAnteriores
            
            String nombre1R1 = request.getParameter("nombre1R1");
            String nombre2R1 = request.getParameter("nombre2R1");
            String apellido1R1 = request.getParameter("apellido1R1");
            String apellido2R1 = request.getParameter("apellido2R1");
            String domicilioR1 = request.getParameter("direccionR1");
            Integer idMunicipioR1 = Integer.parseInt(request.getParameter("municipioR1"));
            Integer idDepartamentoR1 = Integer.parseInt(request.getParameter("departamentoR1"));
            String departamentoR1 = departamentoDao.consultarNombrePorId(idDepartamentoR1);
            String municipioR1 = municipioDao.consultarNombrePorId(idMunicipioR1);
            String telR1 = request.getParameter("telefonoR1");
            
            String nombre1R2 = request.getParameter("nombre1R2");
            String nombre2R2 = request.getParameter("nombre2R2");
            String apellido1R2 = request.getParameter("apellido1R2");
            String apellido2R2 = request.getParameter("apellido2R2");
            String domicilioR2 = request.getParameter("direccionR2");
            Integer idMunicipioR2 = Integer.parseInt(request.getParameter("municipioR2"));
            Integer idDepartamentoR2 = Integer.parseInt(request.getParameter("departamentoR2"));
            String departamentoR2 = departamentoDao.consultarNombrePorId(idDepartamentoR2);
            String municipioR2 = municipioDao.consultarNombrePorId(idMunicipioR2);
            String telR2 = request.getParameter("telefonoR2");
            
            String nombre1R3 = request.getParameter("nombre1R3");
            String nombre2R3 = request.getParameter("nombre2R3");
            String apellido1R3 = request.getParameter("apellido1R3");
            String apellido2R3 = request.getParameter("apellido2R3");
            String domicilioR3 = request.getParameter("direccionR3");
            Integer idMunicipioR3 = Integer.parseInt(request.getParameter("municipioR3"));
            Integer idDepartamentoR3 = Integer.parseInt(request.getParameter("departamentoR3"));
            String departamentoR3 = departamentoDao.consultarNombrePorId(idDepartamentoR3);
            String municipioR3 = municipioDao.consultarNombrePorId(idMunicipioR3);
            String telR3 = request.getParameter("telefonoR3");

            //preparando parametros para el reporte
            Map parametersMap = new HashMap();
            parametersMap.put("nombre1", nombre1);
            parametersMap.put("nombre2", nombre2);
            parametersMap.put("apellido1", apellido1);
            parametersMap.put("apellido2", apellido2);
            parametersMap.put("fechaNacimiento", fechaNacimiento);
            parametersMap.put("departamentoNacimiento", departamentoNacimiento);
            parametersMap.put("municipioNacimiento", municipioNacimiento);
            parametersMap.put("genero", genero);
            parametersMap.put("direccion", direccion);
            parametersMap.put("departamentoDireccion", departamentoDireccion);
            parametersMap.put("municipioDireccion", municipioDireccion);
            parametersMap.put("telCasa", telCasa);
            parametersMap.put("telMovil", telMovil);
            parametersMap.put("telOficina", telOficina);
            parametersMap.put("edad", edad);
            parametersMap.put("profesion", profesion);
            parametersMap.put("cargo", cargo);
            parametersMap.put("unidad", unidad);
            parametersMap.put("facultad", facultad);
            parametersMap.put("tiempoServicio", tiempoServicio);
            parametersMap.put("ListaTipoEducacion", ListaTipoEducacion);
            parametersMap.put("ListaGrado", ListaGrado);
            parametersMap.put("ListaInstitucionEducacion", ListaInstitucionEducacion);
            parametersMap.put("ListaAnyoEducacion", ListaAnyoEducacion);
            parametersMap.put("ListaTituloProyecto", ListaTituloProyecto);
            parametersMap.put("ListaPublicado", ListaPublicado);
            parametersMap.put("ListaNombreAsociacion", ListaNombreAsociacion);

            parametersMap.put("ListaIdioma", ListaIdioma);
            parametersMap.put("ListaNivelHabla", ListaNivelHabla);
            parametersMap.put("ListaNivelEscritura", ListaNivelEscritura);
            parametersMap.put("ListaNivelLectura", ListaNivelLectura);
            parametersMap.put("ListaLugarCargo", ListaLugarCargo);
            parametersMap.put("ListaCargoAnterior", ListaCargoAnterior);
            parametersMap.put("ListaFechaInicioCargo", ListaFechaInicioCargo);
            parametersMap.put("ListaFechaFinCargo", ListaFechaFinCargo);
            parametersMap.put("ListaResponsabilidad", ListaResponsabilidad);
            parametersMap.put("ListaSemestre", ListaSemestre);
            parametersMap.put("ListaProgramaEstudio", ListaProgramaEstudio);
            parametersMap.put("beneficios", beneficios);
            parametersMap.put("ListaBecasAnteriores", ListaBecasAnteriores);
            parametersMap.put("nombre1R1", nombre1R1);
            parametersMap.put("nombre2R1", nombre2R1);
            parametersMap.put("apellido1R1", apellido1R1);
            parametersMap.put("apellido2R1", apellido2R1);
            parametersMap.put("domicilioR1", domicilioR1);
            parametersMap.put("departamentoR1", departamentoR1);
            parametersMap.put("municipioR1", municipioR1);
            parametersMap.put("telR1", telR1);
            parametersMap.put("nombre1R2", nombre1R2);
            parametersMap.put("nombre2R2", nombre2R2);
            parametersMap.put("apellido1R2", apellido1R2);
            parametersMap.put("apellido2R2", apellido2R2);
            parametersMap.put("domicilioR2", domicilioR2);
            parametersMap.put("departamentoR2", departamentoR2);
            parametersMap.put("municipioR2", municipioR2);
            parametersMap.put("telR2", telR2);
            parametersMap.put("nombre1R3", nombre1R3);
            parametersMap.put("nombre2R3", nombre2R3);
            parametersMap.put("apellido1R3", apellido1R3);
            parametersMap.put("apellido2R3", apellido2R3);
            parametersMap.put("domicilioR3", domicilioR3);
            parametersMap.put("departamentoR3", departamentoR3);
            parametersMap.put("municipioR3", municipioR3);
            parametersMap.put("telR3", telR3);

            ConexionBD conexionBD = new ConexionBD();
            conexionBD.abrirConexion();
            String path = getServletContext().getRealPath("/REPORTES/");
            byte[] bytes = JasperRunManager.runReportToPdf(path + "/308_Solicitud_Beca_PDF.jasper", parametersMap, conexionBD.conn);
            conexionBD.cerrarConexion();
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outputstream = response.getOutputStream();
            outputstream.write(bytes, 0, bytes.length);
            outputstream.flush();
            outputstream.close();

        } catch (Exception ex) {
            ex.printStackTrace();
            System.out.println("Error: " + ex);
        }
    }

    public Date StringAFecha(String Sfecha) {
        SimpleDateFormat formatoDelTexto = new SimpleDateFormat("yyyy-MM-dd");
        Date fecha = null;
        try {
            fecha = formatoDelTexto.parse(Sfecha);
        } catch (ParseException ex) {

            ex.printStackTrace();

        }
        System.out.println("fechanice!");
        return fecha;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

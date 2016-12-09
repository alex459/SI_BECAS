/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.CargoDAO;
import DAO.DetalleUsuarioDAO;
import DAO.EducacionDao;
import POJO.Cargo;
import POJO.DetalleUsuario;
import POJO.Educacion;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "SolicitarBecaServlet", urlPatterns = {"/SolicitarBecaServlet"})
public class SolicitarBecaServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");

        boolean exitoValores = false;
        boolean exitoDetalle = false;
        boolean exitoActDetalle = false;
        try {
            String user = request.getParameter("user");
            //Pantalla 308
            String nombre1 = request.getParameter("nombre1");
            String nombre2 = request.getParameter("nombre2");
            String apellido1 = request.getParameter("apellido1");
            String apellido2 = request.getParameter("apellido2");
            //
            String fechaNacimiento = request.getParameter("fechaNacimiento");
            //String departamentoNacimiento = request.getParameter("departamentoNacimiento");
            Integer municipioNacimiento = Integer.parseInt(request.getParameter("municipioNacimiento"));
            String genero = request.getParameter("genero");
            String direccion = request.getParameter("direccion");
            //String departamentoDireccion = request.getParameter("departamentoDireccion");
            Integer municipioDireccion = Integer.parseInt(request.getParameter("municipioDireccion"));
            String telCasa = request.getParameter("telCasa");
            String telMovil = request.getParameter("telMovil");
            String telOficina = request.getParameter("telOficina");
            //Pantalla 309
            String profesion = request.getParameter("profesion");
            String cargo = request.getParameter("cargo");
            String unidad = request.getParameter("unidad");
            //
            String fechaContratacion = request.getParameter("fechaContratacion");
            
            //Pantalla 310
            Integer nEducacion = Integer.parseInt(request.getParameter("nEducacion")) + 1;
            

            exitoValores = true;

            if (exitoValores == true) {
            //Actualizando Detalle Usuario

                //Obtener el detalle del Usuario
                DetalleUsuario detalleUsuario = new DetalleUsuario();
                DetalleUsuarioDAO detUsDao = new DetalleUsuarioDAO();
                try {
                    detalleUsuario = detUsDao.consultarPorUser(user);
                    exitoDetalle = true;
                    
                    if(exitoDetalle == true){
                        detalleUsuario.setNombre1Du(nombre1);
                        detalleUsuario.setNombre2Du(nombre2);
                        detalleUsuario.setApellido1Du(apellido1);
                        detalleUsuario.setApellido2Du(apellido2);
                        //detalleUsuario.setFechaNacimiento(fechaNacimiento);
                        detalleUsuario.setIdMunicipioNacimiento(municipioNacimiento);
                        detalleUsuario.setGenero(genero);
                        detalleUsuario.setDireccion(direccion);
                        detalleUsuario.setIdMunicipio(municipioDireccion);
                        detalleUsuario.setTelefonoCasa(telCasa);
                        detalleUsuario.setTelefonoMovil(telMovil);
                        detalleUsuario.setTelefonoOficina(telOficina);
                        //detalleUsuario.setFechaContratacion(fechaContratacion);
                        detalleUsuario.setDepartamento(unidad);
                        detalleUsuario.setProfesion(profesion);
                        
                        exitoActDetalle = detUsDao.actualizarDetalleSolicitud(detalleUsuario);
                        
                        //Actualizar Cargo Actual
                        CargoDAO carDao = new CargoDAO();
                        Cargo cargoActual = carDao.obtenerCargoActual(user);
                        
                        if(cargoActual.getIdCargo() ==null){
                            //insertar Cargo Actual
                            cargoActual.setIdCargo(carDao.getSiguienteId());
                            cargoActual.setIdDetalleUsuario(detalleUsuario.getIdDetalleUsuario());
                            cargoActual.setNombreCargo(cargo);
                            carDao.ingresarCargoActual(cargoActual);
                        }else{
                            //actualizar Cargo Actual
                            cargoActual.setNombreCargo(cargo);
                            carDao.actualizarCargoActual(cargoActual);
                        }
                        
                        //Insertar o Actualizar Educacion
                        if(nEducacion >0){
                            EducacionDao eduDao = new EducacionDao();
                            for (int i = 1; i < nEducacion+1; i++) {
                                String vartipoEducacion = "tipoEducacion" +i;
                                String vargrado= "grado" +i;
                                String varinstitucion= "institucion" +i;
                                String varanyo= "anyo" +i;
                                Educacion educacion = new Educacion();
                                //Recuperando informacion
                                String tipoEducacion= request.getParameter(vartipoEducacion);
                                String grado = request.getParameter(vargrado);
                                String institucion = request.getParameter(varinstitucion);
                                Integer anyo= Integer.parseInt(request.getParameter(varanyo));
                                //Comparando con la base
                                Integer idEducacion = eduDao.ExisteEducacion(tipoEducacion, grado, institucion, anyo, detalleUsuario.getIdDetalleUsuario());
                            }
                            
                        }else{}
                        
                    }else{}
                } catch (Exception e) {
                    //Mensaje de error de detalle usuario
                }
            } else {
            }

        } catch (Exception e) {
            //Mensaje de Error de lectura de Datos
        }

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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import DAO.AsociacionesDAO;
import DAO.CargoDAO;
import DAO.DetalleUsuarioDAO;
import DAO.DocumentoDAO;
import DAO.EducacionDao;
import DAO.ExpedienteDAO;
import DAO.IdiomaDAO;
import DAO.InvestigacionesDAO;
import DAO.ProgramaEstudioDAO;
import DAO.ReferenciasDAO;
import DAO.SolocitudBecaDAO;
import DAO.TipoDocumentoDAO;
import DAO.UsuarioDAO;
import POJO.Asociaciones;

import POJO.Cargo;
import POJO.DetalleUsuario;
import POJO.Documento;
import POJO.Educacion;
import POJO.Expediente;
import POJO.Idioma;
import POJO.Investigaciones;
import POJO.ProgramaEstudio;
import POJO.Referencias;
import POJO.SolicitudDeBeca;
import POJO.TipoDocumento;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "EditarSolicitudBecaServlet", urlPatterns = {"/EditarSolicitudBecaServlet"})
@MultipartConfig(maxFileSize = 16177215)
public class EditarSolicitudBecaServlet extends HttpServlet {

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
        boolean solicitudHecha = false;
        try {
            String user = request.getParameter("user");
            //Pantalla 308
            String nombre1 = request.getParameter("nombre1");
            String nombre2 = request.getParameter("nombre2");
            String apellido1 = request.getParameter("apellido1");
            String apellido2 = request.getParameter("apellido2");
            java.sql.Date fechaNacimiento = new java.sql.Date(StringAFecha(request.getParameter("fechaNacimiento")).getTime());
            //String fechaNacimiento = request.getParameter("fechaNacimiento");
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
            java.sql.Date fechaContratacion = new java.sql.Date(StringAFecha(request.getParameter("fechaContratacion")).getTime());
            //String fechaContratacion = request.getParameter("fechaContratacion");

            boolean checkProyecto = Boolean.parseBoolean(request.getParameter("checkProyecto"));
            boolean checkAsociacion = Boolean.parseBoolean(request.getParameter("checkAsociacion"));
            Integer nEducacion = Integer.parseInt(request.getParameter("nEducacion"));
            Integer nInvestigacion = 0;
            Integer nIdioma = Integer.parseInt(request.getParameter("nAsociacion"));
            Integer nAsociacion = 0;
            Integer nCargos = Integer.parseInt(request.getParameter("nCargos"));
            Integer nPrograma = Integer.parseInt(request.getParameter("nPrograma"));
            if(checkProyecto == false){
                nInvestigacion = Integer.parseInt(request.getParameter("nInvestigacion"));
            }else{}
            if(checkAsociacion == false){
                nAsociacion = Integer.parseInt(request.getParameter("nAsociacion"));
            }else{}

            //obteniendo solicitud y expediente
            ExpedienteDAO expDao = new ExpedienteDAO();
            Expediente exp = expDao.obtenerExpedienteAbierto(user);
            UsuarioDAO usDao = new UsuarioDAO();
            Integer idUsuario = usDao.obtenerIdUsuario(user);
            SolocitudBecaDAO solicitudBecaDao = new SolocitudBecaDAO();
            SolicitudDeBeca solicitud = solicitudBecaDao.consultarPorExpedienteUsuario(exp.getIdExpediente(), idUsuario);

            exitoValores = true;

            if (exitoValores == true) {
                //Actualizando Detalle Usuario

                //Obtener el detalle del Usuario
                DetalleUsuario detalleUsuario = new DetalleUsuario();
                DetalleUsuarioDAO detUsDao = new DetalleUsuarioDAO();
                try {
                    detalleUsuario = detUsDao.consultarPorUser(user);
                    exitoDetalle = true;

                    if (exitoDetalle == true) {
                        detalleUsuario.setNombre1Du(nombre1);
                        detalleUsuario.setNombre2Du(nombre2);
                        detalleUsuario.setApellido1Du(apellido1);
                        detalleUsuario.setApellido2Du(apellido2);
                        detalleUsuario.setFechaNacimiento(fechaNacimiento);
                        detalleUsuario.setIdMunicipioNacimiento(municipioNacimiento);
                        detalleUsuario.setGenero(genero);
                        detalleUsuario.setDireccion(direccion);
                        detalleUsuario.setIdMunicipio(municipioDireccion);
                        detalleUsuario.setTelefonoCasa(telCasa);
                        detalleUsuario.setTelefonoMovil(telMovil);
                        detalleUsuario.setTelefonoOficina(telOficina);
                        detalleUsuario.setFechaContratacion(fechaContratacion);
                        detalleUsuario.setDepartamento(unidad);
                        detalleUsuario.setProfesion(profesion);

                        exitoActDetalle = detUsDao.actualizarDetalleSolicitud(detalleUsuario);

                        //Actualizar Cargo Actual
                        CargoDAO carDao = new CargoDAO();
                        Cargo cargoActual = carDao.obtenerCargoActual(user);

                        if (cargoActual.getIdCargo() == null) {
                            //insertar Cargo Actual
                            cargoActual.setIdCargo(carDao.getSiguienteId());
                            cargoActual.setIdDetalleUsuario(detalleUsuario.getIdDetalleUsuario());
                            cargoActual.setNombreCargo(cargo);
                            carDao.ingresarCargoActual(cargoActual);
                        } else {
                            //actualizar Cargo Actual
                            cargoActual.setNombreCargo(cargo);
                            carDao.actualizarCargoActual(cargoActual);
                        }

                        //Insertar o Actualizar Educacion
                        if (nEducacion > 0) {
                            EducacionDao eduDao = new EducacionDao();
                            for (int i = 1; i < nEducacion + 1; i++) {
                                String vartipoEducacion = "tipoEducacion" + i;
                                String vargrado = "grado" + i;
                                String varinstitucion = "institucion" + i;
                                String varanyo = "anyo" + i;
                                Educacion educacion = new Educacion();
                                //Recuperando informacion
                                String tipoEducacion = request.getParameter(vartipoEducacion);
                                String grado = request.getParameter(vargrado);
                                String institucion = request.getParameter(varinstitucion);
                                Integer anyo = Integer.parseInt(request.getParameter(varanyo));
                                //Comparando con la base
                                Integer idEducacion = eduDao.ExisteEducacion(tipoEducacion, grado, institucion, anyo, detalleUsuario.getIdDetalleUsuario());
                                if (idEducacion != 0) {
                                    //Educacion ya ingresada
                                } else {
                                    //Agregar Educacion
                                    idEducacion = eduDao.getSiguienteId();
                                    educacion.setIdEducacion(idEducacion);
                                    educacion.setIdDetalleUsuario(detalleUsuario.getIdDetalleUsuario());
                                    educacion.setTipoEducacion(tipoEducacion);
                                    educacion.setGradoAlcanzado(grado);
                                    educacion.setNombreInstitucion(institucion);
                                    educacion.setAnio(anyo);

                                    eduDao.ingresar(educacion);
                                }
                            }

                        } else {
                            //No hay educacion agregada
                        }

                        //Insertar o Actualizar Investigaciones
                        if (nInvestigacion > 0) {
                            //Recuperando informacion de Investigaciones
                            for (int i = 1; i < nInvestigacion + 1; i++) {
                                InvestigacionesDAO invDao = new InvestigacionesDAO();
                                String vartitulo = "tituloProyecto" + i;
                                String varpublicado = "publicado" + i;
                                Investigaciones investigacion = new Investigaciones();
                                String tituloProyecto = request.getParameter(vartitulo);
                                Integer publicado = Integer.parseInt(request.getParameter(varpublicado));
                                //Comparando con la base
                                Integer idInvestigacion = invDao.ExisteInvestigacion(detalleUsuario.getIdDetalleUsuario(), tituloProyecto, publicado);
                                if (idInvestigacion != 0) {
                                    //Investigacion ya ingresada
                                } else {
                                    //Agregar Investigacion}
                                    idInvestigacion = invDao.getSiguienteId();
                                    investigacion.setIdInvestigacion(idInvestigacion);
                                    investigacion.setIdDetalleUsuario(detalleUsuario.getIdDetalleUsuario());
                                    investigacion.setTituloInvestigacion(tituloProyecto);
                                    investigacion.setPublicado(publicado);

                                    invDao.ingresar(investigacion);
                                }
                            }
                        } else {
                            //no hay investigaciones
                        }
                        //Insertar o Actualizar Idiomas
                        if (nIdioma > 0) {
                            //Recuperando informacion de Investigaciones
                            for (int i = 1; i < nIdioma + 1; i++) {
                                IdiomaDAO idiomaDao = new IdiomaDAO();
                                String varidioma = "idioma" + i;
                                String varnivelHabla = "nivelHabla" + i;
                                String varnivelEscritura = "nivelEscritura" + i;
                                String varnivelLectura = "nivelLectura" + i;
                                Idioma idiomaPojo = new Idioma();
                                String idioma = request.getParameter(varidioma);
                                String nivelHabla = request.getParameter(varnivelHabla);
                                String nivelEscritura = request.getParameter(varnivelEscritura);
                                String nivelLectura = request.getParameter(varnivelLectura);
                                //Comparando con la base
                                Integer idIdioma = idiomaDao.ExisteIdioma(detalleUsuario.getIdDetalleUsuario(), idioma);
                                if (idIdioma != 0) {
                                    //Actualizar idioma
                                    idiomaPojo = idiomaDao.consultarPorId(idIdioma);
                                    idiomaPojo.setNivelEscrito(nivelEscritura);
                                    idiomaPojo.setNivelHabla(nivelHabla);
                                    idiomaPojo.setNivelLectura(nivelLectura);

                                    idiomaDao.actualizar(idiomaPojo);
                                } else {
                                    //Agregar Investigacion}
                                    idIdioma = idiomaDao.getSiguienteId();
                                    idiomaPojo.setIdIdioma(idIdioma);
                                    idiomaPojo.setIdDetalleUsuario(detalleUsuario.getIdDetalleUsuario());
                                    idiomaPojo.setIdioma(idioma);
                                    idiomaPojo.setNivelHabla(nivelHabla);
                                    idiomaPojo.setNivelLectura(nivelLectura);
                                    idiomaPojo.setNivelEscrito(nivelEscritura);

                                    idiomaDao.ingresar(idiomaPojo);
                                }
                            }
                        } else {
                            //no hay Idiomas
                        }
                        //Insertar o Actualizar Asociaciones
                        if (nAsociacion > 0) {
                            //Recuperando informacion de Asociaciones
                            for (int i = 1; i < nAsociacion + 1; i++) {
                                AsociacionesDAO asociacionDao = new AsociacionesDAO();
                                String varasociacion = "asociacion" + i;
                                Asociaciones asociacion = new Asociaciones();
                                String nombreAsociacion = request.getParameter(varasociacion);
                                //Comparando con la base
                                Integer idAsociacion = asociacionDao.ExisteAsociacion(detalleUsuario.getIdDetalleUsuario(), nombreAsociacion);
                                if (idAsociacion != 0) {
                                    //Asociacion ya ingresada
                                } else {
                                    //Agregar Asociacion}
                                    idAsociacion = asociacionDao.getSiguienteId();
                                    asociacion.setIdAsociacion(idAsociacion);
                                    asociacion.setIdDetalleUsuario(detalleUsuario.getIdDetalleUsuario());
                                    asociacion.setNombreAsociacion(nombreAsociacion);

                                    asociacionDao.ingresar(asociacion);
                                }
                            }
                        } else {
                            //no hay Asociaciones
                        }
                        //Insertar o Actualizar Cargos
                        if (nCargos > 0) {
                            //Recuperando informacion de Cargos
                            for (int i = 1; i < nCargos + 1; i++) {
                                CargoDAO cargosDao = new CargoDAO();
                                String varlugar = "lugarCargo" + i;
                                String varcargo = "cargoAnterior" + i;
                                String varfechaInicio = "fechaInicioCargo" + i;
                                String varfechaFin = "fechaFinCargo" + i;
                                String varresponsabilidades = "responsabilidad" + i;
                                Cargo cargoAnt = new Cargo();
                                String lugarCargo = request.getParameter(varlugar);
                                String cargoAnterior = request.getParameter(varcargo);
                                java.sql.Date fechaInicioCargo = new java.sql.Date(StringAFecha(request.getParameter(varfechaInicio)).getTime());
                                java.sql.Date fechaFinCargo = new java.sql.Date(StringAFecha(request.getParameter(varfechaFin)).getTime());
                                String responsabilidad = request.getParameter(varresponsabilidades);
                                //Comparando con la base
                                Integer idCargoAnt = 0;//cargosDao.ExisteAsociacionAnterior(detalleUsuario.getIdDetalleUsuario(), lugarCargo, cargoAnterior, fechaInicioCargo, fechaFinCargo);
                                if (idCargoAnt != 0) {
                                    //Cargo ya ingresado
                                } else {
                                    //Agregar Cargo}
                                    idCargoAnt = cargosDao.getSiguienteId();
                                    cargoAnt.setIdCargo(idCargoAnt);
                                    cargoAnt.setIdDetalleUsuario(detalleUsuario.getIdDetalleUsuario());
                                    cargoAnt.setNombreCargo(cargoAnterior);
                                    cargoAnt.setLugar(lugarCargo);
                                    cargoAnt.setFechaInicio(fechaInicioCargo);
                                    cargoAnt.setFechaFin(fechaFinCargo);
                                    cargoAnt.setResponsabilidades(responsabilidad);

                                    cargosDao.ingresarCargoAnterior(cargoAnt);
                                }
                            }
                        } else {
                            //no hay Cargos
                        }

                        //Insertar o Actualizar Programas
                        if (nPrograma > 0) {
                            //Recuperando informacion de Programas
                            for (int i = 1; i < nPrograma + 1; i++) {
                                ProgramaEstudioDAO programaDao = new ProgramaEstudioDAO();
                                String varsemestre = "semestre" + i;
                                String varprograma = "programa" + i;

                                ProgramaEstudio programa = new ProgramaEstudio();
                                String semestreS = request.getParameter(varsemestre);
                                String programaEstudio = request.getParameter(varprograma);
                                int semestre = i;
                                //Comparando con la base

                                Integer idPrograma = programaDao.ExisteProgramaAnterior(solicitud.getIdSolicitud(), semestre);
                                if (idPrograma != 0) {
                                    //Actualizar Programa
                                    programa = programaDao.consultarPorId(idPrograma);
                                    programa.setProgramaEstudio(programaEstudio);
                                    programaDao.actualizar(programa);
                                } else {
                                    //Agregar Programa}
                                    idPrograma = programaDao.getSiguienteId();
                                    programa.setIdProgramaEstudio(idPrograma);
                                    programa.setIdSolicitud(solicitud);
                                    programa.setProgramaEstudio(programaEstudio);
                                    programa.setSemestre(semestre);

                                    programaDao.ingresar(programa);
                                }
                            }
                        } else {
                            //no hay Programas
                        }
                        //referencias
                        try {
                            //Recuperando informacion de Referencia 1
                            ReferenciasDAO refeDao = new ReferenciasDAO();
                            String nombre1R1 = request.getParameter("nombre1R1");
                            String nombre2R1 = request.getParameter("nombre2R1");
                            String apellido1R1 = request.getParameter("apellido1R1");
                            String apellido2R1 = request.getParameter("apellido2R1");
                            String domicilioR1 = request.getParameter("direccionR1");
                            Integer idMunicipioR1 = Integer.parseInt(request.getParameter("municipioR1"));
                            String telR1 = request.getParameter("telefonoR1");
                            Referencias referencia = new Referencias();

                            //Comparando con la base
                            Integer idReferencia1 = refeDao.ExisteReferencia(solicitud.getIdSolicitud(), nombre1R1, nombre2R1, apellido1R1, apellido2R1);
                            if (idReferencia1 == 0) {
                                //Ingresar
                                idReferencia1 = refeDao.getSiguienteId();
                                referencia.setIdReferencia(idReferencia1);
                                referencia.setIdSolicitud(solicitud.getIdSolicitud());
                                referencia.setNombre1Du(nombre1R1);
                                referencia.setNombre2Du(nombre2R1);
                                referencia.setApellido1Du(apellido1R1);
                                referencia.setApellido2Du(apellido2R1);
                                referencia.setDomicilio(domicilioR1);
                                referencia.setIdMunicipio(idMunicipioR1);
                                referencia.setTelefonoMovil(telR1);

                                refeDao.ingresar(referencia);
                            } else {
                                //Actualizar
                                referencia = refeDao.consultarPorId(idReferencia1);
                                referencia.setDomicilio(domicilioR1);
                                referencia.setIdMunicipio(idMunicipioR1);
                                referencia.setTelefonoMovil(telR1);

                                refeDao.actualizar(referencia);
                            }

                            //Recuperando informacion de Referencia 2
                            String nombre1R2 = request.getParameter("nombre1R2");
                            String nombre2R2 = request.getParameter("nombre2R2");
                            String apellido1R2 = request.getParameter("apellido1R2");
                            String apellido2R2 = request.getParameter("apellido2R2");
                            String domicilioR2 = request.getParameter("direccionR2");
                            Integer idMunicipioR2 = Integer.parseInt(request.getParameter("municipioR2"));
                            String telR2 = request.getParameter("telefonoR2");

                            //Comparando con la base
                            Integer idReferencia2 = refeDao.ExisteReferencia(solicitud.getIdSolicitud(), nombre1R2, nombre2R2, apellido1R2, apellido2R2);
                            if (idReferencia2 == 0) {
                                //Ingresar
                                idReferencia2 = refeDao.getSiguienteId();
                                referencia.setIdReferencia(idReferencia2);
                                referencia.setIdSolicitud(solicitud.getIdSolicitud());
                                referencia.setNombre1Du(nombre1R2);
                                referencia.setNombre2Du(nombre2R2);
                                referencia.setApellido1Du(apellido1R2);
                                referencia.setApellido2Du(apellido2R2);
                                referencia.setDomicilio(domicilioR2);
                                referencia.setIdMunicipio(idMunicipioR2);
                                referencia.setTelefonoMovil(telR2);

                                refeDao.ingresar(referencia);
                            } else {
                                //Actualizar
                                referencia = refeDao.consultarPorId(idReferencia2);
                                referencia.setDomicilio(domicilioR2);
                                referencia.setIdMunicipio(idMunicipioR2);
                                referencia.setTelefonoMovil(telR2);

                                refeDao.actualizar(referencia);
                            }

                            //Recuperando informacion de Referencia 3
                            String nombre1R3 = request.getParameter("nombre1R3");
                            String nombre2R3 = request.getParameter("nombre2R3");
                            String apellido1R3 = request.getParameter("apellido1R3");
                            String apellido2R3 = request.getParameter("apellido2R3");
                            String domicilioR3 = request.getParameter("direccionR3");
                            Integer idMunicipioR3 = Integer.parseInt(request.getParameter("municipioR3"));
                            String telR3 = request.getParameter("telefonoR3");

                            //Comparando con la base
                            Integer idReferencia3 = refeDao.ExisteReferencia(solicitud.getIdSolicitud(), nombre1R3, nombre2R3, apellido1R3, apellido2R3);
                            if (idReferencia3 == 0) {
                                //Ingresar
                                idReferencia3 = refeDao.getSiguienteId();
                                referencia.setIdReferencia(idReferencia3);
                                referencia.setIdSolicitud(solicitud.getIdSolicitud());
                                referencia.setNombre1Du(nombre1R3);
                                referencia.setNombre2Du(nombre2R3);
                                referencia.setApellido1Du(apellido1R3);
                                referencia.setApellido2Du(apellido2R3);
                                referencia.setDomicilio(domicilioR3);
                                referencia.setIdMunicipio(idMunicipioR3);
                                referencia.setTelefonoMovil(telR3);

                                refeDao.ingresar(referencia);
                            } else {
                                //Actualizar
                                referencia = refeDao.consultarPorId(idReferencia3);
                                referencia.setDomicilio(domicilioR3);
                                referencia.setIdMunicipio(idMunicipioR3);
                                referencia.setTelefonoMovil(telR3);

                                refeDao.actualizar(referencia);
                            }

                        } catch (Exception e) {
                        }

                        //documentos
                        ArrayList<String> documentos = new ArrayList<>();
                        documentos.add("solicitudFirmada");
                        documentos.add("dictamenJefe");
                        documentos.add("tituloAcademico");
                        documentos.add("partida");
                        documentos.add("dui");
                        documentos.add("curriculo");
                        documentos.add("notas");
                        documentos.add("certificado");
                        documentos.add("poder");
                        ArrayList<Integer> tipos = new ArrayList<>();
                        tipos.add(122);
                        tipos.add(123);
                        tipos.add(124);
                        tipos.add(125);
                        tipos.add(126);
                        tipos.add(127);
                        tipos.add(128);
                        tipos.add(129);
                        tipos.add(130);

                        //Recuperando datos del formulario
                        DocumentoDAO documentoDao = new DocumentoDAO();
                        InputStream documentoAdjunto = null;
                        String obs = "DOCUMENTO ADJUNTO PARA SOLICITUD DE BECA DEL USUARIO: " + user;
                        TipoDocumentoDAO tipoDao = new TipoDocumentoDAO();
                        TipoDocumento tipoDocumento = new TipoDocumento();
                        for (int i = 0; i < 9; i++) {
                            Documento anexo = new Documento();
                            //Comparando si exite documento
                            Integer idTipo = tipos.get(i);
                            Integer idDocumento = documentoDao.ExisteDocumento(exp.getIdExpediente(), idTipo);
                            Part filePart = null;
                            filePart = request.getPart(documentos.get(i));
                            if (filePart != null) {
                                documentoAdjunto = filePart.getInputStream();
                            }

                            if (idDocumento == 0) {
                                //Ingresar Documento
                                idDocumento = documentoDao.getSiguienteId();
                                tipoDocumento = tipoDao.consultarPorId(idTipo);
                                anexo.setIdDocumento(idDocumento);
                                anexo.setIdTipoDocumento(tipoDocumento);
                                anexo.setIdExpediente(exp);
                                anexo.setDocumentoDigital(documentoAdjunto);
                                anexo.setObservacion(obs);
                                anexo.setEstadoDocumento("INGRESADO");
                                documentoDao.Ingresar(anexo);
                            } else {
                                //Actualizar Documento
                                anexo = documentoDao.ObtenerPorId(idDocumento);
                                anexo.setDocumentoDigital(documentoAdjunto);
                                documentoDao.ActualizarDocumentoObservacion(anexo);
                            }

                        }
                        /*
                        //hacer solicitud, actualizar beneficios y fecha solicitud
                        Documento acuerdo = new Documento();*/
                        Date fechaHoy = new Date();
                        java.sql.Date sqlDate = new java.sql.Date(fechaHoy.getTime());
                        /*Integer idDoc = documentoDao.getSiguienteId();
                        Integer tip = 131;
                        tipoDocumento = tipoDao.consultarPorId(tip);
                        String observacion = "DOCUMENTO SOLICITADO POR EL USUARIO:" + user;

                        acuerdo.setIdDocumento(idDoc);
                        acuerdo.setIdTipoDocumento(tipoDocumento);
                        acuerdo.setIdExpediente(exp);
                        acuerdo.setFechaSolicitud(sqlDate);
                        acuerdo.setObservacion(observacion);
                        acuerdo.setEstadoDocumento("PENDIENTE");
                        boolean solicitarAcuerdo = documentoDao.solicitarDocumento(acuerdo);
                        */
                        
                        //Cambiar Estado de Progreso 
                        exp.setEstadoProgreso("EN PROCESO");
                        expDao.actualizarExpediente(exp);
                        //Actualizar Beneficios y fecha Solicitud de solicitud Beca
                        String beneficios = request.getParameter("beneficios");
                        solicitud.setBeneficios(beneficios);
                        solicitud.setFechaSolicitud(sqlDate);
                        solicitudBecaDao.actualizar(solicitud);                        
                        Utilidades.nuevaBitacora(11, Integer.parseInt(request.getSession().getAttribute("id_user_login").toString()) , "Se agrego la solicitud de beca por el usuario "+ user + " en el expediente " + exp.getIdExpediente() + ".","");         
                        Utilidades.mostrarMensaje(response, 1, "Exito", "Se realizo la solicitud satisfactoriamente.");

                    } else {
                        //NO HAY DETALLE USUARIO
                        Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo realizar la solicitud.");
                    }
                } catch (Exception e) {
                    //Mensaje de error de detalle usuario
                }   Utilidades.mostrarMensaje(response, 2, "Error", "No se pudo realizar la solicitud.");
            } else {
            }

        } catch (Exception e) {
            //Mensaje de Error de lectura de Datos
            e.printStackTrace();
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

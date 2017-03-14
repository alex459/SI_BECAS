/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DAO.ExpedienteDAO;
import DAO.OfertaBecaDAO;
import POJO.Expediente;
import POJO.OfertaBeca;
import DAO.InstitucionDAO;

/**
 *
 * @author adminPC
 */
@WebServlet(name = "AgregarBecarioServlet", urlPatterns = {"/AgregarBecarioServlet"})
public class AgregarBecarioServlet extends HttpServlet {

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

        //LEER DATOS DEL JSP
        try {
            int ID_USUARIO = Integer.parseInt(request.getParameter("ID_USUARIO"));
            boolean checkOferta = Boolean.getBoolean(request.getParameter("checkOferta"));
            String fechaInicioBeca = request.getParameter("fechaInicio");
            String fechaFinBeca = request.getParameter("fechaFin");

            if (ID_USUARIO != 0) {
                //Crear el expediente
                ExpedienteDAO expedienteDao = new ExpedienteDAO();
                int idExpediente = expedienteDao.getSiguienteId();
                Expediente expediente = new Expediente();
                expediente.setIdExpediente(idExpediente);
                expediente.setIdProgreso(9);
                expediente.setEstadoExpediente("ABIERTO");
                expediente.setEstadoProgreso("PENDIENTE");
                boolean expedienteCreado = expedienteDao.ingresar(expediente);
                if (expedienteCreado == true) {
                    //Obtener o crear oferta de beca
                    int idOferta = 0;
                    if (checkOferta == true) {
                        //Crear la oferta  
                        OfertaBecaDAO ofertaDao = new OfertaBecaDAO();
                        OfertaBeca ofertaBeca = new OfertaBeca();
                        InstitucionDAO institucionDAO = new InstitucionDAO();
                        //obtener los datos del jsp
                        String nombreOferta = request.getParameter("nombreOferta");
                        String tipoEstudio = request.getParameter("tipoEstudio");
                        ofertaBeca.setNombreOferta(nombreOferta);
                        ofertaBeca.setTipoEstudio(tipoEstudio);
                        ofertaBeca.setIdInstitucionEstudio(institucionDAO.consultarIdPorNombre(request.getParameter("institucionEstudio")));
                        ofertaBeca.setIdInstitucionFinanciera(institucionDAO.consultarIdPorNombre(request.getParameter("institucionOferente")));
                        String TipoOferta = ofertaDao.ObtenerTipoOfertaBeca(ofertaBeca.getIdInstitucionEstudio());
                        ofertaBeca.setTipoOfertaBeca(TipoOferta);
                        idOferta = ofertaDao.getSiguienteId();
                        ofertaBeca.setIdOfertaBeca(idOferta);
                        boolean checkOfertaIngresada = ofertaDao.ingresarOfertaMigracion(ofertaBeca);
                    } else {
                        //Obtener el id de la oferta
                        idOferta = Integer.parseInt(request.getParameter("oferta"));
                    }
                    
                    
                } else {
                    //Mostrar mensaje de error
                }
            } else {
                //No se puede crear el becario, mostrar mensaje de error
            }

        } catch (Exception e) {
            e.printStackTrace();
            //No se pudieron leer los datos, mostrar mensaje de error
        }
        //CREAR EXPEDIENTE

        /*if oferta (esta en el sistema)
	Agarrar datos
else 
	Agregar*/
//crear la solicitud de beca
//ingresar documentos obligatorios
//Crear Beca
//estadoExpediente = Abierto
/*switch (estado)
	case Realización de Estudio: 
		idProgreso = 9
	case Servicio Contractual:
		idProgreso = 12
		guardar documentos del proceso
	case Gestión de Compromiso Contractual:
		idProgreso =13
		guardar documentos del proceso
	case Gestión de Liberación:
		idProgreso =14
		guardar documentos del proceso
	case Gestión de Beca Finalizada:
		idProgreso =16
		guardar documentos del proceso
		estadoExpediente = Cerrado
	case Reintegro de Beca:
		idProgreso = 23
		solicitar acta de reintegro
	case Finalizada por Reintegro de Beca:
		idProgreso = 16
		guardar documentos del proceso
		estadoExpediente = Cerrado
         */
//Actualizar progreso del expediente
    }

    //Metodo que permite convertir un texto en fecha
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package MODEL;

import java.io.IOException;
import java.io.PrintWriter;
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
        //308
        String nombre1 = request.getParameter("nombre1");
        String nombre2 = request.getParameter("nombre2");
        String apellido1 = request.getParameter("apellido1");
        String apellido2 = request.getParameter("apellido2");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String departamentoNacimiento = request.getParameter("departamentoNacimiento");
        String municipioNacimiento = request.getParameter("municipioNacimiento");
        String genero = request.getParameter("genero");
        String direccion = request.getParameter("direccion");
        String departamentoDireccion = request.getParameter("departamentoDireccion");
        String municipioDireccion = request.getParameter("municipioDireccion");
        String telCasa = request.getParameter("telCasa");
        String telMovil = request.getParameter("telMovil");
        String telOficina = request.getParameter("telOficina");
        //309
        String profesion = request.getParameter("profesion");

        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SolicitarBecaServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SolicitarBecaServlet at " + request.getContextPath() + "</h1>");
            out.println(nombre1);
            out.println(nombre2);
            out.println(apellido1);
            out.println(apellido2);
            out.println(fechaNacimiento);
            out.println(departamentoNacimiento);
            out.println(municipioNacimiento);
            out.println(genero);
            out.println(direccion);
            out.println(departamentoDireccion);
            out.println(municipioDireccion);
            out.println(telCasa);
            out.println(telMovil);
            out.println(telOficina);
            out.println(profesion);
            out.println("</body>");
            out.println("</html>");
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

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ma.hotel.controlers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ma.hotel.dao.DAOUtil;

/**
 *
 * @author hp
 */
@WebServlet(name = "serModif", urlPatterns = {"/serModif"})
public class serModif extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet serModif</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet serModif at " + request.getContextPath() + "</h1>");
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
        try {
            Connection con=DAOUtil.getConnection();
            PreparedStatement ps=con.prepareStatement("update client set cin=?, nomclt=?, prenomclt=?, villeclt=?, adresseclt=?,email=?, tel=?,situation=?");
            ps.setString(1, request.getParameter("cin"));
            ps.setString(2, request.getParameter("nom"));
            ps.setString(3, request.getParameter("prenom"));
            ps.setString(4, request.getParameter("ville"));
            ps.setString(5, request.getParameter("adresse"));
            ps.setString(6, request.getParameter("email"));
            ps.setString(7, request.getParameter("tele"));
            int marie=0;
            if(request.getParameter("marie")!=null){
                marie=1;
            }
            ps.setInt(8, marie);
            ps.executeUpdate();
            
            PreparedStatement ps1=con.prepareStatement("update reservation set datedebut=?,datefin=? where num_res=?");
            Date dd=Date.valueOf(request.getParameter("dated"));
                Date df=Date.valueOf(request.getParameter("datef"));
                int numres=Integer.parseInt(request.getParameter("numres"));
               ps1.setDate(1, dd);
               ps1.setDate(2, df);
               ps1.setInt(3, numres);
            ps1.executeUpdate();
            String cin=request.getParameter("cin");
                request.setAttribute("msg", "Modif avec succes.");
            request.setAttribute("typemsg", "sucsess");
            request.getRequestDispatcher("/jsp/listeRes.jsp?cin="+cin).forward(request, response);
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(ResposerModif.class.getName()).log(Level.SEVERE, null, ex);
        }
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

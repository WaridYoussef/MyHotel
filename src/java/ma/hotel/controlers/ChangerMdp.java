/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ma.hotel.controlers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ma.hotel.dao.DAOUtil;
import ma.hotel.models.Responsable;

/**
 *
 * @author hp
 */
@WebServlet(name = "ChangerMdp", urlPatterns = {"/ChangerMdp"})
public class ChangerMdp extends HttpServlet {

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
            out.println("<title>Servlet ChangerMdp</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangerMdp at " + request.getContextPath() + "</h1>");
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
         HttpSession s=request.getSession();
        Responsable r=(Responsable) s.getAttribute("r");
        String ancmdp=request.getParameter("ancmdp");
        String mdp=request.getParameter("mdp");
        String mdp2=request.getParameter("mdp2");
        if(r.getCompte().getMdp().equals(ancmdp)){
            if(mdp.equals(mdp2)){
                try {
                    Connection con=DAOUtil.getConnection();
                    PreparedStatement ps=con.prepareStatement("update compte set mdp=? where login=?");
                    ps.setString(1, mdp);
                    ps.setString(2, r.getCompte().getLogin());
                    ps.executeUpdate();
                    request.setAttribute("msg", "mot de passe change avec succes");
            request.setAttribute("typemsg", "sucsess");
            request.getRequestDispatcher("/jsp/changermdp.jsp").forward(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ChangerMdp.class.getName()).log(Level.SEVERE, null, ex);
                }
                
            }else{
                request.setAttribute("msg", "Les deux mot de passe ne correspondent pas!!");
            request.setAttribute("typemsg", "error");
            request.getRequestDispatcher("/jsp/changermdp.jsp").forward(request, response);
            }
        }else{
            request.setAttribute("msg", "L'ancien mot de passe est invalide!!");
            request.setAttribute("typemsg", "error");
            request.getRequestDispatcher("/jsp/changermdp.jsp").forward(request, response);
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

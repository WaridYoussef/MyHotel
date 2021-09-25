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
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ma.hotel.dao.CryptageMD5;
import ma.hotel.dao.DAOUtil;
import ma.hotel.models.Compte;
import ma.hotel.models.Responsable;

/**
 *
 * @author hp
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

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
            out.println("<title>Servlet Login</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Login at " + request.getContextPath() + "</h1>");
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
            String login=request.getParameter("login");
            String mdp=request.getParameter("mdp");
            Connection conn=DAOUtil.getConnection();
            PreparedStatement ps=conn.prepareStatement("select *from Responsable join compte using (login) where login=? and mdp=?");
            ps.setString(1, login);
            ps.setString(2, mdp);
            ResultSet rs=ps.executeQuery();
            if(rs.next()){
                Responsable r=new Responsable(rs.getInt("idr"), rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),rs.getString("imgres"),null, 
                        new Compte(login, mdp, rs.getString("role")));
                if(request.getParameter("remember")!=null){
                    Cookie ck= new Cookie("auth", login+"/"+CryptageMD5.getEncodedPassword(mdp));
                    ck.setMaxAge(60*60*24*7);
                    response.addCookie(ck);
                }
                
                request.getSession().setAttribute("r", r);
                request.getRequestDispatcher("/jsp/mesHoteles.jsp").forward(request, response);
            }else{
                request.setAttribute("msg", "Login / Mot de passe invalide!!");
                request.setAttribute("typemsg", "error");
                request.getRequestDispatcher("/jsp/formLogin.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
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

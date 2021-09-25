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
import java.sql.SQLException;
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
@WebServlet(name = "LikeComm", urlPatterns = {"/LikeComm"})
public class LikeComm extends HttpServlet {

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
            out.println("<title>Servlet LikeComm</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LikeComm at " + request.getContextPath() + "</h1>");
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
        
        Connection con=null;
        int idc=Integer.parseInt(request.getParameter("idc"));
         try {
           
            con=DAOUtil.getConnection();
            con.setAutoCommit(false);
            String req="";
            String action=request.getParameter("action");
            if(action.equals("like")){
            req="update commentaire set nbrlike=nbrlike+1 where idc=?";
            }else{
                req="update commentaire set nbrunlike=nbrunlike+1 where idc=?";
            }
            PreparedStatement ps=con.prepareStatement(req);
            
            ps.setInt(1, idc);
                ps.executeUpdate();
          PreparedStatement ps2=con.prepareStatement("insert into likes values (?,?,?)");
          ps2.setInt(1, idc);
          ps2.setString(2, request.getSession().getId());
          ps2.setString(3, action);
          ps2.executeUpdate();
          
            ps=con.prepareStatement("select nbrlike,nbrunlike from commentaire where idc=?");
            ps.setInt(1, idc);
             ResultSet rs=ps.executeQuery();
             String reponse="";
             if(rs.next()){
                  reponse="<button type=\"button\"  "
                         + "class=\"btn btn-outline-success rounded-circle\">\n" +
                        "<img src=\"/PFE-MyHotel/img/like.png\" style=\"width: 21px; height: 21px\">" +rs.getInt(1)+
                        "</button>\n" +
                        "<button type=\"button\" class=\"btn btn-outline-danger rounded-circle\">\n" +
                        "<img src=\"/PFE-MyHotel/img/unlike.png\" style=\"width: 21px; height: 21px\">" +rs.getInt(2)+
                        "</button>";
             }
             con.commit();
             PrintWriter out=response.getWriter();
             out.print(reponse);
             
        } catch (Exception ex) {
            try {
                con.rollback();
             PreparedStatement  ps=con.prepareStatement("select nbrlike,nbrunlike from commentaire where idc=?");
            ps.setInt(1, idc);
             ResultSet rs=ps.executeQuery();
             String reponse="";
             if(rs.next()){
                  reponse="<button type=\"button\"  "
                         + "class=\"btn btn-outline-success rounded-circle\">\n" +
                        "<img src=\"/PFE-MyHotel/img/like.png\" style=\"width: 21px; height: 21px\">" +rs.getInt(1)+
                        "</button>\n" +
                        "<button type=\"button\" class=\"btn btn-outline-danger rounded-circle\">\n" +
                        "<img src=\"/PFE-MyHotel/img/unlike.png\" style=\"width: 21px; height: 21px\">" +rs.getInt(2)+
                        "</button> <p style=\"color : red\" >Vous aves deja aimer ce commentaire</p> ";
             }
             
             PrintWriter out=response.getWriter();
             out.print(reponse);
            } catch (SQLException ex1) {
                Logger.getLogger(LikeComm.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(LikeComm.class.getName()).log(Level.SEVERE, null, ex);
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

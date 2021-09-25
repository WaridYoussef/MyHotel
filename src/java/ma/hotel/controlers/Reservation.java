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
import java.sql.ResultSet;


import java.sql.Statement;
 


import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import ma.hotel.dao.DAOUtil;
import oracle.sql.SQLUtil;


/**
 *
 * @author hp
 */
@WebServlet(name = "Reservation", urlPatterns = {"/Reservation"})
@MultipartConfig
public class Reservation extends HttpServlet {

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
            out.println("<title>Servlet Reservation</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Reservation at " + request.getContextPath() + "</h1>");
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
            con.setAutoCommit(false);
            PreparedStatement ps=con.prepareStatement("insert into client values(seq_clt.nextval,?,?,?,?,?,?,?,?)");
            String cin=request.getParameter("cin");
            String nom=request.getParameter("nom");
            String prenom=request.getParameter("prenom");
            String email=request.getParameter("email");
            String adresse=request.getParameter("adresse");
            String ville=request.getParameter("ville");
            String tel=request.getParameter("tele");
            int marie=0;
            if(request.getParameter("marie")!=null){
                marie=1;
            }
            ps.setString(1, cin);
            ps.setString(2, nom);
            ps.setString(3, prenom);
            ps.setString(4, ville);
            ps.setString(5, adresse);
            ps.setString(6, email);
            ps.setString(7, tel);
            ps.setInt(8, marie);
            
            ps.executeUpdate();
            
            
            String req="select max(idclt) from client";
            int idclt=0;
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(req);
            if(rs.next()){
                idclt=rs.getInt(1);
                PreparedStatement ps1=con.prepareStatement("insert into reservation values(seq_res.nextval,?,?,?,?,?)");
               
                
                int idh=Integer.parseInt(request.getParameter("idh"));
                String idch=request.getParameter("idch");
                Date dd=Date.valueOf(request.getParameter("dated"));
                Date df=Date.valueOf(request.getParameter("datef"));
               ps1.setDate(1, dd);
               ps1.setDate(2, df);
                ps1.setInt(3, idh);
                ps1.setString(4, idch);
                ps1.setInt(5, idclt);
                
                
                ps1.executeUpdate();
                
                PreparedStatement ps2=con.prepareStatement("update chambre set etatch=? where idch=?");
                ps2.setString(1, "reserve");
                ps2.setString(2, idch);
                ps2.executeUpdate();
            }
            
            request.setAttribute("msg", "Reserver avec succes.");
            request.setAttribute("typemsg", "sucsess");
            request.getRequestDispatcher("/jsp/listeRes.jsp?cin="+cin).forward(request, response);
            con.commit();
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(Reservation.class.getName()).log(Level.SEVERE, null, ex);
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

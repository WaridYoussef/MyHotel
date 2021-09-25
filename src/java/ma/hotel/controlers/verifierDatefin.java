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
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

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
@WebServlet(name = "verifierDatefin", urlPatterns = {"/verifierDatefin"})
public class verifierDatefin extends HttpServlet {

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
            out.println("<title>Servlet verifierDatefin</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet verifierDatefin at " + request.getContextPath() + "</h1>");
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
            String req="select idch,datefin from reservation";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(req);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            
            while (rs.next()) {    
                Date d=new Date();
                Date df=sdf.parse(rs.getDate("datefin")+"");
                if(d.compareTo(df)>0){
                    PreparedStatement ps=con.prepareStatement("update chambre set etatch=? where idch=?");
                    ps.setString(1, "disponible");
                    ps.setString(2, rs.getString("idch"));
                    ps.executeUpdate();
                    
                    PreparedStatement ps1=con.prepareStatement("delete from reservation where idch=?");
                    ps1.setString(1, rs.getString("idch"));
                    ps1.executeUpdate();
                    
                }
                
                }
                int idr=Integer.parseInt(request.getParameter("idr"));
                request.setAttribute("msg", "Reserver avec succes.");
            request.setAttribute("typemsg", "sucsess");
            request.getRequestDispatcher("/jsp/resRespo.jsp?idr="+idr).forward(request, response);
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(verifierDatefin.class.getName()).log(Level.SEVERE, null, ex);
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

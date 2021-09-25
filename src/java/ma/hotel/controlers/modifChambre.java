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
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import ma.hotel.dao.DAOUtil;

/**
 *
 * @author hp
 */
@WebServlet(name = "modifChambre", urlPatterns = {"/modifChambre"})
@MultipartConfig
public class modifChambre extends HttpServlet {

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
            out.println("<title>Servlet modifChambre</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet modifChambre at " + request.getContextPath() + "</h1>");
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
            Connection con = DAOUtil.getConnection();
            
            PreparedStatement ps = con.prepareStatement("update chambre set idch=?, numch=?, prix=?, idcat=?, imgch=? where idch=?");
            
            String idch = request.getParameter("idch");
            int cat = Integer.parseInt(request.getParameter("cat"));
            int numch = Integer.parseInt(request.getParameter("numch"));
            float prix = Float.valueOf(request.getParameter("prix"));
            Part p=request.getPart("imgch");

            String filename = p.getHeader("content-disposition");

            for (String s : filename.split(";")) {
                if (s.trim().startsWith("filename")) {
                    filename = s.substring(s.indexOf("=") + 1).trim().replace("\"", "");
                    filename = filename.substring(filename.lastIndexOf('/') + 1).substring(filename.lastIndexOf('\\') + 1);

                }
            }
            if (filename.length()>0){
                ps.setString(5, filename);
                p.write(getServletContext().getRealPath("/img/"+filename));

            } else {
                ps.setString(5, request.getParameter("imgch"));
            }
            ps.setString(1, idch);
            ps.setInt(2, numch);
            ps.setFloat(3, prix);
            ps.setInt(4, cat);
             ps.setString(6, idch);
            ps.executeUpdate();
            request.setAttribute("msg", "Chambre modifier avec succes.");
            request.setAttribute("typemsg", "sucsess");
            request.getRequestDispatcher("/jsp/mesHoteles.jsp").forward(request, response);
            con.close();
        } catch (Exception ex) {
            Logger.getLogger(EditHotel.class.getName()).log(Level.SEVERE, null, ex);
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

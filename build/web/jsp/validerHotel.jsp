<%-- 
    Document   : validerHotel
    Created on : 09-avr.-2020, 20:19:00
    Author     : Utilisateur
--%>

<%@page import="ma.hotel.models.Ville"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ma.hotel.models.Hotel"%>
<%@page import="ma.hotel.models.Responsable"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="entete.jsp"></jsp:include>
        <%
       
             if (session.getAttribute("r") == null) {
                    request.setAttribute("msg", "cette page necessite une authentification");
                    request.setAttribute("typemsg", "error");
                    request.getRequestDispatcher("/jsp/formLogin.jsp").forward(request, response);

                }else{
                Responsable r=(Responsable)session.getAttribute("r");
                if(!r.getCompte().getRole().equals("admin")){
                    
                    request.setAttribute("msg", "cette page necessite une authentification en tant que Admin!");
                    session.invalidate();
                    request.setAttribute("typemsg", "error");
                    request.getRequestDispatcher("/jsp/formLogin.jsp").forward(request, response);
                }
            }
            
            %>
        
        <%if (request.getAttribute("msg") != null) {%>
            <div style="margin: auto; position: relative; width: 50% " class="alert alert-<%=request.getAttribute("typemsg").toString().equals("error") ? "danger": "primary"%> " role="alert">
                <%=request.getAttribute("msg")%>
            </div>

            <% }%>
            
            
             <%
                Responsable r=(Responsable)session.getAttribute("r");
                List<Hotel> Hots = new ArrayList<Hotel>();
                Connection con = DAOUtil.getConnection();
                String req = "select * from hotel join ville using(idville) join responsable using (idr) where etat='en cours' ";
                PreparedStatement ps=con.prepareStatement(req);
                
                ResultSet rs = ps.executeQuery();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                while (rs.next()) {
                    Date datepub=null;
                    try{
                    datepub=sdf.parse(rs.getDate("datepub").toString());
                    }catch(Exception ex){}
                    Hots.add(new Hotel(rs.getInt("idh"), rs.getString("nomh"), new Ville(rs.getInt("idville"),rs.getString("nomville")), rs.getString("img"),
                        new Responsable(rs.getInt("idr"), rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),rs.getString("imgres"),sdf.parse(rs.getDate("datenaiss").toString()), null), rs.getString("etat"),
                        rs.getString("adresse"), rs.getInt("idetoile"), sdf.parse(rs.getDate("datepub").toString())));
                }
                
                

                con.close();

                int p = 1;
                if (request.getParameter("p") != null) {
                    p = Integer.parseInt(request.getParameter("p"));
                }
                int nbrArtParPage = 5;
                int nbrPages = (Hots.size() % nbrArtParPage == 0) ? Hots.size() / nbrArtParPage : Hots.size() / nbrArtParPage + 1;
               int indexTo = p * nbrArtParPage;
                if (Hots.size() % nbrArtParPage != 0 && p == nbrPages) {
                    indexTo = Hots.size();
                }
                
            %>
        
            <%            if (Hots.size() == 0) {%>

            <div class="alert alert-danger" role="alert">
                aucun Hotel a valider!!
            </div>

            <%  } else { 
            List<Hotel> hotsCur = Hots.subList((p - 1) * nbrArtParPage, indexTo);
            %>
            
            <h3 style="text-align: center; margin-top: 40px; font-family: monospace; color: #0056b3; ">Valider hoteles</h3>
            <form action="/PFE-MyHotel/ValiderHots" method="post">
            <table class="table" style="margin-top: 20px">
                <thead class="thead-light">
                    <tr>
                        <th scope="col"><span style="margin-left: 55px">Image</span></th>
                        <th scope="col">Hotel</th>
                        <th scope="col">Ville</th>
                        <th scope="col">Adresse</th>
                        <th scope="col">Etoiles</th>
                        <th scope="col">Responsable</th>
                        <th scope="col">Detail</th>
                        <th scope="col">Valider</th>
                    </tr>
                </thead>
                <tbody>
                    <%for (Hotel h : hotsCur) {%>
                    <tr>
                        <th><img src="/PFE-MyHotel/img/<%=h.getImg()%>" width="250px" height="95px"></th>
                        <td><span style="line-height: 65px"><%=h.getNomh()%></span></td>
                        <td><span style="line-height: 65px"><%=h.getVille().getNomville()%></span></td>
                        <td><span style="line-height: 65px"><%=h.getAdresse()%></span></td>
                        <td><%if (h.getEtoile() == 1) {%>
                            <span style="line-height: 65px">
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                            </span>
                            <%} else if (h.getEtoile() == 2) {%>
                            <span style="line-height: 65px">
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star "></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>

                            </span>
                            <%} else if (h.getEtoile() == 3) {%>
                            <span style="line-height: 65px">
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                            </span>
                            <%} else if (h.getEtoile() == 4) {%>
                            <span style="line-height: 65px">
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star " style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star"></span>
                            </span>
                            <%} else if (h.getEtoile() == 5) {%>
                            <span style="line-height: 65px">
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            </span>
                            <%}%></td>
                        <td><span style="line-height: 65px">@<%= h.getResponsable().getNom()%></span></td>
                        <td><span style="line-height: 65px"><a href="/PFE-MyHotel/jsp/DetailRes.jsp?idh=<%=h.getIdh()%>">Plus...</a></span></td>
                        <td><span style="line-height: 65px"><input type="checkbox" name="idh" value="<%=h.getIdh()%>"></span></td>
                    </tr>
                    <%}%>
                </tbody>
            </table>


            <%}%>

            <div style="margin: auto; position: relative; width: 200px">
                <nav aria-label="aller a la page">
                    <ul class="pagination pagination-sm">
                        <%for (int i = 1; i <= nbrPages; i++) {
                                if (i == p) {
                        %>
                        <li class="page-item active" aria-current="page">
                            <span class="page-link">
                                <%=i%>
                                <span class="sr-only">(current)</span>
                            </span>
                        </li>
                        <%} else {%>
                        <li class="page-item"><a class="page-link" href="/PFE-MyHotel/jsp/validerHotel.jsp?p=<%=i%>"><%=i%></a></li>
                            <%}
                        }%>
                    </ul>

                </nav>
            </div>
                    <div style="margin-left: 40% ; position: relative; width: 100px; display: inline">
                        <button type="submit" name="action" value="Valider" class="btn btn-info">Valider</button>
                        <button type="submit" name="action" value="Refuser" class="btn btn-danger">Refuser</button>
                    </div>

                    </form>
            
            
            
        <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

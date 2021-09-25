<%-- 
    Document   : mesHoteles
    Created on : 05-avr.-2020, 21:36:31
    Author     : Utilisateur
--%>

<%@page import="ma.hotel.models.Ville"%>
<%@page import="ma.hotel.models.Hotel"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
        
        <%if (session.getAttribute("r") == null) {
                    request.setAttribute("msg", "cette page necessite une authentification");
                    request.setAttribute("typemsg", "error");
                    request.getRequestDispatcher("/jsp/formLogin.jsp").forward(request, response);

                }%>
                
                <%if (request.getAttribute("msg") != null) {%>
            <div style="margin: auto; position: relative; width: 50% " class="alert alert-<%=request.getAttribute("typemsg").toString().equals("error") ? "danger": "primary"%> " role="alert">
                <%=request.getAttribute("msg")%>
            </div>

            <%}%>
            
            <%
                Responsable r=(Responsable)session.getAttribute("r");
                List<Hotel> hots = new ArrayList<Hotel>();
                Connection con = DAOUtil.getConnection();
                String req = "select * from hotel join ville using (idville) join responsable using (idr) where idr=? and etat not in ('refuse')";
                PreparedStatement ps=con.prepareStatement(req);
                ps.setInt(1, r.getIdr());
                ResultSet rs = ps.executeQuery();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                while (rs.next()) {
                    Date datepub=null;
                    try{
                    datepub=sdf.parse(rs.getDate("datepub").toString());
                    }catch(Exception ex){}
                    hots.add(new Hotel(rs.getInt("idh"), rs.getString("nomh"), new Ville(rs.getInt("idville"),rs.getString("nomville")), rs.getString("img"), 
                            new Responsable(rs.getInt("idr"), rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),rs.getString("imgres"),sdf.parse(rs.getDate("datenaiss").toString()) ,null), rs.getString("etat"),
                            rs.getString("adresse"), rs.getInt("idetoile"), sdf.parse(rs.getDate("datepub").toString())));
                }

                con.close();

                int p = 1;
                if (request.getParameter("p") != null) {
                    p = Integer.parseInt(request.getParameter("p"));
                }
                int nbrArtParPage = 5;
                int nbrPages = (hots.size() % nbrArtParPage == 0) ? hots.size() / nbrArtParPage : hots.size() / nbrArtParPage + 1;
                int indexTo = p * nbrArtParPage;
                if (hots.size() % nbrArtParPage != 0 && p == nbrPages) {
                    indexTo = hots.size();
                }
                
            %>
            
            <%            if (hots.size() == 0) {%>

            <div class="alert alert-danger" role="alert">
                Vous n'avez ajout aucun hotel !!
            </div>

            <%  } else { 
            List<Hotel> hotsCur = hots.subList((p - 1) * nbrArtParPage, indexTo); %>
            <form action="/PFE-MyHotel/jsp/resRespo.jsp">
            <div style="text-align: center; margin-top: 30px">
                    <button type="submit" class="btn btn-primary" style="width: 200px">Les reservations...</button>
                    <input type="text" name="idr" hidden value="<%=r.getIdr()%>">
            </div>
            </form>
            <h3 style="text-align: center; margin-top: 40px; font-family: monospace; color: #0056b3; ">Liste de mes hoteles</h3>
            <table class="table" style="margin-top: 20px">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col"><span style="margin-left: 55px">Image</span></th>
                        <th scope="col">Hotel</th>
                        <th scope="col">ville</th>
                        <th scope="col">Adresse</th>
                        <th scope="col">Etat</th>
                        <th scope="col">Etoile</th>
                         <th scope="col">Detail</th>
                         <th scope="col">+chambre</th>                        
                        <th scope="col">Supprimer</th>
                        <th scope="col">Editer</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <%for (Hotel h : hotsCur) {%>
                    <tr>
                        <th><img src="/PFE-MyHotel/img/<%=h.getImg()%>" width="250px" height="95px"></th>
                        <td><span style="line-height: 65px"><%=h.getNomh()%></span></td>
                        <td><span style="line-height: 65px"><%=h.getVille().getNomville()%></span></td>
                        <td><span style="line-height: 65px">@<%=h.getAdresse()%></span></td>
                        <td><span style="line-height: 65px"><%=h.getEtat()%></span></td>
                         <td> <%if (h.getEtoile() == 1) {%>
                            <span style="line-height: 65px">
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span></span>

                <%} else if (h.getEtoile() == 2) {%>
                <span style="line-height: 65px">
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star "></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span></span>


                <%} else if (h.getEtoile() == 3) {%>
                <span style="line-height: 65px">
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span></span>

                <%} else if (h.getEtoile() == 4) {%>
                <span style="line-height: 65px">
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star " style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star"></span></span>

                <%} else if (h.getEtoile() == 5) {%>
                <span style="line-height: 65px">
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <%}%></span></td>
                        
                         <td><a href="/PFE-MyHotel/jsp/DetailRes.jsp?idh=<%=h.getIdh()%>"<%=h.getNomh()%>><span style="line-height: 65px; font-size: 20px"><span class="badge badge-info">Plus...</span></span></a></td>
                         <td><a href="/PFE-MyHotel/jsp/AddChambre.jsp?idh=<%=h.getIdh()%>"<%=h.getNomh()%>><span style="line-height: 65px; font-size: 20px"><span class="badge badge-light">+chambre</span></span></a></td>
                         <td><span style="line-height: 65px"> <a href="/PFE-MyHotel/SupHotel?idh=<%=h.getIdh()%>"><span style="line-height: 65px; font-size: 20px"><span class="badge badge-danger">Supprimer</span></span></a></span></td>
                         <td>
                            <%if (!h.getEtat().equals("accepte")) {%>
                            <span style="line-height: 65px"> <a href="/PFE-MyHotel/jsp/EditHotel.jsp?idh=<%=h.getIdh()%>"><span style="line-height: 65px; font-size: 20px"><span class="badge badge-warning">Modifier</span></span></a></span>
                            <%}%></td>
                            
                        
                    </tr>
                    <%}%>
                </tbody>
            </table>
            <%}
            %>
            
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
                        <li class="page-item"><a class="page-link" href="/PFE-MyHotel/jsp/mesHoteles.jsp?p=<%=i%>"><%=i%></a></li>
                            <%}
                        }%>
                    </ul>

                </nav>
            </div>
            
            <%con.close();%>
            
        <jsp:include page="peid.jsp"></jsp:include>
        
    </body>
</html>

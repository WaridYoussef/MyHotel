<%-- 
    Document   : rechercheParet
    Created on : 07-avr.-2020, 16:25:05
    Author     : Utilisateur
--%>

<%@page import="ma.hotel.models.Ville"%>
<%@page import="ma.hotel.models.Responsable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ma.hotel.models.Hotel"%>
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
            int idetoile = Integer.parseInt(request.getParameter("idetoile"));
            List<Hotel> hots = new ArrayList<Hotel>();
            Connection con = DAOUtil.getConnection();
            Statement st = con.createStatement();
            String req = "select * from hotel join ville using(idville) join responsable using (idr) "
                    + " where etat='accepte' ";
            if (idetoile > 0) {
                req += " and idetoile=" + idetoile;
            }
            ResultSet rs = st.executeQuery(req);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while (rs.next()) {
                hots.add(new Hotel(rs.getInt("idh"), rs.getString("nomh"),new Ville(rs.getInt("idville"),rs.getString("nomville")), rs.getString("img"),
                        new Responsable(rs.getInt("idr"), rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),rs.getString("imgres"),sdf.parse(rs.getDate("datenaiss").toString()), null), rs.getString("etat"),
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
            Aucun resultats trouves !!
        </div>
        <%  } else {
            List<Hotel> hotsCur = hots.subList((p - 1) * nbrArtParPage, indexTo);
        %>
        <table class="table" style="margin-top: 20px">
            <thead class="thead-light">
                <tr>
                    <th scope="col"><span style="margin-left: 55px">Image</span></th>
                    <th scope="col">Hotel</th>
                    <th scope="col">Ville</th>
                    <th scope="col">Etoile</th>
                    <th scope="col">Detail</th>
                </tr>
            </thead>
            <tbody>
                <%for (Hotel h : hotsCur) {%>
                <tr>
                    <th><img class="img-fluid" src="/PFE-MyHotel/img/<%=h.getImg()%>" width="250px" height="95px"></th>
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><%=h.getNomh()%></span></td>
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><%=h.getVille().getNomville()%></span></td>
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

                    <td><a href="/PFE-MyHotel/jsp/DetailRes.jsp?idh=<%=h.getIdh()%>"<%=h.getNomh()%>><span style="line-height: 65px"><span class="badge badge-info">Plus...</span></span></a></td>
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
                    <li class="page-item"><a class="page-link" href="/PFE-MyHotel/jsp/rechercheParet.jsp?idetoile=<%=idetoile%>&p=<%=i%>"><%=i%></a></li>
                        <%}
                                }%>
                </ul>

            </nav>
        </div>
        <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

<%-- 
    Document   : listeRes
    Created on : 07-avr.-2020, 19:06:12
    Author     : Utilisateur
--%>

<%@page import="ma.hotel.models.Ville"%>
<%@page import="ma.hotel.models.Client"%>
<%@page import="ma.hotel.models.Reserv"%>
<%@page import="ma.hotel.models.Chambre"%>
<%@page import="ma.hotel.models.Responsable"%>
<%@page import="ma.hotel.models.Hotel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ma.hotel.controlers.Reservation"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="entete.jsp"></jsp:include>


        <%if (request.getAttribute("msg") != null) {%>
        <div style="margin: auto; position: relative; width: 50% " class="alert alert-<%=request.getAttribute("typemsg").toString().equals("error") ? "danger" : "primary"%> " role="alert">
            <%=request.getAttribute("msg")%>
           
        </div>

        <%}%>
        <%
            String cin = request.getParameter("cin");
            List<Reserv> Res = new ArrayList<Reserv>();
            Connection con = DAOUtil.getConnection();
            Statement st = con.createStatement();
            String req = "select * from Reservation join client using (idclt) join hotel using (idh) join ville using(idville) join chambre using(idch) where cin='" + cin + "'";

            ResultSet rs = st.executeQuery(req);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while (rs.next()) {
                Res.add(new Reserv(rs.getInt("num_res"), sdf.parse(rs.getDate("datedebut").toString()), sdf.parse(rs.getDate("datefin").toString()),
                        rs.getInt("idh"), new Chambre(rs.getString("idch"), rs.getString("imgch"), rs.getFloat("prix"), rs.getInt("idcat"),
                                new Hotel(rs.getInt("idh"), rs.getString("nomh"), new Ville(rs.getInt("idville"),rs.getString("nomville")), rs.getString("img"),
                                        null, rs.getString("etat"), rs.getString("adresse"), rs.getInt("idetoile"), sdf.parse(rs.getDate("datepub").toString())), rs.getInt("numch"), rs.getString("etatch")),
                        new Client(rs.getInt("idclt"), rs.getString("cin"), rs.getString("nomclt"), rs.getString("prenomclt"), rs.getString("villeclt"), rs.getString("adresseclt"), rs.getString("email"), rs.getString("tel"), rs.getInt("situation"))));
            }
            con.close();

            int p = 1;
            if (request.getParameter("p") != null) {
                p = Integer.parseInt(request.getParameter("p"));
            }
            int nbrArtParPage = 5;
            int nbrPages = (Res.size() % nbrArtParPage == 0) ? Res.size() / nbrArtParPage : Res.size() / nbrArtParPage + 1;
            int indexTo = p * nbrArtParPage;
            if (Res.size() % nbrArtParPage != 0 && p == nbrPages) {
                indexTo = Res.size();
            }

        %>

        <%            if (Res.size() == 0) {%>

        <div class="alert alert-danger" role="alert">
            Aucun resultats trouves !!
        </div>
        <%  } else {
            List<Reserv> chamsCur = Res.subList((p - 1) * nbrArtParPage, indexTo);
        %>
        <h3 style="text-align: center; margin-top: 40px; font-family: monospace; color: #0056b3; ">Reservations</h3>

        <table class="table" style="margin-top: 20px">
            <thead class="thead-light">
                <tr>
                    <th scope="col"><span style="margin-left: 55px">Image</span></th>
                    <th scope="col">Hotel</th>
                    <th scope="col">num chambre</th>
                    <th scope="col">Prix</th>
                    <th scope="col">categorie</th>
                    <th scope="col">Modifier</th>
                    <th scope="col">Supprimer</th>
                    <th scope="col">Reservation PDF</th>
                </tr>
            </thead>
            <tbody>
                <%for (Reserv r : chamsCur) {%>

                <tr>
                    <th><img src="/PFE-MyHotel/img/<%=r.getChambre().getImgch()%>" width="250px" height="95px"></th>
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><%=r.getChambre().getHotel().getNomh()%></span></td>

                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px; margin-left: 17px"><%=r.getChambre().getNumch()%></span></td>
                    <td><h4 style="color: green"><span style="line-height: 65px"><%=r.getChambre().getPrix()%> DH</span></h4></td>


                    <% if (r.getChambre().getIdcat() == 1) {%>
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px">1personne </span></td>
                    <%}%>
                    <% if (r.getChambre().getIdcat() == 2) {%>
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px">2personne </span></td>
                    <%}%>
                    <% if (r.getChambre().getIdcat() == 3) {%>
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px">Familiale </span></td>
                    <%}%>
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><a href="/PFE-MyHotel/jsp/formModifier.jsp?numres=<%=r.getNum_res()%>"><span class="badge badge-warning">Modifier</span></a></span></td>
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><a href="/PFE-MyHotel/serSupp?numres=<%=r.getNum_res()%>&idclt=<%=r.getClient().getIdclt()%>&idch=<%=r.getChambre().getIdch()%>&cin=<%=r.getClient().getCin()%>"><span class="badge badge-danger">Annuler</span></a></span></td>
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><a href="/PFE-MyHotel/jsp/FicheRes.jsp?numres=<%=r.getNum_res()%>"><span class="badge badge-secondary"><img src="/PFE-MyHotel/img/download.png">telecharger</span></a></span></td>
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

                    <li class="page-item"><a class="page-link" href="&p=<%=i%>"><%=i%></a></li>
                        <%}
                                }%>
                </ul>

            </nav>
        </div>







        <div style="height: 260px"></div>

        <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

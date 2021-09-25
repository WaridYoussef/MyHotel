

<%@page import="ma.hotel.models.Ville"%>
<%@page import="ma.hotel.models.Client"%>
<%@page import="ma.hotel.models.Hotel"%>
<%@page import="ma.hotel.models.Chambre"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ma.hotel.models.Reserv"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
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
            Connection con = DAOUtil.getConnection();
            List<Reserv> Res = new ArrayList<Reserv>();
            int idr = Integer.parseInt(request.getParameter("idr"));
            String req = "select *from reservation join client using (idclt) join hotel using(idh) join ville using(idville) join chambre using (idch)"
                    + "where etatch='reserve' and idr=" + idr;

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(req);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while (rs.next()) {
                Res.add(new Reserv(rs.getInt("num_res"), sdf.parse(rs.getDate("datedebut").toString()), sdf.parse(rs.getDate("datefin").toString()),
                        rs.getInt("idh"), new Chambre(rs.getString("idch"), rs.getString("imgch"), rs.getFloat("prix"), rs.getInt("idcat"),
                                new Hotel(rs.getInt("idh"), rs.getString("nomh"), new Ville(rs.getInt("idville"), rs.getString("nomville")), rs.getString("img"),
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


        <%  if (Res.size() == 0) {%>

        <div class="alert alert-danger" role="alert">
            Aucun resultats trouves  !!
        </div>
        <%  } else {
            List<Reserv> chamsCur = Res.subList((p - 1) * nbrArtParPage, indexTo);
        %>

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
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><a href="/PFE-MyHotel/jsp/RespoformModifier.jsp?numres=<%=r.getNum_res()%>&idr=<%=idr%>"><span class="badge badge-warning">Modifier</span></a></span></td>
                    <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><a href="/PFE-MyHotel/ResposerSupp?numres=<%=r.getNum_res()%>&idclt=<%=r.getClient().getIdclt()%>&idch=<%=r.getChambre().getIdch()%>&idr=<%=idr%>"><span class="badge badge-danger">Annuler</span></a></span></td>
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

                    <li class="page-item"><a class="page-link" href="/PFE-MyHotel/jsp/resRespo.jsp?idr=<%=idr%>&p=<%=i%>"><%=i%></a></li>
                        <%}
                            }%>
                </ul>

            </nav>
        </div>

        <div style="height: 300px; margin-top: 20px">
            <form action="/PFE-MyHotel/verifierDatefin?idr=<%=idr%>" method="post">
                <div style="text-align: center">
                    <button type="submit" class="btn btn-primary" style="width: 200px; margin-top: 150px"><img src="/PFE-MyHotel/img/refresh.png">Actualiser</button>
                </div>      
            </form>
        </div>

        <jsp:include page="peid.jsp"></jsp:include>

    </body>
</html>

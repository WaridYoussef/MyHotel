<%-- 
    Document   : recherche
    Created on : 04-avr.-2020, 18:02:19
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
        <div class="container">
        
         <%
             
                
                int idville = Integer.parseInt(request.getParameter("idville"));
                String mot = request.getParameter("mot");
                 List<Hotel> hots = new ArrayList<Hotel>();
                Connection con = DAOUtil.getConnection();
                Statement st = con.createStatement();
                String req = "select * from hotel join ville using (idville) join responsable using (idr) "
                        + " where etat='accepte' ";
                
                if (idville > 0) {
                    req += " and idville=" + idville;
                }
                if (request.getParameter("mot") != null) {
                    req += " and lower(nomh) like '%" + mot + "%' order by datepub desc ";
                }
                ResultSet rs = st.executeQuery(req);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                while (rs.next()) {
                     hots.add(new Hotel(rs.getInt("idh"), rs.getString("nomh"), new Ville(rs.getInt("idville"),rs.getString("nomville")), rs.getString("img"),
             new Responsable(rs.getInt("idr"),rs.getString("nom"),rs.getString("prenom"),rs.getString("email") ,rs.getString("imgres"),sdf.parse(rs.getDate("datenaiss").toString()), null),rs.getString("etat"),     
            rs.getString("adresse"),rs.getInt("idetoile"),sdf.parse(rs.getDate("datepub").toString())));
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
           <article style="display: flex; justify-content: center; width: 100%; ">
<div style="width: 100%; display: inline-block;  margin: auto 0; text-align: center; ">
                    
                    <%for (Hotel h : hotsCur) {%>
                    
                    <div class="card text-white m-4 wow bounceInUp" style="display: inline-block; width: 45%; height: 265px; background-color: chocolate;">
  <img
      src="/PFE-MyHotel/img/<%=h.getImg()%>"
      class="card-img" style="height: 100%"
    alt="..."
  />
  <div class="card-img-overlay">
  	
      <h5 class="card-title" style="font-size: 25px; background-color: gray; opacity: 0.70;"><%=h.getNomh()%></h5>
      <p class="card-text">
     <%=h.getVille().getNomville()%>
    </p>
    <p class="card-text">
        
        <%if (h.getEtoile() == 1) {%>
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
                <%}%></span>
                
    <div>
          <a href="/PFE-MyHotel/jsp/DetailRes.jsp?idh=<%=h.getIdh()%>"<%=h.getNomh()%>> <button  data-mdb-toggle="tooltip" data-mdb-placement="bottom" title="voir les chambre" type="button" class="btn btn-dark" ><i class="far fa-eye"></i></button></a>
    </div>
        
    </p>
  </div>
    
                    
      </div>              
                    
                    
                 
                    <%}%>
                    </div>
           </article>
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
                        <li class="page-item"><a class="page-link" href="/PFE-MyHotel/jsp/recherche.jsp?mot=<%=mot%>&idville=<%=idville%>&p=<%=i%>"><%=i%></a></li>
                            <%}
                                }%>
                    </ul>

                </nav>
            </div>
         
        <jsp:include page="peid.jsp"></jsp:include>
        </div>
    </body>
</html>

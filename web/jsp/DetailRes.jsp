<%-- 
    Document   : DetailRes
    Created on : 01-avr.-2020, 21:40:34
    Author     : Utilisateur
--%>


<%@page import="ma.hotel.models.Ville"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="ma.hotel.models.Chambre"%>
<%@page import="java.sql.Statement"%>
<%@page import="ma.hotel.models.Responsable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="ma.hotel.models.Hotel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
                      
                      Connection con=DAOUtil.getConnection();
                      int idh=Integer.parseInt(request.getParameter("idh"));
                List<Chambre> chams = new ArrayList<Chambre>();
                
                
                
               
               String req= "select * from chambre join hotel using (idh) join ville using (idville) where etatch='disponible' and  idh="+idh  ;
                Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery(req);
                
                
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
               while (rs.next()) {
                    chams.add ( new Chambre(rs.getString("idch"), rs.getString("imgch"), rs.getFloat("prix"), rs.getInt("idcat"), 
                           new Hotel(rs.getInt("idh"),rs.getString("nomh"),new Ville(rs.getInt("idville"),rs.getString("nomville")),rs.getString("img"),
                             null,rs.getString("etat"),rs.getString("adresse"),rs.getInt("idetoile"),sdf.parse(rs.getDate("datepub").toString())),rs.getInt("numch"),rs.getString("etatch")));
                }
               
               
               
               
                 con.close();
                
                int p = 1;
                if (request.getParameter("p") != null) {
                    p = Integer.parseInt(request.getParameter("p"));
                }
                int nbrArtParPage = 5;
                int nbrPages = (chams.size() % nbrArtParPage == 0) ? chams.size() / nbrArtParPage : chams.size() / nbrArtParPage + 1;
                int indexTo = p * nbrArtParPage;
                if (chams.size() % nbrArtParPage != 0 && p == nbrPages) {
                    indexTo = chams.size();
                }
            %>  
            
            
            
            
                <%            if (chams.size() == 0) {%>

            <div class="alert alert-danger" role="alert">
                Aucun resultats trouves !!
            </div>
          <%  } else {
                List<Chambre> chamsCur = chams.subList((p - 1) * nbrArtParPage, indexTo);
            %>
            
           
            
            
            
                 <table class="table" style="margin-top: 20px">
                <thead class="thead-light">
                    <tr>
                        <th scope="col"><span style="margin-left: 55px">Image</span></th>
                        <th scope="col">Hotel</th>
                        
                        <th scope="col">num chambre</th>
                        <th scope="col">Prix</th>
                        <th scope="col">categorie</th>                  
                        <th scope="col">Detail</th>    
                        <%if (session.getAttribute("r") != null){%>
                        <th scope="col">Supprimer</th>
                        <th scope="col">Modifier</th>
                        <%}%>
                    </tr>
                </thead>
                <tbody>
                    <%for (Chambre ch : chamsCur) {%>
                    <tr>
                        <th><img src="/PFE-MyHotel/img/<%=ch.getImgch()%>" width="250px" height="95px"></th>
                        <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><%=ch.getHotel().getNomh()%></span></td>
                        
                        <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px; margin-left: 17px"><%=ch.getNumch()%></span></td>
                        <td><h4 style="color: green"><span style="line-height: 65px"><%=ch.getPrix()%> DH</span></h4></td>
                        
                       <% if(ch.getIdcat()==1){%>
                        <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px">1personne </span></td>
                       <%}%>
                       <% if(ch.getIdcat()==2){%>
                        <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px">2personne </span></td>
                       <%}%>
                       <% if(ch.getIdcat()==3){%>
                        <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px">Familiale </span></td>
                       <%}%>
                       <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><a href="/PFE-MyHotel/jsp/Reserver.jsp?idch=<%=ch.getIdch()%>"><span class="badge badge-info">Plus...</span></a></span></td>
                      
                       <%if (session.getAttribute("r") != null){%>
                       <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><a href="/PFE-MyHotel/SuppChambre?idch=<%=ch.getIdch()%>"><span class="badge badge-danger">Supprimer</span></a></span></td>
                       <td><span style="line-height: 65px; font-family: sans-serif; font-size: 22px"><a href="/PFE-MyHotel/jsp/ModifChambre.jsp?idch=<%=ch.getIdch()%>"><span class="badge badge-warning">Modifier</span></a></span></td>
                   <%}%>
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
                        
                        <li class="page-item"><a class="page-link" href="/PFE-MyHotel/jsp/DetailRes.jsp?idh=<%=idh%>&p=<%=i%>"><%=i%></a></li>
                            <%}
                                }%>
                    </ul>

                </nav>
            </div>
                
               
                                


                
           
                   
           
            
                                <jsp:include page="peid.jsp"></jsp:include>
     
    </body>
</html>

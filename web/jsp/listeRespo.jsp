<%-- 
    Document   : listeRespo
    Created on : 11-avr.-2020, 1:13:48
    Author     : Utilisateur
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ma.hotel.models.Compte"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
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
            
            
            <%
             List<Responsable> respos = new ArrayList<Responsable>();
            Connection con=DAOUtil.getConnection();
            String req="select *from responsable join compte using (login)";
            Statement st=con.createStatement();
            ResultSet rs=st.executeQuery(req);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while(rs.next()){
                respos.add(new Responsable(rs.getInt("idr"),rs.getString("nom"),rs.getString("prenom"),rs.getString("email"), rs.getString("imgres"),sdf.parse(rs.getDate("datenaiss").toString()),
                new Compte(rs.getString("login"),rs.getString("mdp"),rs.getString("role"))));
            }
            
            
            %>
            
            <h3 style="text-align: center; margin-top: 40px; font-family: monospace; color: #0056b3; ">Liste Responsables</h3>
            <table class="table" style="margin-top: 20px">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Image</th>
                        <th scope="col">Nom</th>
                        <th scope="col">Prenom</th>
                        <th scope="col">Voir le Profil</th>
                         <th scope="col">Hotels</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <%for (Responsable r : respos) {%>
                    <tr>
                         <th><img src="/PFE-MyHotel/img/<%=r.getImgres()%>" width="200px" height="95px"></th>
                        <td><span style="line-height: 65px"><%=r.getNom()%></span></td>
                        <td><span style="line-height: 65px"><%=r.getPrenom()%></span></td>
                        <td><span style="line-height: 65px"><a href="/PFE-MyHotel/jsp/ProfilRespo.jsp?idr=<%=r.getIdr()%> "><span class="badge badge-info">---></span></a></span></td>
                        <td><span style="line-height: 65px"><a href="/PFE-MyHotel/jsp/RespoHoteles.jsp?idr=<%=r.getIdr()%> "><span class="badge badge-info">Hoteles</span></a></span></td>
                    </tr>
                
                    <%}%>
                </tbody>
            </table>
               
            <%con.close();%>
            <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

<%-- 
    Document   : Reserver
    Created on : 06-avr.-2020, 22:08:47
    Author     : Utilisateur
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
            String idch = request.getParameter("idch");
            String etatch = request.getParameter("etatch");
            Connection con = DAOUtil.getConnection();
            PreparedStatement ps = con.prepareStatement("select *from chambre where idch=?");
            ps.setString(1, idch);
            
            ResultSet rs = ps.executeQuery();
            

        %>

        <%if (rs.next()) {%>
        <div class="container" style="height: 1100px; margin-top: 40px">
            <div >
                <img src="/PFE-MyHotel/img/<%=rs.getString("imgch")%>" style="width: 700px; height: 270px; margin-left: 19%">
                <h4 style="margin-left: 44%; margin-top: 23px">num chambre:<span style="margin-left: 10px"> <%=rs.getInt("numch")%></span> </h4>
                <h4 style="margin-left: 47%; color: green"><%=rs.getFloat("prix")%> DH</h4>
            </div>

            <form style="width: 90%; margin-left: 7%; margin-top: 50px" action="/PFE-MyHotel/Reservation" method="post">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="inputEmail4">Nom</label>
                        <input type="text" class="form-control" id="inputEmail4" name="nom">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="inputPassword4">Prenom</label>
                        <input type="text" class="form-control" id="inputPassword4" name="prenom">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputAddress">CIN</label>
                    <input type="text" class="form-control" id="inputAddress" placeholder="CIN" name="cin">
                </div>
                <div class="form-group">
                    <label for="inputAddress">Email</label>
                    <input type="email" class="form-control" id="inputAddress" placeholder="Email" name="email">
                </div>
                <div class="form-group">
                    <label for="inputAddress2">Address</label>
                    <input type="text" class="form-control" id="inputAddress2" placeholder="Region,Rue,..." name="adresse">
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="inputCity">Ville</label>
                        <input type="text" class="form-control" id="inputCity" name="ville">
                    </div>
                    <div class="form-group col-md-4">

                        <label for="inputState">Categorie</label>
                        <select id="inputState" class="form-control">
                            <% if (rs.getInt("idcat") == 1) {%>
                            <option selected>1Personne</option>
                            <%}%>
                            <% if (rs.getInt("idcat") == 2) {%>
                            <option selected>2Personne</option>
                            <%}%>
                            <% if (rs.getInt("idcat") == 3) {%>
                            <option selected>Familiale</option>
                            <%}%>
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <label for="inputZip">tele</label>
                        <input type="text" class="form-control" id="inputZip" name="tele">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="inputEmail4">Date Debut</label>
                        <input type="date" class="form-control" id="inputEmail4" name="dated">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="inputPassword4">Date Fin</label>
                        <input type="date" class="form-control" id="inputPassword4" name="datef">
                    </div>
                </div>
                <div class="form-group" style="text-align: center">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="gridCheck" name="marie">
                        <label class="form-check-label" for="gridCheck">
                            Marie?
                        </label>
                    </div>
                </div>
                <div style="text-align: center">
                    <button type="submit" class="btn btn-primary" style="width: 200px">Reserver</button>
                </div>
                        <input value="<%=idch%>" name="idch" hidden >
                            <input value="<%=rs.getInt("idh")%>" name="idh" hidden >
            </form>


                            
        </div>
        <%}%>
      
        <%con.close();%>
        <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

<%-- 
    Document   : RespoformModifier
    Created on : 12-avr.-2020, 22:59:40
    Author     : Utilisateur
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ma.hotel.models.Reserv"%>
<%@page import="ma.hotel.models.Client"%>
<%@page import="ma.hotel.models.Hotel"%>
<%@page import="ma.hotel.models.Chambre"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="ma.hotel.controlers.Reservation"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
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
    
        <%Connection con = DAOUtil.getConnection();
            int num_res = Integer.parseInt(request.getParameter("numres"));
            int idr=Integer.parseInt(request.getParameter("idr"));
            List<Reserv> Res = new ArrayList<Reserv>();
            String req = "select *from Reservation join client using (idclt) join hotel using (idh) join chambre using(idch)"
                    + " where  num_res=" + num_res + " and idr="+idr;

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(req);

            

        %>

        <%if(rs.next()){%>
           <div class="container" style="height: 1000px; margin-top: 40px">
            <div >
                <img src="/PFE-MyHotel/img/<%=rs.getString("imgch")%>" style="width: 700px; height: 270px; margin-left: 19%">
            </div>

            <form style="width: 90%; margin-left: 7%; margin-top: 50px" action="/PFE-MyHotel/ResposerModif?idr=<%=idr%>" method="post">
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="inputEmail4">Nom</label>
                        <input type="text" value="<%=rs.getString("nomclt")%>" class="form-control" id="inputEmail4" name="nom">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="inputPassword4">Prenom</label>
                        <input type="text" value="<%=rs.getString("prenomclt")%>" class="form-control" id="inputPassword4" name="prenom">
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputAddress">CIN</label>
                    <input type="text" value="<%=rs.getString("cin")%>" class="form-control" id="inputAddress" placeholder="CIN" name="cin">
                </div>
                <div class="form-group">
                    <label for="inputAddress">Email</label>
                    <input type="email" value="<%=rs.getString("email")%>" class="form-control" id="inputAddress" placeholder="Email" name="email">
                </div>
                <div class="form-group">
                    <label for="inputAddress2">Address</label>
                    <input type="text" value="<%=rs.getString("adresseclt")%>" class="form-control" id="inputAddress2" placeholder="Region,Rue,..." name="adresse">
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="inputCity">Ville</label>
                        <input type="text" value="<%=rs.getString("villeclt")%>" class="form-control" id="inputCity" name="ville">
                    </div>
                    <div class="form-group col-md-4">

                        <label for="inputState">Categorie</label>
                        <select id="inputState" class="form-control">
                            <%if(rs.getInt("idcat")==1){%>
                            <option selected>1Personne</option>
                            <%}%>
                             <%if(rs.getInt("idcat")==2){%>
                            <option selected>2Personne</option>
                            <%}%>
                             <%if(rs.getInt("idcat")==3){%>
                            <option selected>Familiale</option>
                            <%}%>
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <label for="inputZip">tele</label>
                        <input type="tel" value="<%=rs.getString("tel")%>" class="form-control" id="inputZip" name="tele">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="inputEmail4">Date Debut</label>
                        <input type="date" value="<%=rs.getDate("datedebut")%>" class="form-control" id="inputEmail4" name="dated">
                    </div>
                    <div class="form-group col-md-6">
                        <label for="inputPassword4">Date Fin</label>
                        <input type="date" value="<%=rs.getDate("datefin")%>" class="form-control" id="inputPassword4" name="datef">
                    </div>
                </div>
                <div class="form-group" style="text-align: center">
                    <div class="form-check">
                        <%if(rs.getInt("situation")==1){%>
                        <input class="form-check-input" type="checkbox" id="gridCheck" name="marie" checked>
                        <label class="form-check-label" for="gridCheck">
                            Marie?
                        </label>
                        <%}else{%>
                        <input class="form-check-input" type="checkbox" id="gridCheck" name="marie" >
                        <label class="form-check-label" for="gridCheck">
                            Marie?
                        </label>
                        <%}%>
                        
                    </div>
                </div>
                <div style="text-align: center">
                    <button type="submit" class="btn btn-primary" style="width: 200px">Modifier</button>
                </div>
                        <input value="<%=rs.getInt("num_res")%>" name="numres" hidden >
                        <input value="<%=rs.getInt("idclt")%>" name="idclt" hidden >
            </form>
             
        </div>
     <%}%>
<%con.close();%>
<jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

<%-- 
    Document   : ModifChambre
    Created on : 10-avr.-2020, 14:53:59
    Author     : Utilisateur
--%>

<%@page import="java.sql.Statement"%>
<%@page import="ma.hotel.models.Ville"%>
<%@page import="ma.hotel.models.Hotel"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="ma.hotel.models.Chambre"%>
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
            Chambre ch = null;
            String idch = request.getParameter("idch");
            Connection con = DAOUtil.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from chambre join hotel using(idh) join ville using(idville) join responsable using (idr) where  idch=? ");
            ps.setString(1, idch);
            ResultSet rs = ps.executeQuery();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if (rs.next()) {
                ch = new Chambre(rs.getString("idch"), rs.getString("imgch"), rs.getFloat("prix"), rs.getInt("idcat"), 
                           new Hotel(rs.getInt("idh"),rs.getString("nomh"),new Ville(rs.getInt("idville"),rs.getString("nomville")),rs.getString("img"),
                             null,rs.getString("etat"),rs.getString("adresse"),rs.getInt("idetoile"),sdf.parse(rs.getDate("datepub").toString())),rs.getInt("numch"),rs.getString("etatch"));
            }

            Statement st = con.createStatement();
            rs = st.executeQuery("select * from categorie");

           

        %>
         
         <div class="card" style="margin: auto; position: relative; width: 70%; margin-top: 30px; margin-bottom: 20px">
                <div class="card-header">
                    Formulaire nouvel Chambre
                </div>
                <div class="card-body">
                    <h5 class="card-title">Entre les donnees de votre Chambre </h5>
                    
                    <form class="was-validated" enctype="multipart/form-data" method="post" action="/PFE-MyHotel/modifChambre">

                <div class="form-group">
                    <label for="inputPassword6">idch</label>
                    <input type="text" id="idch" value="<%=ch.getIdch()%>" name="idch" id="inputPassword6" class="form-control mx-sm-3" aria-describedby="passwordHelpInline">
                    <small id="passwordHelpInline" class="text-muted">
                        
                    </small>
                </div>  
                        <div class="form-group">
                    <label for="inputPassword6">num chambre</label>
                    <input type="text" value="<%=ch.getNumch()%>" name="numch" id="inputPassword6" class="form-control mx-sm-3" aria-describedby="passwordHelpInline">
                    <small id="passwordHelpInline" class="text-muted">
                        
                    </small>
                </div>  


                <div class="form-group">
                    <label for="inputPassword6">Prix</label>
                    <input type="text" value="<%=ch.getPrix()%>" name="prix" id="inputPassword6" class="form-control mx-sm-3" aria-describedby="passwordHelpInline">
                    <small id="passwordHelpInline" class="text-muted">
                        
                    </small>
                </div>  

                <div class="form-group">
                    <select class="custom-select" required name="cat">
                        <option value="">Choisir categorie</option>
                        <% rs = st.executeQuery("select * from categorie");
                            while (rs.next()) {%>
                        <option value="<%=rs.getInt(1)%>" <%=rs.getInt(1)==ch.getIdcat()? "selected":"" %>><%=rs.getString(2)%></option>
                        <%}
                            rs.close();
                            
                        %>
                    </select>
                    <div class="invalid-feedback">Vous devrez choisir une categorie</div>
                </div>
                    
                   
                    
                    <img src="/PFE-MyHotel/img/<%=ch.getImgch()%>" width="60px" height="40px">

                <div class="custom-file">
                    <input type="file" name="imgch" class="custom-file-input" id="validatedCustomFile" required>
                    <label class="custom-file-label" for="validatedCustomFile">Choisissez une image...</label>
                    <div class="invalid-feedback">Vous devrez choisir une image</div>
                </div>
                    <button type="submit" class="btn btn-primary" style="margin-left: 350px">Sauvgarder Chambre</button>
                    <input type="text" value="<%=ch.getIdch()%>" name="idcha" hidden>
                    <input type="hidden" name="imgch" value="<%=ch.getImgch()%>">
                    <input type="text" value="<%=ch.getHotel().getIdh()%>" name="idh" hidden>
            </form>
                </div>
            </div>
                        <%con.close();%>
         <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

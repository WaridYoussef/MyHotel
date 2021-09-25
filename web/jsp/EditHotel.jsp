<%-- 
    Document   : EditHotel
    Created on : 09-avr.-2020, 0:37:16
    Author     : Utilisateur
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ma.hotel.models.Etoile"%>
<%@page import="java.sql.Statement"%>
<%@page import="ma.hotel.models.Ville"%>
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
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="entete.jsp"></jsp:include>
        <%
            Hotel h = null;
            int idh = Integer.parseInt(request.getParameter("idh"));
            Connection con = DAOUtil.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from hotel join ville using(idville) join responsable using (idr) where etat='en cours' and idh=? ");
            ps.setInt(1, idh);
            ResultSet rs = ps.executeQuery();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            if (rs.next()) {
                h = new Hotel(rs.getInt("idh"), rs.getString("nomh"), new Ville(rs.getInt("idville"), rs.getString("nomville")), rs.getString("img"),
                        new Responsable(rs.getInt("idr"), rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),rs.getString("imgres"),sdf.parse(rs.getDate("datenaiss").toString()), null), rs.getString("etat"),
                        rs.getString("adresse"), rs.getInt("idetoile"), sdf.parse(rs.getDate("datepub").toString()));
            }

            Statement st = con.createStatement();
            rs = st.executeQuery("select * from ville");

            Statement ste = con.createStatement();
            ResultSet rse = ste.executeQuery("select * from etoile");
            List<Etoile> etoiles = new ArrayList<Etoile>();

        %>

        <div class="card" style="margin: auto; position: relative; width: 70%; margin-top: 30px; margin-bottom: 20px">
            <div class="card-header">
                Modifier l'Hotel
            </div>
            <div class="card-body">
                <h5 class="card-title">Entre les donnees de votre Hotel </h5>

                <form class="was-validated" enctype="multipart/form-data" method="post" action="/PFE-MyHotel/EditHotel">

                    <div class="form-group">
                        <label for="inputPassword6">Nom Hotel</label>
                        <input type="text" name="nomh" value="<%=h.getNomh()%>" id="inputPassword6" class="form-control mx-sm-3" aria-describedby="passwordHelpInline">
                        <small id="passwordHelpInline" class="text-muted">

                        </small>

                    </div>  


                    <div class="mb-3">
                        <label for="validationTextarea">Adresse</label>
                        <textarea  name="adresse" value="<%=h.getAdresse()%>" class="form-control is-invalid" id="validationTextarea"  placeholder="Adresse" required><%=h.getAdresse()%></textarea>
                        <div class="invalid-feedback">

                        </div>
                    </div>

                    <div class="form-group">
                        <select class="custom-select" required name="ville">
                            <option value="">Choisir Ville</option>
                            <% rs = st.executeQuery("select * from ville");
                            while (rs.next()) {%>
                             <option value="<%=rs.getInt(1)%>" <%=rs.getInt(1)==h.getVille().getIdville()? "selected":"" %>><%=rs.getString(2)%></option>
                            <%}
                                rs.close();

                            %>
                        </select>
                        <div class="invalid-feedback">Vous devrez choisir une categorie</div>
                    </div>

                    <div class="form-group">
                        <select class="custom-select" required name="etoile">
                            <option value="">Etoiles</option>
                            <% rse = ste.executeQuery("select * from etoile");
                            while (rse.next()) {%>
                            <option value="<%=rse.getInt(1)%>" <%=rse.getInt(1)==h.getEtoile()? "selected":"" %>><%=rse.getInt(1)%></option>
                            <%}
                                rse.close();

                            %>
                        </select>
                        <div class="invalid-feedback">Vous devrez choisir une categorie</div>
                    </div>

                        <img src="/PFE-MyHotel/img/<%=h.getImg()%>" width="60px" height="40px">

                    <div class="custom-file">
                        <input type="file" name="img" class="custom-file-input" id="validatedCustomFile" required>
                        <label class="custom-file-label" for="validatedCustomFile">Choisissez une image...</label>
                        <div class="invalid-feedback">Vous devrez choisir une image</div>
                    </div>
                    <button type="submit" class="btn btn-primary" style="margin-left: 350px">Sauvgarder l'Hotel</button>
                    
                    <input type="hidden" name="idh" value="<%=idh%>">
                    <input type="hidden" name="img" value="<%=h.getImg()%>">
                
                </form>
            </div>
        </div>
        <%con.close();%>
        <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

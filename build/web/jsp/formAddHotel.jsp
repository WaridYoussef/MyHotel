<%-- 
    Document   : formAddHotel
    Created on : 08-avr.-2020, 22:57:40
    Author     : Utilisateur
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="javax.swing.border.EtchedBorder"%>
<%@page import="java.util.List"%>
<%@page import="ma.hotel.models.Etoile"%>
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
         
          <%

                Connection con = DAOUtil.getConnection();

                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from ville");

                Statement ste = con.createStatement();
                ResultSet rse = ste.executeQuery("select * from etoile");
                List<Etoile> etoiles=new ArrayList<Etoile>();
            %>
         
        <div class="card" style="margin: auto; position: relative; width: 70%; margin-top: 30px; margin-bottom: 20px">
                <div class="card-header">
                    Formulaire nouvel Hotel
                </div>
                <div class="card-body">
                    <h5 class="card-title">Entre les donnees de votre Hotel </h5>
                    
                    <form class="was-validated" enctype="multipart/form-data" method="post" action="/PFE-MyHotel/AddHotel">

                <div class="form-group">
                    <label for="inputPassword6">Nom Hotel</label>
                    <input type="text" name="nomh" id="inputPassword6" class="form-control mx-sm-3" aria-describedby="passwordHelpInline">
                    <small id="passwordHelpInline" class="text-muted">
                        
                    </small>
                </div>  


                <div class="mb-3">
                    <label for="validationTextarea">Adresse</label>
                    <textarea name="adresse" class="form-control is-invalid" id="validationTextarea" placeholder="Adresse" required></textarea>
                    <div class="invalid-feedback">

                    </div>
                </div>

                <div class="form-group">
                    <select class="custom-select" required name="ville">
                        <option value="">Choisir Ville</option>
                        <% rs = st.executeQuery("select * from ville");
                            while (rs.next()) {%>
                        <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                        <%}
                            rs.close();
                            
                        %>
                    </select>
                    <div class="invalid-feedback">Vous devrez choisir ville</div>
                </div>
                    
                   <div class="form-group">
                    <select class="custom-select" required name="etoile">
                        <option value="">Etoiles</option>
                        <% rse = ste.executeQuery("select * from etoile");
                            while (rse.next()) {%>
                        <option value="<%=rse.getInt(1)%>"><%=rse.getInt(1)%></option>
                        <%}
                            rse.close();
                            
                        %>
                    </select>
                    <div class="invalid-feedback">etoiles?</div>
                </div>
                    
                    

                <div class="custom-file">
                    <input type="file" name="img" class="custom-file-input" id="validatedCustomFile" required>
                    <label class="custom-file-label" for="validatedCustomFile">Choisissez une image...</label>
                    <div class="invalid-feedback">Vous devrez choisir une image</div>
                </div>
                    <button type="submit" class="btn btn-primary" style="margin-left: 350px">Sauvgarder l'Hotel</button>
            </form>
                </div>
            </div>
                    <%con.close();%>
         <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

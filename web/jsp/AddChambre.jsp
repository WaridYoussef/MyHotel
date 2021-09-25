<%-- 
    Document   : AddChambre
    Created on : 09-avr.-2020, 0:45:00
    Author     : Utilisateur
--%>

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
            int idh=Integer.parseInt(request.getParameter("idh"));
        Connection con = DAOUtil.getConnection();

                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from categorie");
        
        %>
        <div class="card" style="margin: auto; position: relative; width: 70%; margin-top: 30px; margin-bottom: 20px">
                <div class="card-header">
                    Formulaire nouvel Chambre 
                </div>
                <div class="card-body">
                    <h5 class="card-title">Entre les donnees de votre Chambre </h5>
                    
                    <form class="was-validated" enctype="multipart/form-data" method="post" action="/PFE-MyHotel/AddChambre">

                <div class="form-group">
                    <label for="inputPassword6">idch</label>
                    <input type="text" name="idch" id="inputPassword6" class="form-control mx-sm-3" aria-describedby="passwordHelpInline">
                    <small id="passwordHelpInline" class="text-muted">
                        
                    </small>
                </div>  
                        <div class="form-group">
                    <label for="inputPassword6">num chambre</label>
                    <input type="text" name="numch" id="inputPassword6" class="form-control mx-sm-3" aria-describedby="passwordHelpInline">
                    <small id="passwordHelpInline" class="text-muted">
                        
                    </small>
                </div>  


                <div class="form-group">
                    <label for="inputPassword6">Prix</label>
                    <input type="text" name="prix" id="inputPassword6" class="form-control mx-sm-3" aria-describedby="passwordHelpInline">
                    <small id="passwordHelpInline" class="text-muted">
                        
                    </small>
                </div>  

                <div class="form-group">
                    <select class="custom-select" required name="cat">
                        <option value="">Choisir categorie</option>
                        <% rs = st.executeQuery("select * from categorie");
                            while (rs.next()) {%>
                        <option value="<%=rs.getInt(1)%>"><%=rs.getString(2)%></option>
                        <%}
                            rs.close();
                            
                        %>
                    </select>
                    <div class="invalid-feedback">Vous devrez choisir une categorie</div>
                </div>
                    
                   
                    
                    

                <div class="custom-file">
                    <input type="file" name="imgch" class="custom-file-input" id="validatedCustomFile" required>
                    <label class="custom-file-label" for="validatedCustomFile">Choisissez une image...</label>
                    <div class="invalid-feedback">Vous devrez choisir une image</div>
                </div>
                        <input type="number" value="<%=idh%>" name="idh" hidden>
                    <button type="submit" class="btn btn-primary" style="margin-left: 350px">Sauvgarder Chambre</button>
                    
            </form>
                </div>
            </div>
                        <%con.close();%>
        <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

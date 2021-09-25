<%-- 
    Document   : entrerCin
    Created on : 07-avr.-2020, 18:45:13
    Author     : Utilisateur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <jsp:include page="entete.jsp"></jsp:include>
         <form style="width: 90%; margin-left: 7%; margin-top: 50px" action="/PFE-MyHotel/jsp/listeRes.jsp">
                <div class="form-row">
                   
                    
                </div>
                <div class="form-group">
                    <label for="inputAddress">CIN</label>
                    <input type="text" class="form-control" id="inputAddress" placeholder="CIN" name="cin">
                </div>
                
                
                
               
               
                <div style="text-align: center">
                    <button type="submit" class="btn btn-primary" style="width: 200px">Envoyer</button>
                </div>
                        
            </form>
        <div style="margin-top: 330px">
            
        </div>
         <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

<%-- 
    Document   : recupererMdp
    Created on : 07-avr.-2020, 17:41:07
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
        <div class="container">
            <jsp:include page="entete.jsp"></jsp:include>
            
            <%
            if(session.getAttribute("r")!=null){
                request.getRequestDispatcher("/jsp/mesHoteles.jsp").forward(request, response);
            }
            
           
            
            %>
            
            
            
            
            <%if (request.getAttribute("msg") != null) {%>
            <div style="margin: auto; position: relative; width: 50% " class="alert alert-<%=request.getAttribute("typemsg").toString().equals("error") ? "danger": "primary"%> " role="alert">
                <%=request.getAttribute("msg")%>
            </div>

            <% }%>




            <div id="loginbox" style="margin-top: 50px;" class="mainbox col-lg-6 offset-md-3 col-md-8 offset-sm-2">
                <div class="card card-inverse card-info">
                    <div class="card-header">
                        <div class="card-title">Formulaire de recuperation de mot de passe</div>

                    </div>
                </div>
                <div style="padding-top: 30px;" class="card-block">
                    <div style="display: none;" id="login-alert" class="alert alert-danger col-md-12"></div>
                    <form id="loginform" class="" role="form" method="post" action="/PFE-MyHotel/jsp/formReponseQuestionsecret.jsp">
                        <div class="col-auto">
                            <label class="sr-only" for="inlineFormInputGroup">Votre identifient</label>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">Login</div>
                                </div>
                                <input type="text" name="login" class="form-control" id="inlineFormInputGroup" placeholder="Login">
                            </div>
                        </div>
                        
                       
                        <div style="margin-top: 10px;" class="form-group">
                            <!-- Button -->
                            <div class="col-md-12 controls"> <button type="submit" id="btn-login" href="#" class="btn btn-success">Continuer</button>
                                <a id="btn-fblogin"
                                   href="#" class="btn btn-danger">Annuler</a>
                            </div>
                        </div>
                        
                    </form>
                </div>
            </div>






            <jsp:include page="peid.jsp"></jsp:include>
        </div>
    </body>
</html>

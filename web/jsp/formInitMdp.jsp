<%-- 
    Document   : formInitMdp
    Created on : 07-avr.-2020, 17:31:36
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

            <%if (request.getAttribute("msg") != null) {%>
            <div style="margin: auto; position: relative; width: 50% " class="alert alert-<%=request.getAttribute("typemsg").toString().equals("error") ? "danger": "primary"%> " role="alert">
                <%=request.getAttribute("msg")%>
            </div>

            <% }%>




            <div id="loginbox" style="margin-top: 50px;" class="mainbox col-lg-6 offset-md-3 col-md-8 offset-sm-2">
                <div class="card card-inverse card-info">
                    <div class="card-header">
                        <div class="card-title">Formulaire Initialisation du mot du passe</div>

                    </div>
                </div>
                <div style="padding-top: 30px;" class="card-block">
                    <div style="display: none;" id="login-alert" class="alert alert-danger col-md-12"></div>
                    <form id="loginform" class="" role="form" method="post" action="/PFE-MyHotel/InitMdp">
                        <input type="hidden" value="<%=request.getAttribute("login")%>" name="login">
                        <div class="col-auto">
                            <label class="sr-only" for="inlineFormInputGroup">Nouveau Mot de passe</label>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">Mot de passe</div>
                                </div>
                                <input type="password" name="mdp" class="form-control" id="inlineFormInputGroup" placeholder="Nouveau Mot de passe">
                            </div>
                        </div>
                        <div class="col-auto">
                            <label class="sr-only" for="inlineFormInputGroup">Confirmation du Mot de passe</label>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">Confirmation du Mot de passe</div>
                                </div>
                                <input type="password" name="mdp2" class="form-control" id="inlineFormInputGroup" placeholder="Confirmation">
                            </div>
                        </div>
                        
                        <div style="margin-top: 10px;" class="form-group">
                            <!-- Button -->
                            <div class="col-md-12 controls"> <button type="submit" id="btn-login" href="#" class="btn btn-success">Initialiser le MDP</button>
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

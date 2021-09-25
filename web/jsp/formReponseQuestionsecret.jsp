<%-- 
    Document   : formReponseQuestionsecret
    Created on : 07-avr.-2020, 17:34:13
    Author     : Utilisateur
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
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
                if (session.getAttribute("r") != null) {
                    request.getRequestDispatcher("/jsp/mesHoteles.jsp").forward(request, response);
                }

            %>




            <%if (request.getAttribute("msg") != null) {%>
            <div style="margin: auto; position: relative; width: 50% " class="alert alert-<%=request.getAttribute("typemsg").toString().equals("error") ? "danger" : "primary"%> " role="alert">
                <%=request.getAttribute("msg")%>
            </div>

            <% }
                Connection con = DAOUtil.getConnection();
                String login = request.getParameter("login");
                PreparedStatement ps = con.prepareStatement("select *from compte where login=?");
                ps.setString(1, login);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
            %>
            <div id="loginbox" style="margin-top: 50px;" class="mainbox col-lg-6 offset-md-3 col-md-8 offset-sm-2">
                <div class="card card-inverse card-info">
                    <div class="card-header">
                        <div class="card-title">Formulaire reponse question secret</div>

                    </div>
                </div>
                <div style="padding-top: 30px;" class="card-block">
                    <div style="display: none;" id="login-alert" class="alert alert-danger col-md-12"></div>
                    <form id="loginform" class="" role="form" method="post" action="/PFE-MyHotel/CheckReponse">
                        
                        <div class="col-auto">
                            <label class="sr-only" for="inlineFormInputGroup">Login</label>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">Login</div>
                                </div>
                                <input type="text"  class="form-control" id="inlineFormInputGroup" value="<%=login%>" disabled>
                            </div>
                        </div>
                            <div class="col-auto">
                            <label class="sr-only" for="inlineFormInputGroup">Question secret</label>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">Question secret</div>
                                </div>
                                <input type="text" name="reponse" class="form-control" id="inlineFormInputGroup" value="<%=rs.getString("question")%>" disabled>
                            </div>
                        </div>
                        
                        <div class="col-auto">
                            <label class="sr-only" for="inlineFormInputGroup">Reponse</label>
                            <div class="input-group mb-2">
                                <div class="input-group-prepend">
                                    <div class="input-group-text">reponse</div>
                                </div>
                                <input type="text" name="reponse" class="form-control" id="inlineFormInputGroup" placeholder="votre reponse">
                            </div>
                        </div>
                                <input type="hidden" name="login" class="form-control" id="inlineFormInputGroup" value="<%=login%>" >
                        <div style="margin-top: 10px;" class="form-group">
                            <!-- Button -->
                            <div class="col-md-12 controls"> <button type="submit" id="btn-login" href="#" class="btn btn-success">Continuer </button>
                                <a id="btn-fblogin"
                                   href="#" class="btn btn-danger">Annuler</a>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-12 control">
                                <div style="padding-top: 15px; font-size: 85%;">Mot de passe oublie? <a href="/PFE-MyHotel/jsp/recupererMdp.jsp"> Recuperer le ici</a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <%
                } else {
                    request.setAttribute("msg", "identifient invalid!!");
                    request.setAttribute("typemsg", "error");
                    request.getRequestDispatcher("/jsp/recupererMdp.jsp").forward(request, response);
                }


            %>











            <jsp:include page="peid.jsp"></jsp:include>
        </div>
    </body>
</html>

<%-- 
    Document   : ProfilRespo
    Created on : 11-avr.-2020, 0:57:51
    Author     : Utilisateur
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="ma.hotel.models.Responsable"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="/PFE-MyHotel/css/profil.css">
    </head>
    <body>
       <jsp:include page="entete.jsp"></jsp:include>
        
        <%if (session.getAttribute("r") == null) {
                    request.setAttribute("msg", "cette page necessite une authentification");
                    request.setAttribute("typemsg", "error");
                    request.getRequestDispatcher("/jsp/formLogin.jsp").forward(request, response);

                }%>
                
                <%if (request.getAttribute("msg") != null) {%>
            <div style="margin: auto; position: relative; width: 50% " class="alert alert-<%=request.getAttribute("typemsg").toString().equals("error") ? "danger": "primary"%> " role="alert">
                <%=request.getAttribute("msg")%>
            </div>

            <%}%>
            
            <%
                int idr=Integer.parseInt(request.getParameter("idr"));
                Responsable r=(Responsable)session.getAttribute("r");
            Connection con=DAOUtil.getConnection();
            PreparedStatement ps=con.prepareStatement("select *from responsable join compte using (login) where idr=?");
            ps.setInt(1, idr);
            ResultSet rs = ps.executeQuery();
           
            %>
            <%if(rs.next()){%>
            
            <div class="container" style="margin-left: 35%; height: 720px">
                <div class="row profile" style="height: 500px">
		<div class="col-md-3" style="">
			<div class="profile-sidebar" style="height: 470px">
				<!-- SIDEBAR USERPIC -->
                                <div class="profile-userpic" style="height: 60px">
                                    <img src="/PFE-MyHotel/img/<%=rs.getString("imgres")%>" style="height: 58px; margin-left: 88px" class="img-responsive" alt="">
				</div>
				<!-- END SIDEBAR USERPIC -->
				<!-- SIDEBAR USER TITLE -->
				<div class="profile-usertitle">
					<div class="profile-usertitle-name">
                                            <%=rs.getString("nom")%> <%=rs.getString("prenom")%> 
					</div>
					<div class="profile-usertitle-job">
						<%=rs.getString("role")%>
					</div>
				</div>
				<!-- END SIDEBAR USER TITLE -->
				<!-- SIDEBAR BUTTONS -->
				<div class="profile-userbuttons">
					
					<button type="button" class="btn btn-danger btn-sm">Message</button>
				</div>
				<!-- END SIDEBAR BUTTONS -->
				<!-- SIDEBAR MENU -->
				<div class="profile-usermenu">
                                    <ul class="nav" style="display: block">
						<li class="active">
							<a href="#">
							<i class="glyphicon glyphicon-home"></i>
                                                        Id: <%=rs.getInt("idr")%> </a>
						</li>
						<li>
							<a href="#">
							<i class="glyphicon glyphicon-user"></i>
                                                        Email:    <%=rs.getString("email")%> </a>
						</li>
						<li>
							<a href="#" target="_blank">
							<i class="glyphicon glyphicon-ok"></i>
							login:    <%=rs.getString("login")%> </a>
						</li>
						<li>
							<a href="#">
							<i class="glyphicon glyphicon-flag"></i>
							Date Naissance:    <%=rs.getDate("datenaiss")%> </a>
						</li>
                                                <li>
							<a href="#">
							<i class="glyphicon glyphicon-flag"></i>
							Question:    <%=rs.getString("question")%> </a>
						</li>
                                                <li>
							<a href="#">
							<i class="glyphicon glyphicon-flag"></i>
							Reponse:    <%=rs.getString("reponse")%> </a>
						</li>
					</ul>
				</div>
				<!-- END MENU -->
			</div>
		</div>
		
	</div>
</div>

<br>
<br>
            
            
            
            
            <%}%>
            <%con.close();%>
            <jsp:include page="peid.jsp"></jsp:include>
    </body>
</html>

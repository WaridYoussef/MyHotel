<%-- 
    Document   : principal
    Created on : 01-avr.-2020, 13:59:59
    Author     : Utilisateur
--%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="ma.hotel.models.Ville"%>
<%@page import="ma.hotel.models.Responsable"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ma.hotel.models.Hotel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="/PFE-MyHotel/css/btn.css">
    </head>
    <body>


        <jsp:include page="entete.jsp"></jsp:include>
        <%if (request.getAttribute("msg") != null) {%>
        <div style="margin: auto; position: relative; width: 50% " class="alert alert-<%=request.getAttribute("typemsg").toString().equals("error") ? "danger" : "primary"%> " role="alert">
            <%=request.getAttribute("msg")%>
        </div>

        <%}%>

        <%
            List<Hotel> hots = new ArrayList<Hotel>();
            Connection con = DAOUtil.getConnection();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from (select * from hotel join ville using(idville) join responsable using (idr) where etat='accepte' order by datepub desc ) where rownum<10");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while (rs.next()) {
                hots.add(new Hotel(rs.getInt("idh"), rs.getString("nomh"), new Ville(rs.getInt("idville"),rs.getString("nomville")), rs.getString("img"),
                        new Responsable(rs.getInt("idr"), rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),rs.getString("imgres"),sdf.parse(rs.getDate("datenaiss").toString()), null), rs.getString("etat"),
                        rs.getString("adresse"), rs.getInt("idetoile"), sdf.parse(rs.getDate("datepub").toString())));

            }

            
        %>
        <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel" style="margin-left: 10%; margin-top: 30px ; margin-right: 10%; margin-bottom: 30px">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
                <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
                <li data-target="#carouselExampleCaptions" data-slide-to="3"></li>
                <li data-target="#carouselExampleCaptions" data-slide-to="4"></li>
                <li data-target="#carouselExampleCaptions" data-slide-to="5"></li>
                <li data-target="#carouselExampleCaptions" data-slide-to="6"></li>
                <li data-target="#carouselExampleCaptions" data-slide-to="7"></li>
                <li data-target="#carouselExampleCaptions" data-slide-to="8"></li>
                
                
            </ol>       

            <div class="carousel-inner">

                <%          int i = 0;
                    for (Hotel h : hots) {

                %>

                <div class="carousel-item <%= i == 0 ? "active" : ""%>">
                    <img style="height: 450px; width: 650px" src="/PFE-MyHotel/img/<%=h.getImg()%>" class="d-block w-100" alt="<%=h.getNomh()%>">
                    <div class="carousel-caption d-none d-md-block" >
                        <h5 style="font-size: 34px"> <%=h.getNomh()%> </h5>
                        <p style="font-size: 25px"><%=h.getVille().getNomville()%></p>
                            
                        <a style="font-size: 25px" href="/PFE-MyHotel/jsp/DetailRes.jsp?idh=<%=h.getIdh()%>"><span class="badge badge-info">Plus...</span></a>
                        
                    </div>
                </div>



                <%
                        i++;
                    }%>

            </div>  





            <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Precedent</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Suivant</span>
            </a>
        </div>

        <div class="container" style="width: 100%">
            <div class="col mb-4" style="height: 600px; margin-top: 100px; margin-right: 70px">
                <%
                     for (Hotel h : hots) {%>
                <div class="col mb-4" style="margin-top: 100px">
                    <div class="card" style="width: 350px; height: 320px; display: inline-block; float: right; margin-top: 220px">
                        <img style="height: 310px; width: 346px" src="/PFE-MyHotel/img/<%=h.getImg()%>" class="card-img-top" alt="<%=h.getNomh()%>">
                        <div class="card-body" style="background-color: window">
                            <h5 class="card-title"><%=h.getNomh()%></h5>
                            <p class="card-text"><%=h.getAdresse()%></p>
                            <%if (h.getEtoile() == 1) {%>

                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>

                            <%} else if (h.getEtoile() == 2) {%>

                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star "></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>


                            <%} else if (h.getEtoile() == 3) {%>

                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star"></span>
                            <span class="fa fa-star"></span>

                            <%} else if (h.getEtoile() == 4) {%>

                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star " style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star"></span>

                            <%} else if (h.getEtoile() == 5) {%>

                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <span class="fa fa-star" style="color: yellow"></span>
                            <%}%>


                            <a href="/PFE-MyHotel/jsp/DetailRes.jsp?idh=<%=h.getIdh()%>"> <button type="button" class="btn btn-primary" style="width: 200px">Reserver</button> </a>

                        </div>
                    </div>
                </div>
                <%}%>
            </div>
        </div>
            
            
            <div style="margin-top: 1250px">
               
                <div class="boton">

                    <button class="btn btn3" style="width: 200px; height: 62px; font-size: 20px">Info</button>
                    <a class="aa" href="/PFE-MyHotel/jsp/entrerCin.jsp"><button class="btn btn4"  style="width: 200px">Supprimer Ou Modifier "Reservation"</button></a>
            </div>
                
         
              
            </div>
            
            <div style="margin-top: 100px">
                
                <div style="margin: auto; position: relative; width: 70%">
                <h3>Liste des commentaires</h3>
                <%
                   PreparedStatement ps = con.prepareStatement("select * from commentaire");
                    
                   rs = ps.executeQuery();
                %>

                <ul class="list-unstyled">
                    <%
                        while (rs.next()) {
                    %>


                    <li class="media">
                        <img src="/PFE-MyHotel/img/user.png" class="mr-3 rounded-circle" alt="...">
                        <div class="media-body">
                            <h5 class="mt-0 mb-1"><%=rs.getString("titre")%> <small><i>Poste par <%=rs.getString("pseudo")%>
                                        le <%=rs.getDate("datecom")%></i></small></h5>
                            <%=rs.getString("text")%><br>


                            <div id="<%=rs.getInt("idc")%>">             
                                <button type="button" onclick="like('<%=rs.getInt("idc")%>')" class="btn btn-outline-success rounded-circle">
                                    <img src="/PFE-MyHotel/img/like.png" style="width: 24px; height: 21px"><%=rs.getInt("NBRLIKE")%>
                                </button>
                                <button type="button" onclick="unlike('<%=rs.getInt("idc")%>')" class="btn btn-outline-danger rounded-circle">
                                    <img src="/PFE-MyHotel/img/unlike.png" style="width: 21px; height: 21px"><%=rs.getInt("NBRUNLIKE")%>
                                </button>
                            </div>
                        </div>       
                    </li>


                    <%}%> 
                </ul>
                <div id="formComm" style="margin: auto; position: relative; width: 60%">
                    <form class="card-body">
                        <div class="form-group">
                            <label for="exampleFormControlInput1">Email</label>
                            <input type="email" class="form-control" id="email" placeholder="name@example.com">
                        </div>

                        <div class="form-group">
                            <label for="exampleFormControlInput1">Pseudo</label>
                            <input type="text" class="form-control" id="pseudo" placeholder="Pseudo">
                        </div>

                        <div class="form-group">
                            <label for="exampleFormControlInput1">Titre</label>
                            <input type="text" class="form-control" id="titre" placeholder="Titre">
                        </div>

                        <div class="form-group">
                            <label for="exampleFormControlTextarea1">Text</label>
                            <textarea class="form-control" id="text" rows="3"></textarea>
                        </div>
                       
                        <button type="button" class="btn btn-primary" onclick="saveComm();">Envoyer le commentaire</button>
                    </form>
                </div>

            </div>
                
                
            </div>
            
            <%con.close();%>
        <jsp:include page="peid.jsp"></jsp:include>
        
        <script>

                function saveComm() {
                    // On reprend le même id que dans le précédent chapitre

                    $.ajax({
                        url: '/PFE-MyHotel/AddComm',
                        type: 'Post',
                        dataType: 'html',
                        data: '&pseudo=' + $("#pseudo").val() + '&titre=' + $("#titre").val() + '&text=' + $("#text").val()
                                + '&email=' + $("#email").val(),
                        success: function (code_html, statut) {
                            document.getElementById('formComm').innerHTML = "<div class='alert alert-success' role='alert'>" +
                                    code_html + "</div>";
                            location.reload();

                        },
                        error: function (resultat, statut, erreur) {
                            alert(erreur);
                        },
                        complete: function (resultat, statut) {

                        }

                    });

                }

                function like(idc) {
                    // On reprend le même id que dans le précédent chapitre

                    $.ajax({
                        url: '/PFE-MyHotel/LikeComm',
                        type: 'Post',
                        dataType: 'html',
                        data: 'idc='+idc+'&action=like',
                        success: function (code_html, statut) {
                            document.getElementById(idc+'').innerHTML = code_html;

                        },
                        error: function (resultat, statut, erreur) {
                            alert(erreur);
                        },
                        complete: function (resultat, statut) {

                        }

                    });

                }
                
                function unlike(idc) {
                    // On reprend le même id que dans le précédent chapitre

                    $.ajax({
                        url: '/PFE-MyHotel/LikeComm',
                        type: 'Post',
                        dataType: 'html',
                        data: 'idc='+idc+'&action=unlike',
                        success: function (code_html, statut) {
                            document.getElementById(idc+'').innerHTML = code_html;

                        },
                        error: function (resultat, statut, erreur) {
                            alert(erreur);
                        },
                        complete: function (resultat, statut) {

                        }

                    });

                }

            </script>

    </body>
</html>

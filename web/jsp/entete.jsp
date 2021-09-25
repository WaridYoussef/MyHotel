<%-- 
    Document   : entete
    Created on : 01-avr.-2020, 13:59:24
    Author     : Utilisateur
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ma.hotel.models.Etoile"%>
<%@page import="ma.hotel.models.Compte"%>
<%@page import="ma.hotel.models.Responsable"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="/PFE-MyHotel/bootstrap-4.4/css/bootstrap.min.css" >
        <script src='https://kit.fontawesome.com/a076d05399.js'></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>JSP Page</title>
    </head>
    <body style="background-color: #DDD">

        <%

            Connection con = DAOUtil.getConnection();

             Cookie [] cks=request.getCookies();
                if(cks!=null&&cks.length>0){
                    for(Cookie ck:cks){
                        if(ck.getName().equals("authentification")){
                            
                            String[] vals=ck.getValue().split("/");
                            
                            PreparedStatement ps=con.prepareStatement("select *from responsable join compte using (login)"
                                    + " where login=? and lower(DBMS_OBFUSCATION_TOOLKIT.md5 (input => UTL_RAW.cast_to_raw(mdp)))=?");
            ps.setString(1, vals[0]);
            ps.setString(2, vals[1]);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            ResultSet rs2=ps.executeQuery();
            if(rs2.next()){
                Responsable r=new Responsable(rs2.getInt("idr"), rs2.getString("nom"), rs2.getString("prenom"), rs2.getString("email"),rs2.getString("imgres"),sdf.parse(rs2.getDate("datenaiss").toString()),
                        new Compte(vals[0], vals[1], rs2.getString("role")));
                            session.setAttribute("r", r);
                        }
                        
                    }
                }
            }
             
            
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from etoile");
            List<Etoile> etoiles = new ArrayList<Etoile>();

        %>



        <nav class="navbar navbar-expand-lg navbar-info bg-danger" style="margin-top: 10px">
            <a class="navbar-brand" style="color: white; font-family:serif ; font-size: 28px" href="/PFE-MyHotel/jsp/principal.jsp"><b><i class='far fa-building' style='font-size:28px'></i>My Hotel</b></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon bg-light"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" style="font-size:18px;color: white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Etoiles
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <% while (rs.next()) {
                            etoiles.add(new Etoile(rs.getInt(1)));
                                }%>
                                <%for (Etoile e:etoiles){%>
                                <%if(e.getIdetoile()==1){%>
                            <a class="dropdown-item"  href="/PFE-MyHotel/jsp/rechercheParet.jsp?idetoile=<%=e.getIdetoile()%>">
                                
                                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span></a>
                <%} else if(e.getIdetoile()==2){%>
                <a class="dropdown-item"  href="/PFE-MyHotel/jsp/rechercheParet.jsp?idetoile=<%=e.getIdetoile()%>">
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star "></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span></a>
                
                        <%}else if (e.getIdetoile()== 3) {%>
                        <a class="dropdown-item"  href="/PFE-MyHotel/jsp/rechercheParet.jsp?idetoile=<%=e.getIdetoile()%>">
                        <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star"></span>
                <span class="fa fa-star"></span></a>
         
                         <%}else if (e.getIdetoile()== 4) {%>
                         <a class="dropdown-item"  href="/PFE-MyHotel/jsp/rechercheParet.jsp?idetoile=<%=e.getIdetoile()%>">
                         <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star " style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star"></span></a>
                         
                         
                        <%}else{%>
                        <a class="dropdown-item"  href="/PFE-MyHotel/jsp/rechercheParet.jsp?idetoile=<%=e.getIdetoile()%>">
                        <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span>
                <span class="fa fa-star" style="color: yellow"></span></a>
                        <%}%>
                        
                        <%}%>
                                <%rs.close();%>
                        </div>
                    </li>

                </ul>
                <form class="form-inline my-2 my-lg-0"  action="/PFE-MyHotel/jsp/recherche.jsp">

                    <div class="col-auto my-1">
                        <label class="mr-sm-2 sr-only" for="inlineFormCustomSelect">Ville</label>
                        <select name="idville" class="custom-select mr-sm-2" id="inlineFormCustomSelect">
                            <option value="-1" selected>Tous</option>

                            <%ResultSet rsv = st.executeQuery("select * from ville");
                                while (rsv.next()) {%>
                            <option value="<%=rsv.getInt(1)%>"><%=rsv.getString(2)%></option>
                            <%}
                                rs.close();
                                con.close();
                            %>

                        </select>
                    </div>
                    <input class="form-control mr-sm-2" type="search" placeholder="Rechercher" aria-label="Rechercher" name="mot">
                    <button class="btn btn-outline-info my-2 my-sm-0" style="color: white" type="submit"><b><i class='fas fa-search' style='font-size:18px'></i>Rechercher</b></button>
                </form>
            

               <% if(session.getAttribute("r")==null){%>
            <a class="nav-link" style="color: white" href="/PFE-MyHotel/jsp/formLogin.jsp"><b><i class='fas fa-user-lock' style='font-size:18px'>Login</i></b></a>
            <%}else{
                Responsable r=(Responsable)session.getAttribute("r");
                
                %>
            
             <ul class="navbar-nav mr-auto">
                <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" style="font-size:18px;color: white" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <i class='fas fa-user-lock' style='font-size:15px'><%=r.getNom()+"("+r.getCompte().getRole()+")"%></i>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            
                            <a class="dropdown-item" href="/PFE-MyHotel/jsp/mesHoteles.jsp"><img src="/PFE-MyHotel/img/edit.png" width="20px" height="22px"> mes Hoteles</a>
                            <a class="dropdown-item" href="/PFE-MyHotel/jsp/formAddHotel.jsp"><img src="/PFE-MyHotel/img/edit.png" width="20px" height="22px">Ajouter Hotel</a>
                           
                            <%if(r.getCompte().getRole().equals("admin")){%>
                           <a class="dropdown-item" href="/PFE-MyHotel/jsp/validerHotel.jsp"><img src="/PFE-MyHotel/img/valider.png" width="20px" height="22px">Valider Hotel</a>
                           
                            <a class="dropdown-item" href="/PFE-MyHotel/jsp/listeRespo.jsp"><img src="/PFE-MyHotel/img/respo.png" width="20px" height="22px">Liste Responsables</a>     
                          <% } %>
                            
                         <a class="dropdown-item" href="/PFE-MyHotel/jsp/ProfilRespo.jsp?idr=<%=r.getIdr()%>"><img src="/PFE-MyHotel/img/respo.png" width="20px" height="22px">Mon Compte</a>     
                           <a class="dropdown-item" href="/PFE-MyHotel/jsp/changermdp.jsp"><img src="/PFE-MyHotel/img/change.png" width="20px" height="22px">Changer mdp</a>
                           <a class="dropdown-item" href="/PFE-MyHotel/Logout"><img src="/eJournalWaridYoussef/img/logout.png" width="20px" height="22px">Se deconnecter</a>

                            
                        </div>
                    </li>
                
                </ul>
                <%}%>

                </div>
        </nav>
       
    </body>
</html>

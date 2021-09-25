package org.apache.jsp.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.PreparedStatement;
import ma.hotel.models.Ville;
import ma.hotel.models.Responsable;
import java.text.SimpleDateFormat;
import java.sql.ResultSet;
import java.sql.Statement;
import ma.hotel.dao.DAOUtil;
import java.sql.Connection;
import java.util.List;
import java.util.ArrayList;
import ma.hotel.models.Hotel;

public final class principal_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"/PFE-MyHotel/css/btn.css\">\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("\n");
      out.write("        ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "entete.jsp", out, false);
      out.write("\n");
      out.write("        ");
if (request.getAttribute("msg") != null) {
      out.write("\n");
      out.write("        <div style=\"margin: auto; position: relative; width: 50% \" class=\"alert alert-");
      out.print(request.getAttribute("typemsg").toString().equals("error") ? "danger" : "primary");
      out.write(" \" role=\"alert\">\n");
      out.write("            ");
      out.print(request.getAttribute("msg"));
      out.write("\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        ");
}
      out.write("\n");
      out.write("\n");
      out.write("        ");

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

            
        
      out.write("\n");
      out.write("        <div id=\"carouselExampleCaptions\" class=\"carousel slide\" data-ride=\"carousel\" style=\"margin-left: 10%; margin-top: 30px ; margin-right: 10%; margin-bottom: 30px\">\n");
      out.write("            <ol class=\"carousel-indicators\">\n");
      out.write("                <li data-target=\"#carouselExampleCaptions\" data-slide-to=\"0\" class=\"active\"></li>\n");
      out.write("                <li data-target=\"#carouselExampleCaptions\" data-slide-to=\"1\"></li>\n");
      out.write("                <li data-target=\"#carouselExampleCaptions\" data-slide-to=\"2\"></li>\n");
      out.write("                <li data-target=\"#carouselExampleCaptions\" data-slide-to=\"3\"></li>\n");
      out.write("                <li data-target=\"#carouselExampleCaptions\" data-slide-to=\"4\"></li>\n");
      out.write("                <li data-target=\"#carouselExampleCaptions\" data-slide-to=\"5\"></li>\n");
      out.write("                <li data-target=\"#carouselExampleCaptions\" data-slide-to=\"6\"></li>\n");
      out.write("                <li data-target=\"#carouselExampleCaptions\" data-slide-to=\"7\"></li>\n");
      out.write("                <li data-target=\"#carouselExampleCaptions\" data-slide-to=\"8\"></li>\n");
      out.write("                \n");
      out.write("                \n");
      out.write("            </ol>       \n");
      out.write("\n");
      out.write("            <div class=\"carousel-inner\">\n");
      out.write("\n");
      out.write("                ");
          int i = 0;
                    for (Hotel h : hots) {

                
      out.write("\n");
      out.write("\n");
      out.write("                <div class=\"carousel-item ");
      out.print( i == 0 ? "active" : "");
      out.write("\">\n");
      out.write("                    <img style=\"height: 450px; width: 650px\" src=\"/PFE-MyHotel/img/");
      out.print(h.getImg());
      out.write("\" class=\"d-block w-100\" alt=\"");
      out.print(h.getNomh());
      out.write("\">\n");
      out.write("                    <div class=\"carousel-caption d-none d-md-block\" >\n");
      out.write("                        <h5 style=\"font-size: 34px\"> ");
      out.print(h.getNomh());
      out.write(" </h5>\n");
      out.write("                        <p style=\"font-size: 25px\">");
      out.print(h.getVille().getNomville());
      out.write("</p>\n");
      out.write("                            \n");
      out.write("                        <a style=\"font-size: 25px\" href=\"/PFE-MyHotel/jsp/DetailRes.jsp?idh=");
      out.print(h.getIdh());
      out.write("\"><span class=\"badge badge-info\">Plus...</span></a>\n");
      out.write("                        \n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                ");

                        i++;
                    }
      out.write("\n");
      out.write("\n");
      out.write("            </div>  \n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("            <a class=\"carousel-control-prev\" href=\"#carouselExampleCaptions\" role=\"button\" data-slide=\"prev\">\n");
      out.write("                <span class=\"carousel-control-prev-icon\" aria-hidden=\"true\"></span>\n");
      out.write("                <span class=\"sr-only\">Precedent</span>\n");
      out.write("            </a>\n");
      out.write("            <a class=\"carousel-control-next\" href=\"#carouselExampleCaptions\" role=\"button\" data-slide=\"next\">\n");
      out.write("                <span class=\"carousel-control-next-icon\" aria-hidden=\"true\"></span>\n");
      out.write("                <span class=\"sr-only\">Suivant</span>\n");
      out.write("            </a>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        <div class=\"container\" style=\"width: 100%\">\n");
      out.write("            <div class=\"col mb-4\" style=\"height: 600px; margin-top: 100px; margin-right: 70px\">\n");
      out.write("                ");

                     for (Hotel h : hots) {
      out.write("\n");
      out.write("                <div class=\"col mb-4\" style=\"margin-top: 100px\">\n");
      out.write("                    <div class=\"card\" style=\"width: 350px; height: 320px; display: inline-block; float: right; margin-top: 220px\">\n");
      out.write("                        <img style=\"height: 310px; width: 346px\" src=\"/PFE-MyHotel/img/");
      out.print(h.getImg());
      out.write("\" class=\"card-img-top\" alt=\"");
      out.print(h.getNomh());
      out.write("\">\n");
      out.write("                        <div class=\"card-body\" style=\"background-color: window\">\n");
      out.write("                            <h5 class=\"card-title\">");
      out.print(h.getNomh());
      out.write("</h5>\n");
      out.write("                            <p class=\"card-text\">");
      out.print(h.getAdresse());
      out.write("</p>\n");
      out.write("                            ");
if (h.getEtoile() == 1) {
      out.write("\n");
      out.write("\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\"></span>\n");
      out.write("                            <span class=\"fa fa-star\"></span>\n");
      out.write("                            <span class=\"fa fa-star\"></span>\n");
      out.write("                            <span class=\"fa fa-star\"></span>\n");
      out.write("\n");
      out.write("                            ");
} else if (h.getEtoile() == 2) {
      out.write("\n");
      out.write("\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star \"></span>\n");
      out.write("                            <span class=\"fa fa-star\"></span>\n");
      out.write("                            <span class=\"fa fa-star\"></span>\n");
      out.write("\n");
      out.write("\n");
      out.write("                            ");
} else if (h.getEtoile() == 3) {
      out.write("\n");
      out.write("\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\"></span>\n");
      out.write("                            <span class=\"fa fa-star\"></span>\n");
      out.write("\n");
      out.write("                            ");
} else if (h.getEtoile() == 4) {
      out.write("\n");
      out.write("\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star \" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\"></span>\n");
      out.write("\n");
      out.write("                            ");
} else if (h.getEtoile() == 5) {
      out.write("\n");
      out.write("\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            <span class=\"fa fa-star\" style=\"color: yellow\"></span>\n");
      out.write("                            ");
}
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                            <a href=\"/PFE-MyHotel/jsp/DetailRes.jsp?idh=");
      out.print(h.getIdh());
      out.write("\"> <button type=\"button\" class=\"btn btn-primary\" style=\"width: 200px\">Reserver</button> </a>\n");
      out.write("\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("                ");
}
      out.write("\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("            \n");
      out.write("            \n");
      out.write("            <div style=\"margin-top: 1250px\">\n");
      out.write("               \n");
      out.write("                <div class=\"boton\">\n");
      out.write("\n");
      out.write("                    <button class=\"btn btn3\" style=\"width: 200px; height: 62px; font-size: 20px\">Info</button>\n");
      out.write("                    <a class=\"aa\" href=\"/PFE-MyHotel/jsp/entrerCin.jsp\"><button class=\"btn btn4\"  style=\"width: 200px\">Supprimer Ou Modifier \"Reservation\"</button></a>\n");
      out.write("            </div>\n");
      out.write("                \n");
      out.write("         \n");
      out.write("              \n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            <div style=\"margin-top: 100px\">\n");
      out.write("                \n");
      out.write("                <div style=\"margin: auto; position: relative; width: 70%\">\n");
      out.write("                <h3>Liste des commentaires</h3>\n");
      out.write("                ");

                   PreparedStatement ps = con.prepareStatement("select * from commentaire");
                    
                   rs = ps.executeQuery();
                
      out.write("\n");
      out.write("\n");
      out.write("                <ul class=\"list-unstyled\">\n");
      out.write("                    ");

                        while (rs.next()) {
                    
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("                    <li class=\"media\">\n");
      out.write("                        <img src=\"/PFE-MyHotel/img/user.png\" class=\"mr-3 rounded-circle\" alt=\"...\">\n");
      out.write("                        <div class=\"media-body\">\n");
      out.write("                            <h5 class=\"mt-0 mb-1\">");
      out.print(rs.getString("titre"));
      out.write(" <small><i>Poste par ");
      out.print(rs.getString("pseudo"));
      out.write("\n");
      out.write("                                        le ");
      out.print(rs.getDate("datecom"));
      out.write("</i></small></h5>\n");
      out.write("                            ");
      out.print(rs.getString("text"));
      out.write("<br>\n");
      out.write("\n");
      out.write("\n");
      out.write("                            <div id=\"");
      out.print(rs.getInt("idc"));
      out.write("\">             \n");
      out.write("                                <button type=\"button\" onclick=\"like('");
      out.print(rs.getInt("idc"));
      out.write("')\" class=\"btn btn-outline-success rounded-circle\">\n");
      out.write("                                    <img src=\"/PFE-MyHotel/img/like.png\" style=\"width: 24px; height: 21px\">");
      out.print(rs.getInt("NBRLIKE"));
      out.write("\n");
      out.write("                                </button>\n");
      out.write("                                <button type=\"button\" onclick=\"unlike('");
      out.print(rs.getInt("idc"));
      out.write("')\" class=\"btn btn-outline-danger rounded-circle\">\n");
      out.write("                                    <img src=\"/PFE-MyHotel/img/unlike.png\" style=\"width: 21px; height: 21px\">");
      out.print(rs.getInt("NBRUNLIKE"));
      out.write("\n");
      out.write("                                </button>\n");
      out.write("                            </div>\n");
      out.write("                        </div>       \n");
      out.write("                    </li>\n");
      out.write("\n");
      out.write("\n");
      out.write("                    ");
}
      out.write(" \n");
      out.write("                </ul>\n");
      out.write("                <div id=\"formComm\" style=\"margin: auto; position: relative; width: 60%\">\n");
      out.write("                    <form class=\"card-body\">\n");
      out.write("                        <div class=\"form-group\">\n");
      out.write("                            <label for=\"exampleFormControlInput1\">Email</label>\n");
      out.write("                            <input type=\"email\" class=\"form-control\" id=\"email\" placeholder=\"name@example.com\">\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"form-group\">\n");
      out.write("                            <label for=\"exampleFormControlInput1\">Pseudo</label>\n");
      out.write("                            <input type=\"text\" class=\"form-control\" id=\"pseudo\" placeholder=\"Pseudo\">\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"form-group\">\n");
      out.write("                            <label for=\"exampleFormControlInput1\">Titre</label>\n");
      out.write("                            <input type=\"text\" class=\"form-control\" id=\"titre\" placeholder=\"Titre\">\n");
      out.write("                        </div>\n");
      out.write("\n");
      out.write("                        <div class=\"form-group\">\n");
      out.write("                            <label for=\"exampleFormControlTextarea1\">Text</label>\n");
      out.write("                            <textarea class=\"form-control\" id=\"text\" rows=\"3\"></textarea>\n");
      out.write("                        </div>\n");
      out.write("                       \n");
      out.write("                        <button type=\"button\" class=\"btn btn-primary\" onclick=\"saveComm();\">Envoyer le commentaire</button>\n");
      out.write("                    </form>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("                \n");
      out.write("                \n");
      out.write("            </div>\n");
      out.write("            \n");
      out.write("            ");
con.close();
      out.write("\n");
      out.write("        ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "peid.jsp", out, false);
      out.write("\n");
      out.write("        \n");
      out.write("        <script>\n");
      out.write("\n");
      out.write("                function saveComm() {\n");
      out.write("                    // On reprend le même id que dans le précédent chapitre\n");
      out.write("\n");
      out.write("                    $.ajax({\n");
      out.write("                        url: '/PFE-MyHotel/AddComm',\n");
      out.write("                        type: 'Post',\n");
      out.write("                        dataType: 'html',\n");
      out.write("                        data: '&pseudo=' + $(\"#pseudo\").val() + '&titre=' + $(\"#titre\").val() + '&text=' + $(\"#text\").val()\n");
      out.write("                                + '&email=' + $(\"#email\").val(),\n");
      out.write("                        success: function (code_html, statut) {\n");
      out.write("                            document.getElementById('formComm').innerHTML = \"<div class='alert alert-success' role='alert'>\" +\n");
      out.write("                                    code_html + \"</div>\";\n");
      out.write("                            location.reload();\n");
      out.write("\n");
      out.write("                        },\n");
      out.write("                        error: function (resultat, statut, erreur) {\n");
      out.write("                            alert(erreur);\n");
      out.write("                        },\n");
      out.write("                        complete: function (resultat, statut) {\n");
      out.write("\n");
      out.write("                        }\n");
      out.write("\n");
      out.write("                    });\n");
      out.write("\n");
      out.write("                }\n");
      out.write("\n");
      out.write("                function like(idc) {\n");
      out.write("                    // On reprend le même id que dans le précédent chapitre\n");
      out.write("\n");
      out.write("                    $.ajax({\n");
      out.write("                        url: '/PFE-MyHotel/LikeComm',\n");
      out.write("                        type: 'Post',\n");
      out.write("                        dataType: 'html',\n");
      out.write("                        data: 'idc='+idc+'&action=like',\n");
      out.write("                        success: function (code_html, statut) {\n");
      out.write("                            document.getElementById(idc+'').innerHTML = code_html;\n");
      out.write("\n");
      out.write("                        },\n");
      out.write("                        error: function (resultat, statut, erreur) {\n");
      out.write("                            alert(erreur);\n");
      out.write("                        },\n");
      out.write("                        complete: function (resultat, statut) {\n");
      out.write("\n");
      out.write("                        }\n");
      out.write("\n");
      out.write("                    });\n");
      out.write("\n");
      out.write("                }\n");
      out.write("                \n");
      out.write("                function unlike(idc) {\n");
      out.write("                    // On reprend le même id que dans le précédent chapitre\n");
      out.write("\n");
      out.write("                    $.ajax({\n");
      out.write("                        url: '/PFE-MyHotel/LikeComm',\n");
      out.write("                        type: 'Post',\n");
      out.write("                        dataType: 'html',\n");
      out.write("                        data: 'idc='+idc+'&action=unlike',\n");
      out.write("                        success: function (code_html, statut) {\n");
      out.write("                            document.getElementById(idc+'').innerHTML = code_html;\n");
      out.write("\n");
      out.write("                        },\n");
      out.write("                        error: function (resultat, statut, erreur) {\n");
      out.write("                            alert(erreur);\n");
      out.write("                        },\n");
      out.write("                        complete: function (resultat, statut) {\n");
      out.write("\n");
      out.write("                        }\n");
      out.write("\n");
      out.write("                    });\n");
      out.write("\n");
      out.write("                }\n");
      out.write("\n");
      out.write("            </script>\n");
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}

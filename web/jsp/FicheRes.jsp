<%-- 
    Document   : FicheRes
    Created on : 21 déc. 2020, 15:20:42
    Author     : hp
--%>

<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="net.sf.jasperreports.engine.JasperExportManager"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Connection"%>
<%@page import="ma.hotel.dao.DAOUtil"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            try{
            int numres=Integer.parseInt(request.getParameter("numres"));
           Connection con=DAOUtil.getConnection();
           File reportfile= new File(application.getRealPath("//report//newReport.jasper"));
           Map parameters=new HashMap();
           parameters.put("numres", numres);
           byte[] bytes= JasperRunManager.runReportToPdf(reportfile.getPath(), parameters, con);
           
           response.setContentType("application/pdf");
           response.setContentLength(bytes.length);
           ServletOutputStream outStream= response.getOutputStream();
           outStream.write(bytes, 0, bytes.length);
           outStream.flush();
           outStream.close();
           }catch(Exception e){
               out.println("ERROR: "+e.getMessage());
           }
        %>
    </body>
</html>

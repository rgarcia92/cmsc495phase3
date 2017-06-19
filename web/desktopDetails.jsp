<%-- 
    Document   : desktopDetails
    Created on : Jun 17, 2017, 11:40:34 AM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@page import="com.cmsc495phase1.models.Medications"%>
<%@page import="com.cmsc495phase1.models.DataAccess"%>
<%@page import="java.time.LocalDate" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CMSC 495 EMR Project | Medication Details</title>
    <link href="${pageContext.request.contextPath}/css/desktopStyle.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<header>
    <h1>CMSC 495 Electronic Medical Reference Project</h1>
</header>
<main>
    <h1>Medication Details Page</h1>
    <div>
        <%
            /* Get data from model and display on page */
            Medications m = DataAccess.getMedicationDetails(Integer.parseInt(request.getParameter("medID")));
        %>
        <table class="list">
            <tr><td class="detailsTD"><h2>Generic Name:</h2></td><td><h2><%= m.getGName() %></h2></td></tr>
            <tr><td class="detailsTD"><h2>Brand Name:</h2></td><td><h2><%= m.getBName() %></h2></td></tr>
            <tr><td class="detailsTD"><h2>Action:</h2></td><td><h2><%= m.getAction()%></h2></td></tr>
            <tr>
                <td class="detailsTD"><h2>Conditions:</h2></td>
                <td>
                    <h2><%= m.getCond1() %></h2>
                    <% if(m.getCond2() != null) out.println("<h2>" + m.getCond2() + "</h2>"); %>
                    <% if(m.getCond3() != null) out.println("<h2>" + m.getCond3() + "</h2>"); %>
                </td>
            </tr>
            <tr><td class="detailsTD"><h2>Controlled Substance:</h2></td><td><h2><% out.print((m.getDEA() >= 1 ) ? "<span style=\"color: blue;\">Class " + m.getDEA() + "</span>" : "No"); %></h2></td></tr>
            <tr><td class="detailsTD"><h2>Blood Thinner:</h2></td><td><h2><% out.print((m.getBTFlag() == 1) ? "<span style=\"color: red;\">Yes</span>" : "No"); %></h2></td></tr>
            <tr><td class="detailsTD"><h2>Side Effects:</h2></td><td><h2><%= m.getSide_Effects() %></h2></td></tr>
            <tr><td class="detailsTD"><h2>Interactions:</h2></td><td><h2><%= m.getInteractions() %></h2></td></tr>
            <tr><td class="detailsTD"><h2>Warnings:</h2></td><td><h2><%= m.getWarnings() %></h2></td></tr>
        </table>
    </div>
</main>
<footer>
    <hr>
    <p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
    <p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> Robert Garcia - All Rights Reserved</p>
</footer>
</body>
</html>

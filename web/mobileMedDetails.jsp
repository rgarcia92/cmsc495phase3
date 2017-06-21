<%-- 
    Document   : mobileMedDetails
    Created on : Jun 17, 2017, 12:04:09 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@page import="com.cmsc495phase1.models.DataAccess"%>
<%@page import="com.cmsc495phase1.models.Medications"%>
<%@page import="com.cmsc495phase1.models.Medications"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CMSC 495 Electronic Medical Reference Project</title>
        <link href="${pageContext.request.contextPath}/css/mobileStyle.css" rel="stylesheet" type="text/css"/>
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
            Medications m = DataAccess.selectMedicationDetails(Integer.parseInt(request.getParameter("medID")));
        %>
        <table class="list">
            <tr><td class="detailsTD" colspan="2"><h2>Generic Name:</h2></td></tr>
            <tr><td colspan="2"><h2><%= m.getGName() %></h2></td></tr>
            <tr><td class="detailsTD" colspan="2"><h2>Brand Name:</h2></td></tr>
            <tr><td colspan="2"><h2><%= m.getBName() %></h2></td></tr>
            <tr><td class="detailsTD" colspan="2"><h2>Action:</h2></td></tr>
            <tr><td colspan="2"><h2><%= m.getAction()%></h2></td></tr>
            <tr><td class="detailsTD" colspan="2"><h2>Conditions:</h2></td></tr>
            <tr>
                <td colspan="2">
                    <h2><%= m.getCond1() %></h2>
                    <% if(m.getCond2() != null) out.println("<h2>" + m.getCond2() + "</h2>"); %>
                    <% if(m.getCond3() != null) out.println("<h2>" + m.getCond3() + "</h2>"); %>
                </td>
            </tr>
            <tr>
                <td class="detailsTD split50"><h2>Blood Thinner:</h2></td>
                <td class="detailsTD split50"><h2>Controlled:</h2></td>
            </tr>
            <tr>
                <td><h2><% out.print((m.getBTFlag() == 1) ? "<span style=\"color: red;\">Yes</span>" : "No"); %></h2></td>
                <td><h2><% out.print((m.getDEA() >= 1 ) ? "<span style=\"color: cyan;\">Class " + m.getDEA() + "</span>" : "No"); %></h2></td>
            </tr>
            <tr><td class="detailsTD" colspan="2"><h2>Side Effects:</h2></td></tr>
            <tr><td colspan="2"><h2><%= m.getSide_Effects() %></h2></td></tr>
            <tr><td class="detailsTD" colspan="2"><h2>Interactions:</h2></td></tr>
            <tr><td colspan="2"><h2><%= m.getInteractions() %></h2></td></tr>
            <tr><td class="detailsTD" colspan="2"><h2>Warnings:</h2></td></tr>
            <tr><td colspan="2"><h2><%= m.getWarnings() %></h2></td></tr>
        </table>
    </div>
    </main>
    <footer class="backFooter">
        <button class="backButton" onclick="goBack()">Go Back</button>
        <script>
            /* Use history function instead of a redirect */
            function goBack() {
                window.history.back();
            }
        </script>
    </footer>
    </body>
</html>


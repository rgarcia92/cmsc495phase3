<%-- 
    Document   : mobileConDetails
    Created on : Jun 21, 2017, 12:14:33 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.cmsc495phase1.models.Medications"%>
<%@page import="com.cmsc495phase1.models.Conditions"%>
<%@page import="com.cmsc495phase1.models.DataAccess"%>
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
    <h1>Condition Details Page</h1>
    <div>
        <%
            /* Get data from model and display on page */
            Conditions c = DataAccess.selectConditionDetails(Integer.parseInt(request.getParameter("conID")));
            ArrayList<Medications> medications = DataAccess.selectMedicationsInCondition(Integer.parseInt(request.getParameter("conID")));
        %>
        <table class="list">
            <tr><td class="detailsTD"><h2>Condition:</h2></td></tr>
            <tr><td><h2><%= c.getCondition() %></h2></td></tr>
            <tr><td class="detailsTD"><h2>Description:</h2></td></tr>
            <tr><td><h2><%= c.getDescription() %></h2></td></tr>
            <tr><td class="detailsTD"><h2>Medications:</h2></td></tr>
            <%
                for (Medications m : medications) {
                    out.println("<tr><td><h2><a href=\"mobileMedDetails.jsp?medID=" + m.getMedID() + "\">" + m.getGName() + " <span class=\"listAKA\">aka</span> " + m.getBName() + "</a></h2></td><tr>");
                }
            %>
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

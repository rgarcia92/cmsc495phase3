<%-- 
    Document   : mobileResults
    Created on : Jun 17, 2017, 12:08:34 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.cmsc495phase1.models.Medications"%>
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
            <table class="list">
                <%
                    /* Retrieve POST parameter */
                    String keypadLetterGroup = request.getParameter("button");
                    if (Integer.parseInt(keypadLetterGroup) < 20) {
                        out.println("<tr class=\"listTitleRow\"><td><h2>NAME:</h2></td><td><h2>CONDITION:</h2></td></tr>");
                        /* Get data from model and display on page */
                        /* Remove flag value */
                        ArrayList<Medications> medications = DataAccess.selectAllMedications(Integer.parseInt(keypadLetterGroup) - 10);
                        for(Medications m : medications) {
                        /* Print blood thinners in red */
                            out.print(
                                /* CSS not working - using style instead */
                                ((m.getBTFlag() == 1) ? "<tr style=\"background-color: red; color: white;\">" : "<tr>") +
                                        "<td><h2><a href=\"mobileDetails.jsp?medID=" + m.getMedID() + "\">" + m.getGName() + " <span class=\"listAKA\">aka</span> " + m.getBName() + "</a></h2></td>" +
                                        "<td><h2>" + m.getCond1() + "</h2>");
                                if(m.getCond2() != null) out.print("<h2>" + m.getCond2() + "</h2>");
                                if(m.getCond3() != null) out.print("<h2>" + m.getCond3() + "</h2>");
                                out.print("</td></tr>");
                        }

                    } else {
                        out.println("<h1>In Development</h1>");
                        out.println("<img src=\"under-construction.png\" alt=\"In Development\"/>");

                    }
                %>
            </table>
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
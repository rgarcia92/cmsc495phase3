<%-- 
    Document   : desktopHome
    Created on : Jun 17, 2017, 8:14:06 AM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@page import="com.cmsc495phase1.models.DataAccess"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.cmsc495phase1.models.Medications"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CMSC 495 Electronic Medical Reference Project</title
    </head>
    <body>
        <header>
            <h1>CMSC 495 Electronic Medical Reference Project</h1>
            <h2>Desktop View - Current as of 2017</h2>
        </header>
        <main>
            <table>
                <thead>
                    <tr>
                        <td><h2>GENERIC NAME</h2></td>
                        <td><h2>BRAND NAME</h2></td>
                        <td><h2>CONDITION</h2></td>
                    </tr>
                </thead>
                <tbody>
                <%
                    /* Get data from model and display on page */
                    ArrayList<Medications> medications = DataAccess.selectMedicationsByGenericName();
                    for(Medications m : medications) {
                        /* Print blood thinners in red */
                        out.print(
                                ((m.getBTFlag() == 1) ? "<tr style=\"background-color: red; color: white;\">" : "<tr>") +
                                "<td><h2>" + m.getGName() + "</h2></td>" +
                                "<td><h2>" + m.getBName() + "</h2></td>" +
                                "<td><h2>" + m.getCond1() + "</h2></td>" +
                                "</tr>");
                    }
                %>
                </tbody>
            </table>
        </main>
        <footer>
            <hr>
            <p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
            <p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> Robert Garcia - All Rights Reserved</p>
        </footer>
    </body>
</html>

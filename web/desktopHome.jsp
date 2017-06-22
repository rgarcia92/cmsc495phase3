<%-- 
    Document   : desktopHome
    Created on : Jun 17, 2017, 8:14:06 AM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@page import="com.cmsc495phase1.models.DataAccess"%>
<%@page import="com.cmsc495phase1.models.Medications"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CMSC 495 Electronic Medical Reference Project</title>
        <link type="text/css" href="${pageContext.request.contextPath}/css/desktopStyle.css" rel="stylesheet"/>
        <!-- load jQuery and tablesorter scripts -->
        <link type="text/css" href="${pageContext.request.contextPath}/css/theme.blue.css" rel="stylesheet"/>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
        <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.tablesorter.combined.js"></script>
        <script id="js">
            $(function() {
                $("#desktopTable").tablesorter({
                    sortList:[[0,0]],
                    widgets: ["filter"],
                    widgetOptions : {
                        filter_external : '.search',
                        filter_columnFilters: false,
                        filter_saveFilters : false,
                        filter_reset: '.reset'
                    }
                });
            });
        </script>
    </head>
    <body>
        <header>
            <h1>CMSC 495 Electronic Medical Reference Project</h1>
            <h2>Desktop View - Current as of 2017</h2>
            <noscript>
                <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
            </noscript>
        </header>
        <main>
            <div class="searchBox"><b>Search: <input class="search" type="search" placeholder="Search" data-column="all" /></b></div>
            <table id="desktopTable" class="list tablesorter">
                <thead>
                    <tr class="listTitleRow">
                        <td><h2>GENERIC NAME <img src="up-down-arrow.png" alt="" /></h2></td>
                        <td><h2>BRAND NAME <img src="up-down-arrow.png" alt="" /></h2></td>
                        <td><h2>CONDITION <img src="up-down-arrow.png" alt="" /></h2></td>
                    </tr>
                </thead>
                <tbody>
                <%
                    /* Get data from model and display on page */
                    ArrayList<Medications> medications = DataAccess.selectMedicationsByGenericName();
                    for(Medications m : medications) {
                        /* Print blood thinners in red */
                        out.print(
                            /* CSS not working - using style instead */
                            ((m.getBTFlag() == 1) ? "<tr style=\"background-color: red; color: white;\">" : "<tr>") +
                            "<td><h2><a href=\"desktopDetails.jsp?medID=" + m.getMedID() + "\" title=\"" + m.getGName() + "\">" + m.getGName() + "</a></h2></td>" +
                            "<td><h2><a href=\"desktopDetails.jsp?medID=" + m.getMedID() + "\" title=\"" + m.getBName() + "\">" + m.getBName() + "</a></h2></td>" +
                            "<td><h2>" + m.getCond1() + "</h2>");
                        if(m.getCond2() != null) out.print("<h2>" + m.getCond2() + "</h2>");
                        if(m.getCond3() != null) out.print("<h2>" + m.getCond3() + "</h2>");
                        out.print("</td></tr>");
                    }
                %>
                </tbody>
            </table>
        </main>
        <footer>
            <hr>
            <p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
            <p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> - All Rights Reserved</p>
        </footer>
    </body>
</html>

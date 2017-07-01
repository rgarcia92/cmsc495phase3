<%-- 
    Document   : desktopDetails
    Created on : Jun 17, 2017, 11:40:34 AM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CMSC 495 EMR Project | Medication Details</title>
        <link href="${pageContext.request.contextPath}/css/desktopStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/mobileHome.jsp"/>
        </c:if>
        <c:if test = "${fn:length(param.medID) > 2}">
            <c:redirect url="/error.jsp"/>
        </c:if>
        <header>
            <h1>CMSC 495 Electronic Medical Reference Project</h1>
        </header>
        <main>
            <h1>Medication Details Page</h1>
            <!-- Get data from model and display on page -->
            <jsp:useBean id="dataAccess" class="com.cmsc495phase2.models.DataAccess">
                <jsp:setProperty name="dataAccess" property="*" />
            </jsp:useBean>
            <c:set var="m" value="${dataAccess.selectMedicationDetails(param.medID)}" />
            <table class="list">
                <tr><td class="detailsTD"><h2>Generic Name:</h2></td><td><h2>${m.GName}</h2></td></tr>
                <tr><td class="detailsTD"><h2>Brand Name:</h2></td><td><h2>${m.BName}</h2></td></tr>
                <tr><td class="detailsTD"><h2>Action:</h2></td><td><h2>${m.action}</h2></td></tr>
                <tr>
                    <td class="detailsTD"><h2>Conditions:</h2></td>
                    <td>
                        <h2>${m.cond1}</h2>
                        <h2>${m.cond2}</h2>
                        <h2>${m.cond3}</h2>
                    </td>
                </tr>
                <tr><td class="detailsTD"><h2>Blood Thinner:</h2></td><td><h2 style="${m.BTFlag == 1 ? 'color: red' : ''}">${m.BTFlag == 1 ? "Yes" : "No"}</h2></td></tr>
                <tr><td class="detailsTD"><h2>Controlled Substance:</h2></td><td><h2 style="${m.DEA >= 1 ? 'color: blue' : ''}">${m.DEA >= 1 ? "Class " : ""}${m.DEA >= 1 ? m.DEA : "No"}</h2></td></tr>
                <tr><td class="detailsTD"><h2>Side Effects:</h2></td><td><h2>${m.side_Effects}</h2></td></tr>
                <tr><td class="detailsTD"><h2>Interactions:</h2></td><td><h2>${m.interactions}</h2></td></tr>
                <tr><td class="detailsTD"><h2>Warnings:</h2></td><td><h2>${m.warnings}</h2></td></tr>
            </table>
        </main>
        <footer>
            <hr>
            <p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
            <p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> - All Rights Reserved</p>
            <div class="loginKey"><a href="login.jsp" title="Login"><img src="login-key.png" alt="Login"/></a></div>
        </footer>
    </body>
</html>

<%-- 
    Document   : mobileMedDetails
    Created on : Jun 17, 2017, 12:04:09 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CMSC 495 Electronic Medical Reference Project</title>
        <link href="${pageContext.request.contextPath}/css/mobileStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${!fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/desktopHome.jsp"/>
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
            <c:set var="m" value='${dataAccess.selectMedicationDetails(param.medID)}' />
            <table class="list">
                <tr><td class="detailsTD" colspan="2"><h2>Generic Name:</h2></td><tr>
                <tr><td colspan="2"><h2>${m.GName}</h2></td></tr>
                <tr><td class="detailsTD" colspan="2"><h2>Brand Name:</h2></td></tr>
                <tr><td colspan="2"><h2>${m.BName}</h2></td></tr>
                <tr><td class="detailsTD" colspan="2"><h2>Action:</h2></td></tr>
                <tr><td colspan="2"><h2>${m.action}</h2></td></tr>
                <tr><td class="detailsTD" colspan="2"><h2>Conditions:</h2></td></tr>
                <tr><td colspan="2">
                        <h2>${m.cond1}</h2>
                        <h2>${m.cond2}</h2>
                        <h2>${m.cond3}</h2>
                </td></tr>
                <tr>
                    <td class="detailsTD split50"><h2>Blood Thinner:</h2></td>
                    <td class="detailsTD split50"><h2>Controlled Substance:</h2></td>
                </tr>
                <tr>
                    <td><h2 style="${m.BTFlag == 1 ? 'color: orangered' : ''}">${m.BTFlag == 1 ? "Yes" : "No"}</h2></td>
                    <td><h2 style="${m.DEA >= 1 ? 'color: cyan' : ''}">${m.DEA >= 1 ? "Class " : ""}${m.DEA >= 1 ? m.DEA : "No"}</h2></td>
                </tr>
                <tr><td class="detailsTD" colspan="2"><h2>Side Effects:</h2></td></tr>
                <tr><td colspan="2"><h2>${m.side_Effects}</h2></td></tr>
                <tr><td class="detailsTD" colspan="2"><h2>Interactions:</h2></td></tr>
                <tr><td colspan="2"><h2>${m.interactions}</h2></td></tr>
                <tr><td class="detailsTD" colspan="2"><h2>Warnings:</h2></td></tr>
                <tr><td colspan="2"><h2>${m.warnings}</h2></td></tr>
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


<%-- 
    Document   : adminEditMedication
    Created on : Jul 4, 2017, 9:58:43 PM
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
        <title>CMSC 495 EMR Project | Admin Menu</title>
        <jsp:include page="masters/adminHead.jsp" />
    </head>
    <body>
        <!-- This needs to stay here since you cannot redirect from an included file -->
        <!-- Redirect if not authenticated -->
        <c:if test="${sessionScope['loggedIn'] == false}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/mobileHome.jsp"/>
        </c:if>
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <header>
            <h1>CMSC 495 Electronic Medical Reference Project</h1>
            <h2>Edit Medication</h2>
        </header>
        <main style="text-align: left; width: 100%;">
            <form action="adminMenu.jsp" method="post">
                <p><input type="submit" value="Return to Medications Administration" /></p>
            </form>
            <!-- Get data from model and display on page -->
            <c:if test="${!((fn:escapeXml(param.medID)).matches('[0-9]+'))}">
                <c:redirect url="/desktopHome.jsp"/>
            </c:if>
            <jsp:useBean id="dataAccess" class="com.cmsc495phase3.models.DataAccess">
                <jsp:setProperty name="dataAccess" property="*" />
            </jsp:useBean>
            <c:set var="m" value="${dataAccess.selectMedicationDetails(fn:escapeXml(param.medID))}" />
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
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>


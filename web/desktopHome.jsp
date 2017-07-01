<%-- 
    Document   : desktopHome
    Created on : Jun 17, 2017, 8:14:06 AM
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
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/mobileHome.jsp"/>
        </c:if>
        <header>
            <h1>CMSC 495 Electronic Medical Reference Project</h1>
            <h2>Desktop View - Current as of 2017</h2>
            <noscript>
                <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
            </noscript>
        </header>
        <main>
            <div class="searchBox"><b>Search: <input class="search" type="search" placeholder="Search" data-column="all" /></b></div>
            <!-- Get data from model and display on page -->
            <jsp:useBean id="dataAccess" class="com.cmsc495phase2.models.DataAccess">
                <jsp:setProperty name="dataAccess" property="*" />
            </jsp:useBean>
            <c:set var="meds" value='${dataAccess.selectMedicationsByGenericName()}' />
            <table id="desktopTable" class="list tablesorter">
                <thead>
                    <tr class="listTitleRow">
                        <td><h2>GENERIC NAME <img src="up-down-arrow.png" alt="<>" /></h2></td>
                        <td><h2>BRAND NAME <img src="up-down-arrow.png" alt="<>" /></h2></td>
                        <td><h2>CONDITION <img src="up-down-arrow.png" alt="<>" /></h2></td>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${meds}" var="m">
                    <!-- Highlight blood thinners in red -->
                    <tr style="${m.BTFlag == 1 ? 'background-color: red; color: white' : ''}">
                        <td><h2><a href="desktopDetails.jsp?medID=${m.medID}" title="${m.GName}">${m.GName}</a></h2></td>
                        <td><h2><a href="desktopDetails.jsp?medID=${m.medID}" title="${m.GName}">${m.BName}</a></h2></td>
                        <td>
                            <h2>${m.cond1}</h2>
                            <h2>${m.cond2 != null ? m.cond2 : ''}</h2>
                            <h2>${m.cond3 != null ? m.cond3 : ''}</h2>
                        </td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
        <footer>
            <hr>
            <p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
            <p>
                Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> - All Rights Reserved
                <span class="loginKey"><a href="login.jsp" title="Login"><img src="login-key.png" alt="Login"/></a></span>
            </p>
        </footer>
    </body>
</html>

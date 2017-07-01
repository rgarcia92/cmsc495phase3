<%-- 
    Document   : loginAuthenticate
    Created on : Jun 30, 2017, 12:25:29 PM
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
    </head>
    <body>
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/mobileHome.jsp"/>
        </c:if>
        <header>
            <h1>CMSC 495 Electronic Medical Reference Project</h1>
            <h2>Authentication Page</h2>
            <noscript>
                <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
            </noscript>
        </header>
        <main>
            <c:if test="${ empty param.username or empty param.password}">
                <c:redirect url="login.jsp" >
                    <c:param name="errorMessage" value="Please enter your user name and password" />
                </c:redirect>
            </c:if>
            <c:if test="${not empty param.username and not empty param.password}">
                <jsp:useBean id="utilities" class="com.cmsc495phase2.models.Utilities">
                    <jsp:setProperty name="utilities" property="*" />
                </jsp:useBean>
                <jsp:useBean id="dataAccess" class="com.cmsc495phase2.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <!-- Authenticate user and set session variables -->
                <c:choose>
                    <c:when test="${utilities.authenticate(param.username, param.password)}">
                        <c:set var="u" value="${dataAccess.selectUser(param.username)}" />
                        <c:set scope="session" var="loggedIn" value="true" />
                        <c:set scope="session" var="username" value="${param.username}" />
                        <c:set scope="session" var="role" value="${u.role}" />
                        <c:set scope="session" var="lockedOut" value="${u.lockedOut}" />
                        <c:set scope="session" var="lastLogin" value="${u.lastLogin}" />
                        <c:redirect url="adminMenu.jsp"/>
                    </c:when>
                    <c:otherwise>
                        <c:redirect url="login.jsp" >
                            <c:param name="errorMessage" value="Invalid username or password" />
                        </c:redirect>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </main>
        <footer>
            <hr>
            <p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
            <p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> - All Rights Reserved</p>
        </footer>
    </body>
</html>

<%-- 
    Document   : login
    Created on : Jun 28, 2017, 2:52:37 PM
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
    </head>
    <body>
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/mobileHome.jsp"/>
        </c:if>
        <header>
            <h1>CMSC 495 Electronic Medical Reference Project</h1>
            <h2>Login Page</h2>
            <noscript>
                <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
            </noscript>
        </header>
        <main>
            <form action="${pageContext.request.contextPath}/loginAuthenticate.jsp">
                <h3>Username: <input type="text" name="username" /></h3>
                <h3>Password: <input type="password" name="password" /></h3>
                <input type="submit" />
            </form>
            <font color="red">
                <c:if test="${not empty param.errorMessage}">
                    <h3><c:out value="${param.errorMessage}" /></h3>
                </c:if>
            </font>
        </main>
        <footer>
            <hr>
            <p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
            <p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> - All Rights Reserved</p>
        </footer>
    </body>
</html>

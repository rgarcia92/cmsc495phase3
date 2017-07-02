<%-- 
    Document   : adminMenu
    Created on : Jun 28, 2017, 4:46:46 PM
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
            <h2>Admin Menu</h2>
        </header>
        <main>
            <h2>Welcome, ${sessionScope['username']}!</h2>
            <div style="text-align: left; width: 100%;">
                <hr>
                <h2>If you can read this, you have User privileges!</h2>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
                <jsp:useBean id="utilities" class="com.cmsc495phase2.models.Utilities">
                    <jsp:setProperty name="utilities" property="*" />
                </jsp:useBean>
                <c:if test="${sessionScope['role'] == 'Editor' || sessionScope['role'] == 'Administrator'}">
                    <hr>
                    <h2>If you can read this, you have Editor privileges!</h2>
                    <p><b>Role:</b> ${sessionScope['role']}</p>
                    <p><b>Locked Out:</b> ${sessionScope['lockedOut'] == 1 ? "Yes" : "No"}</p>
                    <p><b>Last Login:</b> ${sessionScope['lastLogin']}</p>
                </c:if>
                <c:if test="${sessionScope['role'] == 'Administrator'}">
                    <hr>
                    <h2>If you can read this, you have Administrator privileges!</h2>
                    <p><b>Event Log:</b></p>
                    <c:set var="events" value="${utilities.readEventLog()}" />
                    <c:forEach items="${events}" var="e">
                        <p><c:out value="${e}" /><p>
                    </c:forEach>
                </c:if>
            </div>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>

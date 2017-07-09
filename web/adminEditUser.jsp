<%-- 
    Document   : adminEditUser
    Created on : Jul 4, 2017, 10:04:21 PM
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
        <!-- Redirect if mobile -->
        <c:set var="browser" value="${header['User-Agent']}" scope="session" />
        <c:if test = "${fn:containsIgnoreCase(browser, 'mobi')}">
            <c:redirect url="/mobileHome.jsp"/>
        </c:if>
        <!-- Redirect if not authenticated -->
        <c:if test="${sessionScope['loggedIn'] != true || sessionScope['role'] != 'Administrator'}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <header>
            <h1>CMSC 495 Electronic Medical Reference Project</h1>
            <h2>Edit User</h2>
        </header>
        <main>
            <div style="text-align: left; width: 100%;">
                <p>
                    <form action="adminListUsers.jsp" method="post" style="display: inline;">
                        <input type="submit" value="Return to User Administration Menu" />
                    </form>&nbsp;or&nbsp;
                    <form action="logout.jsp" method="post" style="display: inline;">
                        <input type="submit" value="Log Out" />
                    </form>
                </p>
                <hr>
                <h2>User Information:</h2>
                <jsp:useBean id="dataAccess" class="com.cmsc495phase3.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <c:set var="u" value="${dataAccess.selectUser(param.userName)}" />
                <table>
                    <tr><td><b>User Name:</b></td><td>${u.userName}</td></tr>
                    <tr><td><b>Role:</b></td><td>${u.role}</td></tr>
                    <tr><td><b>Salt:</b></td><td>${u.salt}</td></tr>
                    <tr><td><b>Hash:</b></td><td>${u.passwordHash}</td></tr>
                    <tr><td><b>Locked Out:</b></td><td>${u.lockedOut == 1 ? "Yes" : "No"}</td></tr>
                    <tr><td><b>Last Login:</b></td><td>${u.lastLogin}</td></tr>
                </table>
                <hr>
                <form action="" method="post">
                    <p><input type="submit" value="Reset Password" /></p>
                </form>
                <form action="" method="post">
                    <p><input type="submit" name="submit" value="Delete User" style="display: inline;" onclick="return confirm('Are you sure you want to delete this user?');"></p>
                </form>
                <font color="red">
                    <c:if test="${not empty fn:escapeXml(param.errorMessage)}">
                        <h3>${fn:escapeXml(param.errorMessage)}</h3>
                    </c:if>
                </font>
            </div>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>


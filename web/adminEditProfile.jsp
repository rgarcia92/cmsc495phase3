<%-- 
    Document   : adminEditProfile
    Created on : Jul 4, 2017, 5:27:15 PM
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
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</td></tr>
        </noscript>
        <header>
            <h1>CMSC 495 Electronic Medical Reference Project</h1>
            <h2>View and Edit Profile</h2>
        </header>
        <main>
            <c:catch var="catchException">
            <h2>Welcome, ${sessionScope['uname']}!</h2>
            <div style="text-align: left; width: 100%;">
                <form action="adminMenu.jsp" method="post">
                    <p><input type="submit" value="Return to Administration Menu" /></p>
                </form>
                <hr>
                <h2>User Information:</h2>
                <jsp:useBean id="dataAccess" class="com.cmsc495phase3.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <c:set var="u" value="${dataAccess.selectUser(sessionScope['uname'])}" />
                <table>
                    <tr><td><b>User Name:</b></td><td>${u.userName}</td></tr>
                    <tr><td><b>Role:</b></td><td>${u.role}</td></tr>
                    <tr><td><b>Locked Out:</b></td><td>${u.lockedOut == 1 ? "Yes" : "No"}</td></tr>
                    <tr><td><b>Last Login:</b></td><td>${u.lastLogin}</td></tr>
                </table>
                <hr>
                <h2>Change Password:</h2>
                <form action="${pageContext.request.contextPath}/adminUpdatePassword.jsp" method="post">
                    <h3>Old Password:</h3>
                    <input type="password" name="oldPassword" required />
                    <h3>New Password:</h3>
                    <input type="password" name="newPassword" required />
                    <input type="hidden" name="uname" value="${u.userName}" required />
                    <p><input type="submit" /></p>
                </form>
                <font color="red">
                    <c:if test="${not empty fn:escapeXml(param.errorMessage)}">
                        <h3>${fn:escapeXml(param.errorMessage)}</h3>
                    </c:if>
                </font>
            </div>
            </c:catch>
            <p>${catchException == null ? '' : catchException.message}</p>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>
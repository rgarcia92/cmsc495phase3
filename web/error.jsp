<%-- 
    Document   : error
    Created on : Jun 25, 2017, 6:00:50 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ page import="java.time.LocalDate" %>
<%@ page isErrorPage="true" import="java.io.*" contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CMSC 495 EMR Project | Error Page</title>
        <link href="${pageContext.request.contextPath}/css/desktopStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <header>
            <h1>Oops! Something went wrong!</h1>
            <img src="error.gif" alt="Oops! Something went wrong!" />
        </header>
        <main>
            <h2>We're sorry, but the following error has occurred:</h2>
            <h2 class="errorText">${pageContext.exception.getMessage()}</span></h2>
            <jsp:useBean id="utilities" class="com.cmsc495phase2.models.Utilities">
                <jsp:setProperty name="utilities" property="*" />
            </jsp:useBean>
            ${utilities.logEvent(pageContext.exception)}
            <h2>We've been notified and we're working on it. Meantime, if you have any questions, contact us at <a href="mailto:rgarcia92@student.umuc.edu"><span itemprop="email">rgarcia92@student.umuc.edu</span></a>.</h2>
        </main>
        <footer>
            <hr>
            <p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
            <p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> - All Rights Reserved</p>
        </footer>
    </body>
</html>

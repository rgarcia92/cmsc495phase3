<%-- 
    Document   : error
    Created on : Jun 25, 2017, 6:00:50 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ page isErrorPage="true" import="java.io.*" contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>CMSC 495 EMR Project | Error Page</title>
        <jsp:include page="desktopHead.jsp" />
    </head>
    <body>
        <header>
            <h1>Oops! Something went wrong!</h1>
            <img src="error.gif" alt="Oops! Something went wrong!" />
        </header>
        <main>
            <h2>We're sorry, but the following error has occurred:</h2>
            <h2 class="errorText">${pageContext.exception.getMessage()}</span></h2>
            <jsp:useBean id="utilities" class="com.cmsc495phase3.models.Utilities">
                <jsp:setProperty name="utilities" property="*" />
            </jsp:useBean>
            ${utilities.logEvent(pageContext.exception)}
            <h2>We've been notified and we're working on it. Meantime, if you have any questions, contact us at <a href="mailto:rgarcia92@student.umuc.edu"><span itemprop="email">rgarcia92@student.umuc.edu</span></a>.</h2>
        </main>
        <footer>
            <jsp:include page="desktopFooter.jsp" />
        </footer>
    </body>
</html>

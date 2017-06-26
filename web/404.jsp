<%-- 
    Document   : 404
    Created on : Jun 26, 2017, 2:21:47 PM
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
            <h1>Oops! That page does not exist!</h1>
            <img src="error.gif" alt="Oops! That page does not exist!" />
        </header>
        <main>
        <h2>We're sorry, but that page does not exist</h2>
        <h2><a href="desktopHome.jsp" title="Home Page">Click here to return to the home page.</a></h2>
        </main>
        <footer>
            <hr>
            <p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
            <p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> - All Rights Reserved</p>
        </footer>
    </body>
</html>

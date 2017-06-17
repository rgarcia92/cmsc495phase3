<%-- 
    Document   : desktopDetails
    Created on : Jun 17, 2017, 11:40:34 AM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ page import="java.time.LocalDate" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CMSC 495 EMR Project | Medication Details</title>
    <link href="${pageContext.request.contextPath}/css/desktopStyle.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<header>
    <h1>CMSC 495 Electronic Medical Reference Project</h1>
</header>
<main>
    <h1>Medication Details Page</h1>
    <h2>In Development</h2>
    <img src="under-construction.png" alt="In Development"/>
</main>
<footer>
    <hr>
    <p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
    <p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> Robert Garcia - All Rights Reserved</p>
</footer>
</body>
</html>

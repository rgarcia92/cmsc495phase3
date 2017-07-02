<%-- 
    Document   : desktopFooter
    Created on : Jul 1, 2017, 6:58:35 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@ page import="java.time.LocalDate" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<hr>
<p>CMSC 495 6380 Current Trends and Projects in Computer Science (2175) Project</p>
<p>Copyright &copy; <% out.println((LocalDate.now().getYear() == 2017) ? "2017" : "2017 - " + String.valueOf(LocalDate.now().getYear())); %> - All Rights Reserved</p>
<div class="loginKey"><a href="login.jsp" title="Login"><img src="login-key.png" alt="Login"/></a></div>
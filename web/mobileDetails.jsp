<%-- 
    Document   : mobileDetails
    Created on : Jun 17, 2017, 12:04:09 PM
    Author     : Rob Garcia at rgarcia92.student.umuc.edu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CMSC 495 Electronic Medical Reference Project</title>
        <link href="${pageContext.request.contextPath}/css/mobileStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
    <header>
        <h1>CMSC 495 Electronic Medical Reference Project</h1>
    </header>
    <main>
        <h1>In Development</h1>
        <img src="under-construction.png" alt="In Development"/>
    </main>
    <footer class="backFooter">
        <button class="backButton" onclick="goBack()">Go Back</button>
        <script>
            /* Use history function instead of a redirect */
            function goBack() {
                window.history.back();
            }
        </script>
    </footer>
    </body>
</html>


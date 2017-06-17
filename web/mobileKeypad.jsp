<%-- 
    Document   : mobileKeypad
    Created on : Jun 17, 2017, 12:05:57 PM
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
            <%
                /* Set base flag for medications as 10 and for conditions as 20 */
                int flag = Integer.parseInt(request.getParameter("button")) * 10;
                out.println(flag == 10 ? "<h1>Medication Listing</h1>" : "<h1>Condition Listing</h1>");
                ;
            %>
        </header>
        <main>
            <form action="${pageContext.request.contextPath}/mobileResults.jsp" method="post">
                <table class="keypad">
                    <tr>
                        <!-- h1 only renders properly with css -->
                        <!-- Add flag to key value -->
                        <td class="keys"><button type="submit" name="button" value="<%= flag + 1 %>">A B C</button></td>
                        <td class="keys"><button type="submit" name="button" value="<%= flag + 2 %>">D E F</button></td>
                        <td class="keys"><button type="submit" name="button" value="<%= flag + 3 %>">G H I</button></td>
                    </tr>
                    <tr>
                        <td class="keys"><button type="submit" name="button" value="<%= flag + 4 %>">J K L</button></td>
                        <td class="keys"><button type="submit" name="button" value="<%= flag + 5 %>">M N O</button></td>
                        <td class="keys"><button type="submit" name="button" value="<%= flag + 6 %>">P Q R</button></td>
                    </tr>
                    <tr>
                        <td class="keys"><button type="submit" name="button" value="<%= flag + 7 %>">S T U</button></td>
                        <td class="keys"><button type="submit" name="button" value="<%= flag + 8 %>">V W X</button></td>
                        <td class="keys"><button type="submit" name="button" value="<%= flag + 9 %>">Y Z</button></td>
                    </tr>
                </table>
            </form>
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
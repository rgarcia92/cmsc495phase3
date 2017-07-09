<%-- 
    Document   : adminEditMedication
    Created on : Jul 4, 2017, 9:58:43 PM
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
        <c:if test="${sessionScope['loggedIn'] != true && (sessionScope['role'] != 'Editor' || sessionScope['role'] != 'Administrator')}">
            <c:redirect url="/login.jsp" />
        </c:if>
        <noscript>
            <p class="warningText">(Javascript disabled. Please enable Javascript for full functionality)</p>
        </noscript>
        <header>
            <h1>CMSC 495 Electronic Medical Reference Project</h1>
            <h2>Edit Medication</h2>
        </header>
        <main>
            <c:catch var="catchException">
            <h2>Welcome, ${sessionScope['uname']}!</h2>
            <div style="text-align: left; width: 100%;">
                <p>
                    <form action="adminListMedications.jsp" method="post" style="display: inline;">
                        <input type="submit" value="Return to Medications Administration Menu" />
                    </form>&nbsp;or&nbsp;
                    <form action="logout.jsp" method="post" style="display: inline;">
                        <input type="submit" value="Log Out" />
                    </form>
                </p>
                <!-- Get data from model and display on page -->
                <c:if test="${!((fn:escapeXml(param.medID)).matches('[0-9]+'))}">
                    <c:redirect url="/adminListMedications.jsp"/>
                </c:if>
                <font color="red">
                    <c:if test="${not empty fn:escapeXml(param.errorMessage)}">
                        <h3>${fn:escapeXml(param.errorMessage)}</h3>
                    </c:if>
                </font>
                <jsp:useBean id="dataAccess" class="com.cmsc495phase3.models.DataAccess">
                    <jsp:setProperty name="dataAccess" property="*" />
                </jsp:useBean>
                <c:set var="m" value="${dataAccess.selectMedicationDetails(fn:escapeXml(param.medID))}" />
                <c:set var="cons" value='${dataAccess.selectAllConditions()}' />
                <form action="${pageContext.request.contextPath}/adminUpdateMedication.jsp" method="post">
                    <input type="hidden" name="medID" value="${param.medID}" />
                    <table class="list">
                        <tr><td class="detailsTD" style="width:20em;"><h2>Generic Name:</h2></td>
                            <td><h2><input type="text" name="GName" value="${m.GName}" maxlength="50"></h2></td></tr>
                        <tr><td class="detailsTD"><h2>Brand Name:</h2></td>
                            <td><h2><input type="text" name="BName" value="${m.BName}" maxlength="50"></h2></td></tr>
                        <tr><td class="detailsTD"><h2>Action:</h2></td>
                            <td><h2><input type="text" name="action" value="${m.action}" maxlength="50"></h2></td></tr>
                        <tr>
                            <td class="detailsTD"><h2>Conditions:</h2></td>
                            <td>
                                <h2>
                                <select name="cond1">
                                    <option value=""></option>
                                    <c:forEach items="${cons}" var="c">
                                        <option disabled ${c.condition == m.cond1 ? 'selected' : ''} value="${c.conID}">${c.condition}</option>
                                    </c:forEach>
                                </select>
                                </h2><h2>
                                <select name="cond2">
                                    <option value=""></option>
                                    <c:forEach items="${cons}" var="c">
                                        <option disabled ${c.condition == m.cond2 ? 'selected' : ''} value="${c.conID}">${c.condition}</option>
                                    </c:forEach>
                                </select>
                                </h2><h2>
                                <select name="cond3">
                                    <option value=""></option>
                                    <c:forEach items="${cons}" var="c">
                                        <option disabled ${c.condition == m.cond3 ? 'selected' : ''} value="${c.conID}">${c.condition}</option>
                                    </c:forEach>
                                </select>
                                </h2>
                            </td>
                        </tr>
                        <tr><td class="detailsTD"><h2>Blood Thinner:</h2></td>
                            <td style="font-size: initial;">
                                <h2><input type="radio" name="BTFlag" value="1" ${m.BTFlag == 1 ? 'checked' : ''}>Yes</h2>
                                <h2><input type="radio" name="BTFlag" value="0" ${m.BTFlag != 1 ? 'checked' : ''}>No</h2>
                            </td>
                        </tr>
                        <tr><td class="detailsTD"><h2>DEA Schedule:</h2></td>
                            <td><h2><input type="number" name="DEA" value="${m.DEA}" min="0" max="5"></h2></td></tr>
                        <tr><td class="detailsTD"><h2>Side Effects:</h2></td>
                            <td><h2><textarea name="side_Effects" maxlength="512" rows="4" style="width:100%;">${m.side_Effects}</textarea></h2></td></tr>
                        <tr><td class="detailsTD"><h2>Interactions:</h2></td>
                            <td><h2><textarea name="interactions" maxlength="512" rows="4" style="width:100%;">${m.interactions}</textarea></h2></td></tr>
                        <tr><td class="detailsTD"><h2>Warnings:</h2></td>
                            <td><h2><textarea name="warnings" maxlength="512" rows="4" style="width:100%;">${m.warnings}</textarea></h2></td></tr>
                    </table>
                    <p style="text-align: center;">
                        <input type="submit" name="submit" value="Update" style="display: inline;">&nbsp;or
                        <input type="submit" name="submit" value="Delete" style="display: inline;" onclick="return confirm('Are you sure you want to delete this item?');">
                    </p>
                </form>
            </div>
            </c:catch>
            <p>${catchException == null ? '' : catchException.message}</p>
        </main>
        <footer>
            <jsp:include page="masters/adminFooter.jsp" />
        </footer>
    </body>
</html>


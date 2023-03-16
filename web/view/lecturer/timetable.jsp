<%-- 
    Document   : timetable
    Created on : Mar 10, 2023, 4:08:36 PM
    Author     : sonnt
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FU AT</title>
        <link rel="stylesheet" href="../view/css/styletimetable.css">
    </head>
    <body>
        <div class="header">
            <div class="header-info"><h1>FPT University Attendance Taking</h1></div>

            <div class="header-img">
                <img src="../view/img/fpt-university-logo.png" alt="Image description"/>
            </div>
        </div>
        <div class="lecturerinput">
            <form id="lecturerForm" action="timetable" method="POST">
                <input type="text" name="lecturer" value="${requestScope.lecturer}">
                <input type="Submit" name="Submit" value="Send">
            </form>
        </div>
        
        <table class="timetable">
            <tr class="timetable-head">
                <td>
                    <div class="formYw">
                        <form id="tableForm" action="timetable" method="POST">
                        YEAR:
                        <select id="yearSelect" name="year" onchange="this.form.submit()" onchange="">
                            <option value="2022"<c:if test="${requestScope.year eq 2022}">selected</c:if> >2022</option>
                            <option value="2023" <c:if test="${requestScope.year eq 2023}">selected</c:if>>2023</option>
                        </select>
                        <br>
                        WEEK:
                        <select id="weekSelect" name="week" onchange="this.form.submit()">
                            <option value="03-06 03-12" selected="">06/03 to 12/03</option>
                        </select>
                        <input type="hidden" id="hiddenInput" name="hiddenInput" value="">
                        <input type="hidden" name="lecturer" value="${requestScope.lecturer}">
                        </form>
                    </div>
                </td>
                <c:forEach items="${requestScope.dates}" var="d">
                    <td>
                        <div class="dateDay">
                             <fmt:formatDate value="${d}" pattern="EEEE" />
                        </div>
                        <br>
                        <div class="dateWeek">
                            <fmt:formatDate value="${d}" pattern="dd/MM"/>
                        </div>
                    </td>
                </c:forEach>
            <tr/>
            <c:forEach items="${requestScope.slots}" var="s">
                <tr>
                    <td>
                        Slot ${s.id}
                        </br>
                        (
                        <fmt:formatDate value="${s.start}" pattern="HH:mm" />
                        -
                        <fmt:formatDate value="${s.end}" pattern="HH:mm" />
                        )
                    </td>
                    <c:forEach items="${requestScope.dates}" var="d">
                        <td>
                            -
                            <c:forEach items="${requestScope.sessions}" var="ses">
                                <c:if test="${ses.slot.id eq s.id and ses.date eq d}">
                                    ${ses.group.name}-${ses.group.course.id} <br/>
                                    ${ses.room.id} 
                                    <c:set var="name" value="${ses.name}"> </c:set>
                                    <c:set var="takeattend" value="Take Attend"> </c:set>
                                    <c:if test="${name eq takeattend}">-<a href="takeattend?id=${ses.id}">${ses.name}</a></c:if>
                                    <c:if test="${!(name eq takeattend)}"><a href="checkatte">-${ses.name}</c:if>
                                </c:if>
                            </c:forEach>
                        </td>
                    </c:forEach>
                <tr/> 
            </c:forEach>
        </table>
    </body>
</html>

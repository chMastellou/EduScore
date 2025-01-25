<%@ page import="java.util.List" %>
<%@ page import="com.example.eduscore.General" %><%--
  Created by IntelliJ IDEA.
  User: chara
  Date: 10/28/24
  Time: 8:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Course Application Form</title>
    <style> <%@ include file="../resources/css/grades.css"%> </style>
</head>
<body class="body">

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.

    if(session.getAttribute("username")==null)
    {
        response.sendRedirect("/");
    }

%>

<div class="container">
    <div class="table-container">
        <form id="courseForm" method="post" action="${pageContext.request.contextPath}/assign_grades">
            <table class="grades-table">
                <thead class="table-header">
                <tr>
                    <th>Name</th>
                    <th>Course</th>
                    <th>Grade</th>
                </tr>
                </thead>
                <tbody>

                <%
                    List<List<Object>> grades = General.getEmptyGrades(session.getAttribute("username").toString());

                    if (grades != null) {
                        for (List<Object> grade : grades) {
                            out.print("<tr><td>" + grade.getFirst() + "</td>");
                            out.print("<td>" + grade.getLast() + "</td>");
                            out.print("<td><input type=\"number\" min=\"0\" max=\"100\" value=\"0\" name=\"grade\"></td></tr>");
                        }
                    }
                %>

                </tbody>
            </table>
            <button type="submit" class="submit-btn" id="submitBtn">Assign Grades</button>
        </form>
    </div>
</div>

</body>
</html>
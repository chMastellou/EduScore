<%@ page import="java.util.List" %>
<%@ page import="com.example.eduscore.General" %><%--
  Created by IntelliJ IDEA.
  User: chara
  Date: 10/28/24
  Time: 8:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Grades</title>
    <style>
        <%@ include file="../resources/css/grades.css"%>
    </style>
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
    <h1>Student Grades</h1>
    <div class="table-container">
        <table class="grades-table">
            <thead>
            <tr>
                <th>Name</th>
                <th>Subject</th>
                <th>Year</th>
                <th>Grade</th>
            </tr>
            </thead>
            <tbody>

            <%
                List<List<Object>> grades = General.getTeacherGrades(session.getAttribute("username").toString());
                if (grades != null) {
                    for (List<Object> grade : grades) {
                        out.print("<tr><td>" + grade.get(0) + "</td>");
                        out.print("<td>" + grade.get(1) + "</td>");
                        out.print("<td>" + grade.get(2) + "</td>");
                        out.print("<td>" + grade.get(3) + "</td></tr>");
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>



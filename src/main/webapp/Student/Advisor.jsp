<%@ page import="com.example.eduscore.General" %>
<%@ page import="java.util.List" %>
<%@ page import="static com.example.eduscore.General.getCourseMedian" %><%--
  Created by IntelliJ IDEA.
  User: chara
  Date: 10/28/24
  Time: 7:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Student Advisor</title>
    <style>
        <%@ include file="../resources/css/advisor.css"%>
    </style>
</head>
<body>
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

    <section class="report-section">
        <h2> General Grade </h2>
        <%
            int grade = General.getGeneralGrade(session.getAttribute("username").toString());
            out.print("<h1 class=\"grade\">" + grade + "% </h1>");
        %>

        <table class="report-table">
            <thead>
            <tr>
                <th>Passed courses</th>
                <th>Failed courses</th>
                <th>Total taken</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <%
                    int passed = General.getPassed(session.getAttribute("username").toString());
                    out.print("<td>" + passed + "</td>");
                %>
                <%
                    int failed = General.getFailed(session.getAttribute("username").toString());
                    out.print("<td>" + failed + "</td>");
                %>
                <td><%= passed + failed %></td>
            </tr>
            </tbody>
        </table>
    </section>

    <section class="report-section">
        <h2>Grade Improvement Plan</h2>
        <p>Retake some passed courses in this order to boost your grade!</p>
        <table class="report-table">
            <thead>
            <tr>
                <th>Priority</th>
                <th>Course</th>
                <th>Year</th>
                <th>Grade</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<List<Object>> coursesPriority = General.getPriority(session.getAttribute("username").toString());
                if (coursesPriority != null) {
                    int i = 1;
                    for (List<Object> course : coursesPriority) {
                        out.print("<tr><td>" + i + "</td>");
                        out.print("<td>" + course.getFirst() + "</td>");
                        out.print("<td>" + course.get(1) + "</td>");
                        out.print("<td>" + course.getLast() + "</td></tr>");
                        i += 1;
                    }
                }
            %>
            </tbody>
        </table>
    </section>

    <section class="report-section">
        <h2>This Year's Courses: Insight </h2>
        <table class="report-table">
            <thead>
            <tr>
                <th>Course</th>
                <th>ECTS</th>
                <th>Median Grade</th>
                <th>Pass Rate</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<List<Object>> courses = General.getCourseInsights(session.getAttribute("username").toString());
                if (courses != null) {
                    for (List<Object> course : courses) {
                        out.print("<tr><td>" + course.get(0) + "</td>");
                        out.print("<td>" + course.get(1) + "</td>");
                        out.print("<td>" + course.get(2) + "</td>");
                        out.print("<td>" + course.get(3) + "% </td></tr>");
                    }
                }
            %>
            </tbody>
        </table>
    </section>
    
</div>
</body>
</html>

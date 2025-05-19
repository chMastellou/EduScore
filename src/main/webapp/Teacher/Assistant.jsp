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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Professor Assistant</title>
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
            <h2>Your Courses</h2>
            <p>Statistics for your courses.</p>
            <table class="report-table">
                <thead>
                    <tr>
                        <th>Course</th>
                        <th>Median Grade</th>
                        <th>Pass rate</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<List<Object>> statistics = General.getCourseStatistics(session.getAttribute("username").toString());
                    if (statistics != null) {
                        for (List<Object> course : statistics) {
                            out.print("<tr><td>" + course.get(0) + "</td>");
                            out.print("<td>" + course.get(1) + "</td>");
                            out.print("<td>" + course.get(2) + "% </td></tr>");
                        }
                    }
                %>

                </tbody>
            </table>
        </section>

        <section class="report-section">
            <h2>Grading</h2>
            <p>Best order to grade courses, based on participation.</p>
            <table class="report-table">
                <thead>
                    <tr>
                        <th>Priority</th>
                        <th>Course</th>
                        <th>Enrolled</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<List<Object>> priority = General.getGradingPriority(session.getAttribute("username").toString());
                    if (priority != null) {
                        for (List<Object> course : priority) {
                            out.print("<tr><td>" + course.get(0) + "</td>");
                            out.print("<td>" + course.get(1) + "</td>");
                            out.print("<td>" + course.get(2) + "</td></tr>");
                        }
                    }
                %>
                </tbody>
            </table>
        </section>

        <section class="report-section">
            <h2>Classrooms to Prepare</h2>
            <p>Estimated number of classrooms needed for examinations.</p>
            <table class="report-table">
                <thead>
                    <tr>
                        <th>Course</th>
                        <th>Enrolled Students</th>
                        <th>Required Classrooms</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<List<Object>> classroomList = General.getClassrooms(session.getAttribute("username").toString());
                    if (classroomList != null) {
                        for (List<Object> course : classroomList) {
                            out.print("<tr><td>" + course.get(0) + "</td>");
                            out.print("<td>" + course.get(1) + "</td>");
                            out.print("<td>" + course.get(2) + "</td></tr>");
                        }
                    }
                %>
                </tbody>
            </table>
        </section>
    </div>
</body>
</html>

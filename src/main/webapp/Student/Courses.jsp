<%@ page import="com.example.eduscore.General" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Course Application Form</title>
    <style> <%@ include file="../resources/css/courses.css"%> </style>
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

<div class="form-container">
    <form id="courseForm" onsubmit="return submitForm()">
        <table>
            <thead class="table-header">
                <tr>
                    <th>Course</th>
                    <th>ECTs</th>
                    <th>Select</th>
                </tr>
            </thead>
            <tbody>

            <%
                int student_year = General.getYear(session.getAttribute("username").toString());
                List<List<Object>> courses = General.getCourses(session.getAttribute("username").toString(),student_year);

                if (courses != null) {
                    int i=1;
                    for (List<Object> course : courses) {
                        out.print("<tr><td>" + course.getFirst() + "</td>");
                        out.print("<td>" + course.getLast() + "</td>");
                        out.print("<td> <input type=\"checkbox\" name=\"course"+i+"\" value=\""+course.getFirst()+"\"/> </td></tr>");
                    }
                }
            %>
                <tr>
                    <td>Mathematics</td>
                    <td>5</td>
                    <td><input type="checkbox" name="course" value="Mathematics" /></td>
                </tr>
                <tr>
                    <td>Physics</td>
                    <td>5</td>
                    <td><input type="checkbox" name="course" value="Physics" /></td>
                </tr>
                <tr>
                    <td>Chemistry</td>
                    <td>5</td>
                    <td><input type="checkbox" name="course" value="Chemistry" /></td>
                </tr>
                <tr>
                    <td>Biology</td>
                    <td>5</td>
                    <td><input type="checkbox" name="course" value="Biology" /></td>
                </tr>
                <tr>
                    <td>Computer Science</td>
                    <td>5</td>
                    <td><input type="checkbox" name="course" value="Computer Science" /></td>
                </tr>
            </tbody>
        </table>
        <button type="submit" class="submit-btn">Apply for Courses</button>
    </form>
</div>

<script>
    function submitForm() {
        const selectedCourses = Array.from(document.querySelectorAll('input[name="course"]:checked'))
            .map(checkbox => checkbox.value);

        alert("You have applied for: " + selectedCourses.join(", "));
        return false; // Prevent form submission for demo purposes
    }
</script>
</body>
</html>


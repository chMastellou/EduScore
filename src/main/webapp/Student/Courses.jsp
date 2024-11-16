<%--
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Course Application Form</title>
</head>
<body>
<div class="form-container">
    <form id="courseForm" onsubmit="return submitForm()">
        <table>
            <thead>
            <tr>
                <th>Course</th>
                <th>ECTs</th>
                <th>Select</th>
            </tr>
            </thead>
            <tbody>
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

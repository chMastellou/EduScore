<%--
  Created by IntelliJ IDEA.
  User: chara
  Date: 10/28/24
  Time: 8:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Grades</title>
    <style>
        <%@ include file="../resources/css/grades.css"%>
    </style>
</head>
<body class="body">
<div class="container">
    <h1>Student Grades</h1>
    <div class="table-container">
        <table class="grades-table">
            <thead>
            <tr>
                <th>Name</th>
                <th>Subject</th>
                <th>Grade</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>John Doe</td>
                <td>Math</td>
                <td class="grade">45</td>
            </tr>
            <tr>
                <td>Jane Smith</td>
                <td>Science</td>
                <td class="grade">88</td>
            </tr>
            <tr>
                <td>Sam Brown</td>
                <td>History</td>
                <td class="grade">55</td>
            </tr>
            <tr>
                <td>Lucy White</td>
                <td>English</td>
                <td class="grade">72</td>
            </tr>
            <tr>
                <td>Mike Green</td>
                <td>Biology</td>
                <td class="grade">30</td>
            </tr>
            <tr>
                <td>Sam Brown</td>
                <td>History</td>
                <td class="grade">55</td>
            </tr>
            <tr>
                <td>Lucy White</td>
                <td>English</td>
                <td class="grade">72</td>
            </tr>
            <tr>
                <td>Mike Green</td>
                <td>Biology</td>
                <td class="grade">30</td>
            </tr>
            <tr>
                <td>Sam Brown</td>
                <td>History</td>
                <td class="grade">55</td>
            </tr>
            <tr>
                <td>Lucy White</td>
                <td>English</td>
                <td class="grade">72</td>
            </tr>
            <tr>
                <td>Mike Green</td>
                <td>Biology</td>
                <td class="grade">30</td>
            </tr>
            <tr>
                <td>Sam Brown</td>
                <td>History</td>
                <td class="grade">55</td>
            </tr>
            <tr>
                <td>Lucy White</td>
                <td>English</td>
                <td class="grade">72</td>
            </tr>
            <tr>
                <td>Mike Green</td>
                <td>Biology</td>
                <td class="grade">30</td>
            </tr>
            <tr>
                <td>Sam Brown</td>
                <td>History</td>
                <td class="grade">55</td>
            </tr>
            <tr>
                <td>Lucy White</td>
                <td>English</td>
                <td class="grade">72</td>
            </tr>
            <tr>
                <td>Mike Green</td>
                <td>Biology</td>
                <td class="grade">30</td>
            </tr>
            <tr>
                <td>Sam Brown</td>
                <td>History</td>
                <td class="grade">55</td>
            </tr>
            <tr>
                <td>Lucy White</td>
                <td>English</td>
                <td class="grade">72</td>
            </tr>
            <tr>
                <td>Mike Green</td>
                <td>Biology</td>
                <td class="grade">30</td>
            </tr>
            <tr>
                <td>Sam Brown</td>
                <td>History</td>
                <td class="grade">55</td>
            </tr>
            <tr>
                <td>Lucy White</td>
                <td>English</td>
                <td class="grade">72</td>
            </tr>
            <tr>
                <td>Mike Green</td>
                <td>Biology</td>
                <td class="grade">30</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script>
    // Select all grade cells
    const gradeCells = document.querySelectorAll('.grade');

    // Loop through each cell to apply color based on grade value
    gradeCells.forEach(cell => {
        const grade = parseInt(cell.textContent);

        if (grade < 50) {
            cell.style.color = 'red'; // Red for grades 0-49
        } else {
            cell.style.color = 'green'; // Green for grades 50-100
        }
    });
</script>

</body>
</html>



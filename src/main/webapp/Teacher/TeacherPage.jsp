<%--
  Created by IntelliJ IDEA.
  User: chara
  Date: 10/25/24
  Time: 9:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Page</title>
    <link rel="icon" type="image/x-icon" href="../resources/Images/logo.ico">
    <script>
        window.history.pushState({}, '', '/Teacher');
    </script>
    <style>
        <%@ include file="../resources/css/menuStyle.css"%>
    </style>
</head>
<body onload="showContent('Teacher/Profile.jsp')">

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.

    if(session.getAttribute("username")==null)
    {
        response.sendRedirect("/");
    }

%>
<div class="grid-container">
    <!-- Left Menu -->

    <div class="left-menu">
        <img src="https://i.imgur.com/lDhdDkK.png" alt="Logo" width="100"/>
        <p><b class="left-menu"><%=session.getAttribute("username")%></b></p>
        <p class="role_tag">PROFESSOR</p>
        <br><br><br><br><br>
        <nav>
            <ul>
                <li><a href="#" onclick="showContent('Teacher/Profile.jsp')">Profile</a></li>
                <li><a href="#" onclick="showContent('Teacher/Grades.jsp')">Grades</a></li>
                <li><a href="#" onclick="showContent('Teacher/AddGrades.jsp')">Add Grades</a></li>
                <br><br><br><br>
            </ul>
        </nav>

        <a class="logout">Logout</a>
    </div>
    <!-- The div where the content will be loaded -->
    <div class="content">
        <div id="content-area"></div>
    </div>

</div>

<script>

    function showContent(page) {
        var xhr = new XMLHttpRequest();  // Create a new XMLHttpRequest object
        xhr.open('GET', page, true);     // Set up the request with the desired JSP page

        xhr.onload = function() {        // What to do when the request is done
            if (this.status === 200) {    // Check if the request was successful
                document.getElementById('content-area').innerHTML = this.responseText;  // Load the content
            } else {
                document.getElementById('content-area').innerHTML = 'Error loading page.';
            }
        };

        xhr.onerror = function() {       // What to do if the request fails
            document.getElementById('content-area').innerHTML = 'Request error.';
        };

        xhr.send();  // Send the request
    }

</script>
</body>
</html>

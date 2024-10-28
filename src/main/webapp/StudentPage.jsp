<%--
  Created by IntelliJ IDEA.
  User: chara
  Date: 10/24/24
  Time: 6:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Student Page</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/Images/logo.ico">

    <style>
        <%@ include file="resources/css/menuStyle.css"%>
    </style>

</head>
<body onload="showContent('Profile')">

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
        <p><b class="left-menu">Student: &nbsp; <%=session.getAttribute("username")%></b></p>
        <br><br><br><br><br><br>
        <nav>
            <ul>
                <li><a href="#Profile" onclick="showContent('Profile')">Profile</a></li>
                <li><a href="#Grades" onclick="showContent('Grades')">Grades</a></li>
                <li><a href="#Courses" onclick="showContent('Courses')">Choose Courses</a></li>
                <br><br><br><br>
                <li><a style="color: #4dc9b4" href="${pageContext.request.contextPath}/Logout">Logout</a></li>
            </ul>
        </nav>
    </div>

    <!-- Right Content Area -->
    <div class="content">
        <div id="Profile" class="content-section">
            <h2>Student Information</h2> <br>
            <p>Welcome <%=session.getAttribute("username")%>.</p>
            <%@ page import="java.util.*, java.text.SimpleDateFormat" %>
            <%
                // Get the session creation time in milliseconds
                long creationTime = session.getCreationTime();

                // Create a Date object from the milliseconds
                Date creationDate = new Date(creationTime);

                // Define the desired date format
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                // Format the date into a readable string
                String formattedDate = dateFormat.format(creationDate);
                String year = formattedDate.substring(0,4);
            %>
            <p>Session Creation Time: <%= formattedDate %></p>
        </div>
        <div id="Grades" class="content-section" style="display: none;">
            <h2>Grades</h2> <br>
            <p>Εδώ χρειάζεται επαφή με την βάση.</p>
        </div>
        <div id="Courses" class="content-section" style="display: none;">
            <h2>Courses for year: <%= year %> </h2> <br>
            <p>This is the content displayed when Option 3 is selected.</p>
        </div>
    </div>
</div>

    <script>
        function showContent(option) {
            // Hide all content sections
            var sections = document.getElementsByClassName('content-section');
            for (var i = 0; i < sections.length; i++) {
                sections[i].style.display = 'none';
            }
            // Show the selected content section
            document.getElementById(option).style.display = 'block';
        }
    </script>
</body>
</html>

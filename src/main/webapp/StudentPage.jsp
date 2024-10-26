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
        <%@ include file="resources/css/Menu.css"%>
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
    <!-- Left Menu -->
    <nav class="left-menu">
        <ul>
            <li><img src="https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png" alt="Italian Trulli" width="100" /></li>
            <li><h4>Μαθητής:</h4><%=session.getAttribute("username")%></li>
            <br>
            <br>
            <li><a href="#Profile" onclick="showContent('Profile')">Πληροφορίες Μαθητή</a></li>
            <li><a href="#Grades" onclick="showContent('Grades')">Βαθμολογίες</a></li>
            <li><a href="#Courses" onclick="showContent('Courses')">Δηλώσεις</a></li>
            <li><a href="${pageContext.request.contextPath}/Logout">Logout</a></li>
        </ul>
    </nav>

    <!-- Right Content Area -->
    <div class="content">
        <div id="Profile" class="content-section">
            <h2>Πληροφορίες Μαθητή</h2> <br>
            <p>Καλώς ήρθες <%=session.getAttribute("username")%>.</p>
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
            %>
            <p>Session Creation Time: <%= formattedDate %></p>
        </div>
        <div id="Grades" class="content-section" style="display: none;">
            <h2>Βαθμολογίες</h2> <br>
            <p>Εδώ χρειάζεται επαφή με την βάση.</p>
        </div>
        <div id="Courses" class="content-section" style="display: none;">
            <h2>Δηλώσεις</h2> <br>
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

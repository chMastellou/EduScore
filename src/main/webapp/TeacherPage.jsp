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
    <link rel="icon" type="image/x-icon" href="resources/Images/logo.ico">
    <script>
        window.history.pushState({}, '', '/Teacher');
    </script>
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
            <li><h4>Καθηγητή:</h4><%=session.getAttribute("username")%></li>
            <br>
            <br>
            <li><a href="#" onclick="showContent('option1')">Πληροφορίες Καθηγητή</a></li>
            <li><a href="#" onclick="showContent('option2')">Βαθμολογίες</a></li>
            <li><a href="#" onclick="showContent('option3')">Βαθμολόγησε</a></li>
            <li><a href="${pageContext.request.contextPath}/Logout">Login Page</a></li>
        </ul>
    </nav>

    <!-- Right Content Area -->
    <div class="content">
        <div id="option1" class="content-section">
            <h2>Πληροφορίες Καθηγητή</h2> <br>
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
                String year = formattedDate.substring(0,4);
            %>
            <p>Session Creation Time: <%= formattedDate %></p>
        </div>
        <div id="option2" class="content-section" style="display: none;">
            <h2>Βαθμολογίες</h2> <br>
            <p>Εδώ χρειάζεται επαφή με την βάση.</p>
        </div>
        <div id="option3" class="content-section" style="display: none;">
            <h2>Βαθμολογήστε για την εξεταστική περίοδο <%=year%>.</h2><br>
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
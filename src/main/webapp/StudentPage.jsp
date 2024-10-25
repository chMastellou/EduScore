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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Page</title>
    <link rel="icon" type="image/x-icon" href="resources/Images/logo.ico">
</head>
<body>
<h1>Student Page</h1>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.

    if(session.getAttribute("username")==null)
    {
        response.sendRedirect("index.jsp");
    }

%>

Welcome <%=session.getAttribute("username") %> <br>
Your role is <%=session.getAttribute("role")%>  <br>
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
<br/>
<a href="index.jsp">Login Screen</a>
</body>
</html>

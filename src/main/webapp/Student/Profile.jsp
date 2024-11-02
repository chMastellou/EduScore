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
    <title>User Profile</title>
    <style>
        <%@ include file="../resources/css/Profile_Page.css"%>
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
<div class="profile-container">
    <div class="profile-header">
        <br><br><br><br>
        <img src="https://i.imgur.com/45BIKmP.png" alt="User Profile Picture" class="profile-picture" />
        <h1 class="user-name">John Doe</h1> <!--Θέλει επαφή με βάση για students.full_name-->
        <p class="user-title"><%=session.getAttribute("role")%></p>
    </div>
    <div class="profile-info">
        <h2>About</h2>
        <br>
        <li>University ID: <b><%=session.getAttribute("username")%></b></li>
        <li>Field: <b>Computer Science</b></li> <!--Θέλει επαφή με βάση για students.field-->
        <li>Entrance Year: <b>2021</b></li> <!--Θέλει επαφή με βάση για students.entrance_year-->

        <h2>Contact Information</h2>
        <ul>
            <li>Email: johndoe@example.com</li> <!--Θέλει επαφή με βάση για students.email-->
            <li>Phone: +123-456-7890</li> <!--Θέλει επαφή με βάση για professors.phone.-->
            <li>Location: New York, USA</li> <!--Υποθετική διεύθυνση, είναι όλοι στο ίδιο πανεπιστήμιο-->
        </ul>
    </div>
</div>
</body>
</html>

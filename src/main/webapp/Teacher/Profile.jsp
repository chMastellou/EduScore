<%--
  Created by IntelliJ IDEA.
  User: chara
  Date: 10/28/24
  Time: 8:10 PM
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
        <h1 class="user-name"><%=session.getAttribute("fullName")%></h1> <!--Θέλει επαφή με βάση για students.full_name-->
        <p class="user-title"><%=session.getAttribute("role")%></p>
    </div>
    <div class="profile-info">
        <h2>About</h2>
        <br>
        <li>University ID: <b><%=session.getAttribute("username")%></b></li>
        <li>Rank: <b><%=session.getAttribute("rank")%></b></li>
        <br>
        <h2>Contact Information</h2><br>
        <li>Email: <%=session.getAttribute("email")%></li>
        <li>Phone: <%=session.getAttribute("phoneNumber")%></li>
        <li>Office Address: <%=session.getAttribute("officeAddress")%></li>
    </div>
</div>
</body>
</html>

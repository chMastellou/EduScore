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
<div class="profile-container">
    <div class="profile-header">
        <br><br><br><br>
        <img src="https://i.imgur.com/45BIKmP.png" alt="User Profile Picture" class="profile-picture" />
        <h1 class="user-name">John Doe</h1>
        <p class="user-title">Student</p>
    </div>
    <div class="profile-info">
        <h2>About</h2>
        <br>
        <li>University ID: <b>p20121</b></li>
        <li>Field: <b>Computer Science</b></li>
        <li>Entrance Year: <b>2021</b></li>

        <h2>Contact Information</h2>
        <ul>
            <li>Email: johndoe@example.com</li>
            <li>Phone: +123-456-7890</li>
            <li>Location: New York, USA</li>
        </ul>
    </div>
</div>
</body>
</html>

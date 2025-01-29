<%--
  Created by IntelliJ IDEA.
  User: marouli
  Date: 28/10/2024
  Time: 20:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduScore</title>
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}resources/Images/logo.ico">
    <style>
        <%@ include file="resources/css/loginStyle.css"%>
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-box">
        <img src="https://i.imgur.com/kDAooXp.png" alt="Logo" width="100" class="center"/>
        <h2>New User</h2>
        <form action="${pageContext.request.contextPath}/register_new" method="post">
<%--            <div class="input-group">--%>
<%--                <label for="username">Username</label>--%>
<%--                <input type="text" id="username" name="username" required>--%>
<%--            </div>--%>
            <div class="input-group">
                <label for="email">Email</label>
                <input type="text" id="email" name="email" minlength="13" maxlength="64" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" minlength="12" maxlength="128"  required>
            </div>
            <div class="input-group">
                <label for="dropdown">I am a:</label>
                <select id="dropdown" name="dropdown" required>
                    <option value="Student">Student</option>
                    <option value="Professor">Professor</option>
                </select>
            </div>
            <button type="submit">Register</button>
        </form>
    </div>
</div>
</body>
</html>
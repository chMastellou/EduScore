<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <h2>Login</h2>
    <form action="${pageContext.request.contextPath}/login" method="post">
      <div class="input-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" minlength="4" maxlength="4" required>
      </div>
      <div class="input-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" minlength="12" maxlength="30" required>
      </div>
      <button type="submit">Login</button>
    </form>
    <br>
    <button class="registerBtn" onclick="window.location='/Register.jsp';"> Register </button>
  </div>
</div>
</body>
</html>
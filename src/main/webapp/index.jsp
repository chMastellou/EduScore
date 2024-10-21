<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>EduScore Login</title>
  <style>
    <%@ include file="resources/css/style.css"%>
  </style>
</head>
<body>
<div class="login-container">
  <div class="login-box">
    <h2>Login</h2>
    <form action="${pageContext.request.contextPath}/login" method="post">
      <div class="input-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" required>
      </div>
      <div class="input-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
      </div>
      <button type="submit">Login</button>
    </form>
  </div>
</div>
</body>
</html>
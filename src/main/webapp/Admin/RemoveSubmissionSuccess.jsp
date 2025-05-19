<%@ page import="java.util.concurrent.TimeUnit" %><%--
  Created by IntelliJ IDEA.
  User: marouli
  Date: 20/11/2024
  Time: 14:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/Images/logo.ico">
    <title>Submission Removal Success</title>
</head>
<body style="background-color: #cbcbd0; height: 100vh;">
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.

    if(session.getAttribute("username")==null)
    {
        response.sendRedirect("/");
    }
%>
<br><br><br><br><br>
<h3 style="text-align: center; font-family:Ubuntu,sans-serif; color: #2c3e50;"><b>Submission removed successfully!</b></h3><br>
<h3 style="text-align: center; font-family:Ubuntu,sans-serif; color: #2c3e50;">You will be redirected back to the dashboard shortly...
    <br>Click <a href="${pageContext.request.contextPath}/Admin">here</a> to go back.
</h3>

<script>
    setTimeout(function(){ window.location.href = "/Admin"; }, 5000);
</script>
</body>
</html>


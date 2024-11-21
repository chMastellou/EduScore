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
    <title>Courses Submitted</title>
</head>
<body style="background-color: #cbcbd0;">
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
<h3 style="text-align: center; font-family:Ubuntu,sans-serif; color: #2c3e50; "><b>Courses selected successfully!</b><br>
    You will be redirected back to your home page shortly...
    <br>Click <a href="${pageContext.request.contextPath}/Student">here</a> to go back.
</h3>
<%--<%--%>
<%--    try {--%>
<%--        TimeUnit.SECONDS.sleep(5);--%>
<%--        response.sendRedirect("/Student",false);--%>
<%--    } catch (InterruptedException e) {--%>
<%--        throw new RuntimeException(e);--%>
<%--    }--%>
<%--%>--%>
<script>
    setTimeout(function(){ window.location.href = "/Student"; }, 5000);
</script>
</body>
</html>


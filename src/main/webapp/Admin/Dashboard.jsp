<%@ page import="java.util.List" %>
<%@ page import="com.example.eduscore.General" %><%--
  Created by IntelliJ IDEA.
  User: chara
  Date: 10/28/24
  Time: 7:35 PM
  To change this template use File | Settings | File Templates.
--%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Grades</title>
    <style>
        <%@ include file="../resources/css/grades.css"%>
    </style>
</head>
<body class="body">
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.

    if(session.getAttribute("username")==null)
    {
        response.sendRedirect("/");
    }

%>
<br><br>
<section class="dashboard-wrapper">
    <div class="container">
        <h1>Create Account</h1>
        <p>Create a new user account by entering an academic email below.</p>
        <form id="createAccountForm" method="post" action="${pageContext.request.contextPath}/create-account">
            <input type="email" placeholder="Email" name="email" class="input-box" minlength="13" maxlength="64" required>
            <div class="input-group">
                <label for="dropdown">Type:</label>
                <select id="dropdown" name="dropdown" required>
                    <option value="Student">Student</option>
                    <option value="Professor">Professor</option>
                </select>
            </div>
            <button class="submit-btn">Create Account</button>
        </form>
    </div>
    <br><br><br><br><br><br><br><br><br><br><br><br>
    <div class="container">
        <h1>Delete Account</h1>
        <p>Delete an account by entering the username below.</p>
        <form id="deleteAccountForm" method="post" action="${pageContext.request.contextPath}/delete-account">
            <input type="text" placeholder="Username" name="username" class="input-box" minlength="4" maxlength="4" required>
            <button class="submit-btn">Delete Account</button>
        </form>
    </div>
    <br><br><br><br><br><br><br><br><br><br><br><br>
    <div class="container">
        <h1>Remove Submission</h1>
        <p>Enter the student's username to remove this year's submission.</p>
        <form id="removeSubmissionForm" method="post" action="${pageContext.request.contextPath}/remove-submission">
            <input type="text" placeholder="Username" name="username" class="input-box" minlength="4" maxlength="4" required>
            <button class="submit-btn">Remove Submission</button>
        </form>
    </div>

</section>

</body>
</html>


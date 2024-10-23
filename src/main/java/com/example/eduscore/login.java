package com.example.eduscore;

import java.io.*;
import java.sql.DriverManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "login", value = "/login")
public class login extends HttpServlet {

    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        if (username.equals("student") && pass.equals("s123")) {
            HttpSession session = request.getSession(true);

            out.println("<html><body>");
            out.println("<h1>" + message + "</h1>");
            out.println("<h3> Your session ID: " + session.getId() + "</h3>");
            out.println("<h3> Creation time: " + session.getCreationTime() + "</h3>");
            out.println("</body></html>");

            try {
                var connection = PostgresqlTest.DBconnect();
                var statement = connection.prepareStatement("select title from subjects where field='Science';");
                var resultSet = statement.executeQuery();
                while(resultSet.next()) {
                    String subject = resultSet.getString("title");
                    out.println("<h3>" + subject + "</h3>");
                }
            } catch(Exception e) {
                out.println("problem");
            }
            session.invalidate();
        }

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
    }

    public void destroy() {
    }
}
package com.example.eduscore;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "login", urlPatterns={"/login", "/"})
public class loginServlet extends HttpServlet {

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

        if (username.equals("chara") && pass.equals("c123")) {

            HttpSession session = request.getSession();         // create new session and pass parameters
            session.setAttribute("username", username);
            session.setAttribute("role", "student");

            out.println("<html><body>");
            out.println("<h1>" + message + "</h1>");
            out.println("<h3> Your session ID: " + session.getId() + "</h3>");
            out.println("<h3> Creation time: " + session.getCreationTime() + "</h3>");
            out.println("<h3>Welcome: " + username + "</h3>");
            out.println("<h3>Your pass is: " + pass + "</h3>");
            out.println("</body></html>");


            request.getRequestDispatcher("StudentPage.jsp").forward(request, response);

 /*
            try {
                java.sql.PreparedStatement statement;
                try (var connection = PostgresqlTest.DBconnect()) {
                    statement = connection.prepareStatement("select title from subjects where field='Science';");
                }
                var resultSet = statement.executeQuery();
                while(resultSet.next()) {
                    String subject = resultSet.getString("title");
                    out.println("<h3>" + subject + "</h3>");
                }
            } catch(Exception e) {
                out.println("problem");
            }

 */
            session.invalidate(); // γιατί invalidate? θες να κρατήσεις το session εκτός και αν ο χρήστης κάνει logout
        }else if(username.equals("kyrios") && pass.equals("k123")){
            HttpSession session = request.getSession();         // create new session and pass parameters
            session.setAttribute("username", username);
            session.setAttribute("role", "teacher");

            request.getRequestDispatcher("TeacherPage.jsp").forward(request, response);
        }else{
            response.sendRedirect("/");
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
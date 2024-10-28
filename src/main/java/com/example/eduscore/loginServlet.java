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


            //request.getRequestDispatcher("StudentPage.jsp").forward(request, response);
            response.sendRedirect("/Student");

           // session.invalidate(); // γιατί invalidate? θες να κρατήσεις το session εκτός και αν ο χρήστης κάνει logout
        }else if(username.equals("kyrios") && pass.equals("k123")){
            HttpSession session = request.getSession();         // create new session and pass parameters
            session.setAttribute("username", username);
            session.setAttribute("role", "teacher");

            response.sendRedirect("/Teacher");
        }else{
            response.sendRedirect("/");
        }

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}
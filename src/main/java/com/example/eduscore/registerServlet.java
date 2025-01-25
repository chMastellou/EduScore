package com.example.eduscore;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "register", urlPatterns={"/register"})
public class registerServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        String userTypeChoice = request.getParameter("dropdown");
        int userType = 1;

        if (userTypeChoice.equals("Professor")) {
            userType = 2;
        }

        if (General.registerUserOLD(username, pass, userType)){
            response.sendRedirect("/");
        } else {
            response.sendRedirect("/Register.jsp");
        }

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}

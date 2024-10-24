package com.example.eduscore;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "studentPage", value = "/Student")
public class studentPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doGet request on StudentPage");
        // Hello
        PrintWriter out = response.getWriter();
        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        out.println("<!DOCTYPE html><html><body>");
        out.println("<h3>Welcome: " + username + "</h3>");
        out.println("<h3>Your pass is: " + pass + "</h3>");
        out.println("</body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
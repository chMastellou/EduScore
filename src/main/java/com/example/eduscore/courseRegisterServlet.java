package com.example.eduscore;

import java.io.*;
import java.util.Arrays;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.jsp.JspWriter;

@WebServlet(name = "course_register", urlPatterns={"/course_register"})
public class courseRegisterServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String[] selectedCourses = request.getParameterValues("course");
        response.sendRedirect(request.getContextPath() + "/Student");
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}

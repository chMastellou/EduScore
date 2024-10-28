package com.example.eduscore;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "teacherPageServlet", urlPatterns = {"/Teacher", "/Teacher*"})
public class teacherPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doGet request on teacherPageServlet");
        HttpSession session = request.getSession(false);
        request.getRequestDispatcher("Teacher/TeacherPage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
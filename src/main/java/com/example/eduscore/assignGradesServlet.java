package com.example.eduscore;

import java.io.*;
import java.util.stream.Stream;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "assign_grades", urlPatterns={"/assign_grades"})
public class assignGradesServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String[] assignedGradesStrings = request.getParameterValues("grade");
        int[] assignedGrades = Stream.of(assignedGradesStrings).mapToInt(Integer::parseInt).toArray();

        HttpSession session = request.getSession();
        if (General.assignGrades(assignedGrades, session.getAttribute("username").toString())) {
            response.sendRedirect(request.getContextPath() + "/Teacher/AssignGradesSuccess.jsp", false);
        } else {
            response.sendRedirect(request.getContextPath() + "/Teacher/AssignGradesError.jsp",false);
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}

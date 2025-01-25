package com.example.eduscore;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "course_submit", urlPatterns={"/course_submit"})
public class courseSubmitServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String[] selectedCourses = request.getParameterValues("course");
        List<String> courses = new ArrayList<>();
        //Discard unchecked courses
        for (String string : selectedCourses) {
            if (string != null) {
                courses.add(string);
            }
        }
        HttpSession session = request.getSession();
        if (General.submitCourses(courses, session.getAttribute("username").toString())) {
            response.sendRedirect(request.getContextPath() + "/Student/CourseSubmissionSuccess.jsp", false);
        } else {
            response.sendRedirect(request.getContextPath() + "/Student/CourseSubmissionError.jsp",false);
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}

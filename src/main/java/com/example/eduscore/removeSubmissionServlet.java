package com.example.eduscore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "removeSubmission", urlPatterns={"/remove-submission"})
public class removeSubmissionServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String username = request.getParameter("username");

        if (General.inputFilter("username", username)) {
            if (General.removeSubmission(username)) {
                response.sendRedirect("/Admin/RemoveSubmissionSuccess.jsp",false);
            } else {
                response.sendRedirect("/Admin/RemoveSubmissionError.jsp", false);
            }
        } else {
            response.sendRedirect("/Admin/RemoveSubmissionError.jsp", false);
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}

package com.example.eduscore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "register_new", urlPatterns={"/register_new"})
public class registerServletNew extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String userTypeChoice = request.getParameter("dropdown");

        String page = "/Register.jsp";
        int userType = 0;
        boolean emailFiltered = true;

        if (userTypeChoice.equals("Student")) {
            userType = 1;
            emailFiltered = General.inputFilter("emailStudent", email);
        } else if (userTypeChoice.equals("Professor")) {
            userType = 2;
            emailFiltered = General.inputFilter("emailProfessor", email);
        }

        if (emailFiltered) {
            if (General.inputFilter("password", pass)) {
                if (General.registerUserNew(email, pass, userType)) {
                    page = "/";
                }
            }
        }

        response.sendRedirect(page);

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}

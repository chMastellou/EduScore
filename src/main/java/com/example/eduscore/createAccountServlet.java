package com.example.eduscore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "createAccount", urlPatterns={"/create-account"})
public class createAccountServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String email = request.getParameter("email");
        String userTypeChoice = request.getParameter("dropdown");

        String page = "/Admin/CreateAccountSuccess.jsp";
        int userType = 0;
        boolean emailFiltered = false;

        if (userTypeChoice.equals("Student")) {
            userType = 1;
            emailFiltered = General.inputFilter("emailStudent", email);
            System.out.println("servlet: student email filtered");
        } else if (userTypeChoice.equals("Professor")) {
            userType = 2;
            emailFiltered = General.inputFilter("emailProfessor", email);
        }

        if (emailFiltered) {
            if (General.inputFilter("password", "chANGE1t!!??")) {
                System.out.println("servlet: pw filtered");
                if (General.registerUserNew(email, "chANGE1t!!??", userType)) {
                    System.out.println("servlet: user created");
                    response.sendRedirect(page, false);
                } else {
                    response.sendRedirect("/Admin/CreateAccountError.jsp", false);
                }
            } else {
                response.sendRedirect("/Admin/CreateAccountError.jsp", false);
            }
        } else {
            response.sendRedirect("/Admin/CreateAccountError.jsp", false);
        }

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}

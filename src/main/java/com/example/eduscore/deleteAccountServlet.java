package com.example.eduscore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "deleteAccount", urlPatterns={"/delete-account"})
public class deleteAccountServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String username = request.getParameter("username");

        if (General.inputFilter("username", username)) {
            if (General.deleteAccount(username)) {
                response.sendRedirect("/Admin/DeleteAccountSuccess.jsp",false);
            } else {
                response.sendRedirect("/Admin/DeleteAccountError.jsp", false);
            }
        } else {
            response.sendRedirect("/Admin/DeleteAccountError.jsp", false);
        }


    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}

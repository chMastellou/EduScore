package com.example.eduscore;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "login", urlPatterns={"/login", "/"})
public class loginServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        if (General.validateUser(username, pass) == 1) {

            HttpSession session = request.getSession();         // create new session and pass parameters
            session.setAttribute("username", username);
            session.setAttribute("role", "student");

            // get session creation time and update last_login-----------
            long last_login = session.getCreationTime();

            response.sendRedirect("/Student");

        } else if (General.validateUser(username, pass) == 2){

            HttpSession session = request.getSession();         // create new session and pass parameters
            session.setAttribute("username", username);
            session.setAttribute("role", "teacher");
            // get session creation time and update last_login-----------
            long last_login = session.getCreationTime();
            if(General.updateLastLogin(username, last_login)){
               response.sendRedirect("/Teacher");
            }else{ // δεν δούλεψε
                System.out.println("last login is : " + last_login);
                System.out.println("Couldn't update last login");
                session.invalidate();
                response.sendRedirect("/");
            }

        } else if (General.validateUser(username, pass) == -1){
            response.sendRedirect("/");
        }

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}
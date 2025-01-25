package com.example.eduscore;

import java.io.*;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "login", urlPatterns={"/login", "/"})
public class loginServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        response.setContentType("text/html");

        String username = request.getParameter("username");
        String pass = request.getParameter("password");

        if (General.inputFilter("username",username)) {
            if (General.inputFilter("password",pass)) {

                if (General.validateUser(username, pass) == 1) {

                    HttpSession session = request.getSession();         // create new session and pass parameters
                    session.setAttribute("username", username);
                    session.setAttribute("role", "student");

                    // get session creation time and update last_login-----------
                    long last_login = session.getCreationTime();

                    if (General.updateLastLogin(username, last_login)) {
                        List<Object> studentInfo = General.getStudentInfo(username);
                        if (studentInfo != null) {
                            session.setAttribute("fullName", studentInfo.get(0));
                            session.setAttribute("entranceYear", studentInfo.get(1));
                            session.setAttribute("email", studentInfo.get(2));
                            session.setAttribute("phoneNumber", studentInfo.get(3) );
                            response.sendRedirect("/Student",false);
                        } else {
                            session.invalidate();
                            response.sendRedirect("/");
                        }
                    } else {
                        session.invalidate();
                        response.sendRedirect("/");
                    }

                } else if (General.validateUser(username, pass) == 2){

                    HttpSession session = request.getSession();         // create new session and pass parameters
                    session.setAttribute("username", username);
                    session.setAttribute("role", "teacher");
                    // get session creation time and update last_login-----------
                    long last_login = session.getCreationTime();

                    if (General.updateLastLogin(username, last_login)) {
                        List<Object> professorInfo = General.getProfessorInfo(username);
                        if (professorInfo != null) {
                            session.setAttribute("fullName", professorInfo.get(0));
                            session.setAttribute("email", professorInfo.get(1));
                            session.setAttribute("phoneNumber", professorInfo.get(2) );
                            session.setAttribute("officeAddress", professorInfo.get(3));
                            session.setAttribute("rank", professorInfo.get(4));
                            response.sendRedirect("/Teacher",false);
                        } else {
                            session.invalidate();
                            response.sendRedirect("/");
                        }
                    } else { // δε δούλεψε
                        session.invalidate();
                        response.sendRedirect("/");
                    }

                } else if (General.validateUser(username, pass) == -1){
                    response.sendRedirect("/");
                } else {
                    response.sendRedirect("/");
                }
            } else {
                response.sendRedirect("/");
            }
        } else {
            response.sendRedirect("/");
        }

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    public void destroy() {
    }
}
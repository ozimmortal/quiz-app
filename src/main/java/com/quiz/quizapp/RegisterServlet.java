package com.quiz.quizapp;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;
import  jakarta.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    UserDao userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try{
            HttpSession session = req.getSession();
            if(userDao.registerUser(name, email, password)){
                resp.sendRedirect("login.jsp");
            }
            else{
                resp.sendRedirect("register.jsp?error=true");
            }

        } catch (Exception e) {
            resp.sendRedirect("register.jsp?error=true");
        }

        System.out.println(email + " " + password);
    }
}

package com.quiz.quizapp;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;
import  jakarta.servlet.http.HttpSession;

@WebServlet("/login")

public class LoginServlet extends HttpServlet {
    UserDao userDao;
    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String id = userDao.validateUser(email, password);
        if (!id.isEmpty()) {
            HttpSession session = req.getSession();
            session.setAttribute("id", id);
            resp.sendRedirect("dashboard.jsp");
        } else {
            resp.sendRedirect("login.jsp?error=true");
        }
    }
}

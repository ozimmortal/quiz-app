package com.quiz.quizapp;

import com.google.gson.JsonObject;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

import java.io.IOException;

@WebServlet("/get-answer")
public class GetAnswers extends HttpServlet {
    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String id = req.getParameter("id");
        String qid = req.getParameter("qid");

        try {
            JsonObject data = userDao.getAnswer(id, qid);
            System.out.println(data);
            resp.getWriter().write(data.toString());
            System.out.println("s");
        } catch (Exception e) {
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("error", "Failed to fetch quiz data: " + e.getMessage());
            System.out.println(errorResponse);
            resp.getWriter().write(errorResponse.toString());
        }
    }
}

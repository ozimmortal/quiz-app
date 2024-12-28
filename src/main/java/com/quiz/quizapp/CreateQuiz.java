package com.quiz.quizapp;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

import java.io.BufferedReader;
import java.io.IOException;
import  jakarta.servlet.http.HttpSession;

@WebServlet("/create-quiz")
public class CreateQuiz extends HttpServlet{
    UserDao userDao;
    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDao();
    }
    protected void doPost(HttpServletRequest req,HttpServletResponse resp)throws IOException,ServletException{

        StringBuilder requestBody = new StringBuilder();
        String line;
        HttpSession session = req.getSession();
        String userid = session.getAttribute("id").toString();

        try (BufferedReader reader = req.getReader()) {
            while ((line = reader.readLine()) != null) {
                requestBody.append(line);
            }
        }

        // Convert to string and process as needed
        String body = requestBody.toString();
        System.out.println("Request Body: " + body);

        try {
            JsonObject jsonObject = JsonParser.parseString(body).getAsJsonObject();
            // Extract 'data' field
            JsonObject data = jsonObject.getAsJsonObject("data");

            // Step 3: Process the 'data' object as needed
            String title = data.get("title").getAsString();
            String description = data.get("description").getAsString();
            JsonObject content = data.getAsJsonObject("content");
            System.out.println(content.toString());
            System.out.println(title);
            System.out.println(description);
            System.out.println("Data: " + data.toString());

            if(userDao.CreateQuiz(title, description, content.toString(), userid)){
                resp.sendRedirect("dashboard.jsp");
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}

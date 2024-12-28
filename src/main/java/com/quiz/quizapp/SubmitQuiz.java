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

@WebServlet("/submit-answer")
public class SubmitQuiz extends HttpServlet{
    UserDao userDao;
    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDao();
    }
    protected void doPost(HttpServletRequest req,HttpServletResponse resp)throws IOException,ServletException{

        StringBuilder requestBody = new StringBuilder();
        String line;


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
            JsonObject data = jsonObject.getAsJsonObject("answerData");

            // Step 3: Process the 'data' object as needed
            String title = data.get("title").getAsString();
            String s_id = data.get("id").getAsString();
            String userid = data.get("userid").getAsString();
            String quizid = data.get("quizid").getAsString();
            JsonObject answers = data.getAsJsonObject("answers");
            System.out.println(answers.toString());
            System.out.println(title);
            System.out.println(s_id);
            System.out.println("Data: " + data.toString());

            if(userDao.AnswerQuiz(title, s_id, answers.toString(), userid,quizid)){
                JsonObject succesResponse = new JsonObject();
                succesResponse.addProperty("success", true);
                resp.getWriter().write(succesResponse.toString());
            }

        } catch (Exception e) {
            System.out.println("error");
            throw new RuntimeException(e);
        }

    }
}

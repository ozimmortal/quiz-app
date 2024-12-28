package com.quiz.quizapp;

import java.sql.*;
import java.util.ArrayList;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.mysql.cj.xdevapi.JsonString;

public class UserDao {

    private  String url = "jdbc:mysql://localhost:3306/quiz";
    private  String username = "root";
    private  String password = "oliy2627";
    public String validateUser(String email, String pwd) {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection c = DriverManager.getConnection(url,username,password);
            PreparedStatement st = c.prepareStatement("select * from users where email=? and password_hash=?");
            st.setString(1,email);
            st.setString(2,pwd);
            ResultSet rs = st.executeQuery();
            String userid = "";
            if(rs.next())
               userid = rs.getString("id");

            c.close();
            return userid;
        } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
        }



    }
    public Boolean registerUser(String name, String email, String pwd) {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection c = DriverManager.getConnection(url,username,password);
            PreparedStatement st = c.prepareStatement("insert into users(name,email,password_hash) values(?,?,?)");
            st.setString(1,name);
            st.setString(2,email);
            st.setString(3,pwd);
            st.executeUpdate();
            c.close();
            return true;
        }catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);

        }

    }
    public boolean CreateQuiz(String title, String description, String content, String author) throws SQLException,ClassNotFoundException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection c = DriverManager.getConnection(url,username,password);
            PreparedStatement st = c.prepareStatement("insert into quizzes(title,description,content,userid) values(?,?,?,?)");
            st.setString(1,title);
            st.setString(2,description);
            st.setString(3,content);
            st.setString(4,author);
            st.executeUpdate();
            c.close();
            return true;
        } catch (Exception e) {
            return  false;
        }
    }
    public boolean AnswerQuiz(String title, String s_id, String answers, String userid,String quizid) throws SQLException,ClassNotFoundException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection c = DriverManager.getConnection(url,username,password);
            PreparedStatement st = c.prepareStatement("insert into analytics(title,s_id,answer,userid,quizid) values(?,?,?,?,?)");
            st.setString(1,title);
            st.setString(2,s_id);
            st.setString(3,answers);
            st.setString(4,userid);
            st.setString(5,quizid);
            st.executeUpdate();
            c.close();

            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return  false;
        }
    }

    public JsonObject getQuiz(String userId, String quizId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection c = DriverManager.getConnection(url, username, password);

            // Correcting the SQL query to match likely column names
            PreparedStatement st = c.prepareStatement("SELECT * FROM quizzes WHERE userid = ? AND qid = ?");
            System.out.println("userId: " + userId + " quizId: " + quizId + ".");
            st.setString(1, userId);
            st.setString(2, quizId);

            ResultSet resultSet = st.executeQuery();
            JsonObject quiz = new JsonObject();

            if (resultSet.next()) {
                quiz.addProperty("title", resultSet.getString("title"));
                quiz.addProperty("description", resultSet.getString("description"));
                String content = resultSet.getString("content");
                quiz.add("content", JsonParser.parseString(content).getAsJsonObject());
            }

            c.close();
            return quiz;

        } catch (Exception e) {
            throw new RuntimeException("Error fetching quiz: " + e.getMessage(), e);
        }
    }
    public JsonObject getAnswer(String userId, String quizId) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection c = DriverManager.getConnection(url, username, password);

            // Correcting the SQL query to match likely column names
            PreparedStatement st = c.prepareStatement("SELECT * FROM analytics WHERE userid = ? AND quizid = ?");

            st.setString(1, userId);
            st.setString(2, quizId);

            ResultSet resultSet = st.executeQuery();
            ArrayList<JsonObject> answers = new ArrayList<>();

            while (resultSet.next()) {
                JsonObject quiz = new JsonObject();
                quiz.addProperty("title", resultSet.getString("title"));
                quiz.addProperty("s_id", resultSet.getString("s_id"));
                String answer = resultSet.getString("answer");
                quiz.add("content", JsonParser.parseString(answer).getAsJsonObject());
                answers.add(quiz); // Add each quiz object to the answers list
            }

            JsonObject answerObj = new JsonObject();
            answerObj.add("answers", JsonParser.parseString(answers.toString()).getAsJsonArray());
            c.close();
            System.out.println(answerObj);
            return answerObj;

        } catch (Exception e) {
            throw new RuntimeException("Error fetching quiz: " + e.getMessage(), e);
        }
    }


}

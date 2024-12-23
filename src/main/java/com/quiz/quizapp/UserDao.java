package com.quiz.quizapp;

import java.sql.*;

public class UserDao {

    private  String url = "jdbc:mysql://localhost:3306/quiz";
    private  String username = "root";
    private  String password = "oliy2627";
    public boolean validateUser(String email, String pwd) {
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection c = DriverManager.getConnection(url,username,password);
            PreparedStatement st = c.prepareStatement("select * from user where email=? and password=?");
            st.setString(1,email);
            st.setString(2,pwd);
            ResultSet rs = st.executeQuery();
            if(rs.next())
                return true;
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);
            }

        return false;
    }
    public Boolean registerUser(String name, String email, String pwd) {
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection c = DriverManager.getConnection(url,username,password);
            PreparedStatement st = c.prepareStatement("insert into user values(?,?,?)");
            st.setString(1,name);
            st.setString(2,email);
            st.setString(3,pwd);
            st.executeUpdate();
            return true;
            } catch (SQLException | ClassNotFoundException e) {
                throw new RuntimeException(e);

            }

    }
}

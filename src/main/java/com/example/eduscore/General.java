package com.example.eduscore;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Handles User Authentication and password hashing
public class General {

    public static String getHash(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    public static int validateUser(String username, String password) {
        //  2 for successfully validated teacher
        //  1 for successfully validated student
        //  0 reserved for future use
        //  -1 no validation
        try (Connection connection = Database.getConnection()) {
            String query = "SELECT pass,user_type FROM users WHERE id = ?;";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            ResultSet result = preparedStatement.executeQuery();
            if (result.next()) {
                String storedHash = result.getString("pass");
                if (BCrypt.checkpw(password, storedHash)) {
                    result.next();
                    int userType = result.getInt("user_type");
                    if (userType == 1) {
                        return 1;
                    } else if (userType == 2) {
                        return 2;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }
}

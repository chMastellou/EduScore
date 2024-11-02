package com.example.eduscore;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Handles User Authentication and password hashing
public class General {

    public static int validateUser(String username, String password) {
        //  2 for successfully validated teacher
        //  1 for successfully validated student
        //  0 reserved for future use
        //  -1 no validation
        try (Connection connection = Database.getConnection()) {
            String query = "SELECT pass,user_type FROM users WHERE id = ?;";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            try (ResultSet result = preparedStatement.executeQuery();) {
                if (result.next()) {
                    String storedHash = result.getString("pass");
                    if (BCrypt.checkpw(password, storedHash)) {
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

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }
    public static boolean update_last_login(String username , long unixTime) {
        try (Connection connection = Database.getConnection()){
            // Add login timestamp
            String query = "UPDATE users SET last_login = to_timestamp(? / 1000.0) WHERE id = ?;";
            if (connection == null) {
                throw new SQLException("Failed to establish a database connection.");
            }
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            System.out.println("PreparedStatement: " + preparedStatement);
            preparedStatement.setLong(1, unixTime);
            preparedStatement.setString(2, username);
            System.out.println("PreparedStatement2: " + preparedStatement);
            if (preparedStatement.executeUpdate() == 1) {
                System.out.println("Successfully updated the last login.");
                return true;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }

    public static boolean registerUser(String username, String password, int userType) {

        try (Connection connection = Database.getConnection()) {
            String query = "INSERT INTO users VALUES (?,?,?,null);";
            assert connection != null; // το έβαλε μόνο του για να αντιμετωπίσει το warning
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2,
                    BCrypt.hashpw(password, BCrypt.gensalt(12)));
            if (userType == 1) {
                preparedStatement.setInt(3, 1);
            } else if (userType == 2) {
                preparedStatement.setInt(3, 2);
            }
            if (preparedStatement.executeUpdate() == 1) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}
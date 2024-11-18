package com.example.eduscore;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

                connection.close();
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
                connection.close();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1;
    }

    public static boolean updateLastLogin(String username , long unixTime) {
        try (Connection connection = Database.getConnection()){
            // Add login timestamp
            String query = "UPDATE users SET last_login = to_timestamp(? / 1000.0) WHERE id = ?;";
            if (connection == null) {
                throw new SQLException("Failed to establish a database connection.");
            }
            PreparedStatement preparedStatement = connection.prepareStatement(query);

            preparedStatement.setLong(1, unixTime);
            preparedStatement.setString(2, username);

            if (preparedStatement.executeUpdate() == 1) {
                connection.close();
                return true;
            } else {
                connection.close();
            }
        } catch (SQLException e){
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
            preparedStatement.setString(2, BCrypt.hashpw(password, BCrypt.gensalt(12)));
            if (userType == 1) {
                preparedStatement.setInt(3, 1);
            } else if (userType == 2) {
                preparedStatement.setInt(3, 2);
            }

            try {
                int upd = preparedStatement.executeUpdate();
                if (upd == 1) {
                    connection.close();
                    return true;
                }
            } catch (SQLException e) {
                e.printStackTrace();
                connection.close();
            }

//            if (preparedStatement.executeUpdate() == 1) {
//                connection.close();
//                return true;
//            } else {
//                connection.close();
//            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public static List<List<String>> getGrades(String course, int year) {
        // returns student <student_id, grade> for that course and year
        List<List<String>> grades = new ArrayList<>();

        try (Connection connection = Database.getConnection()) {
            String query = "SELECT student_id,grade FROM grades WHERE course_title = ? and year = ?;";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, course);
            preparedStatement.setInt(2, year);

            try (ResultSet result = preparedStatement.executeQuery();) {
                System.out.println(result);
                // τι μορφής είναι το result
                // πρέπει περαστεί στη λίστα grades

                return grades;
            } catch (SQLException e) {
                e.printStackTrace();
                connection.close();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
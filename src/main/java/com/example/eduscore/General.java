package com.example.eduscore;

import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

// Handles User Authentication and password hashing
public class General {

    public static int validateUser(String username, String password) {
        //  2 for successfully validated teacher
        //  1 for successfully validated student
        //  0 reserved for future use
        //  -1 no validation
        try (Connection connection = Database.getConnection()) {
            String query = "SELECT pass,user_type FROM users WHERE id = ?;";

            assert connection != null;
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            try (ResultSet result = preparedStatement.executeQuery()) {

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

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    public static  List<List<Object>> getCourses(String username, int year) {
        List<List<Object>> courses = new ArrayList<>();

        try (Connection connection = Database.getConnection()) {
            String query = "SELECT courses.title, courses.ects FROM courses WHERE courses.year <= ? AND courses.title NOT IN (SELECT grades.course_title FROM grades WHERE grades.student_id = ? AND grades.passed = true);";

            try {
                assert connection != null;
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setInt(1, year);
                preparedStatement.setString(2, username);

                try (ResultSet result = preparedStatement.executeQuery()) {
                    while (result.next()) {
                        List<Object> course = new ArrayList<>();
                        course.add(result.getString(1));
                        course.add(result.getInt(2));
                        courses.add(course);
                    }

                    connection.close();
                    return courses;

                } catch (SQLException e) {
                    connection.close();
                    e.printStackTrace();
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static int getStudentYear(String username) {
        try (Connection connection = Database.getConnection()) {
            String query = "SELECT entrance_year FROM students WHERE id = ?;";

            try {
                assert connection != null;
                try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                    preparedStatement.setString(1, username);

                    try (ResultSet result = preparedStatement.executeQuery()) {

                        if (result.next()) {
                            int entrance_year = result.getInt("entrance_year");
                            connection.close();
                            return 2024 - entrance_year + 1;
                        } else {
                            connection.close();
                        }

                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                }
            } catch (NullPointerException e) {
                e.printStackTrace();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static boolean checkCourseSubmission(String username) {
        try (Connection connection = Database.getConnection()) {
            String query = "SELECT * FROM submissions WHERE student_id = ? AND year = ?;";
            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
                preparedStatement.setString(1, username);
                preparedStatement.setInt(2, 2024);
                try {
                    ResultSet result = preparedStatement.executeQuery();
                    if (result.next()) {
                        connection.close();
                        return true;
                    } else {
                        connection.close();
                        return false;
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    public static boolean submitCourses(List<String> courses, String username) {
        try (Connection connection = Database.getConnection()) {
            String query = "INSERT INTO submissions VALUES (?,?,2024);";

            assert connection != null;
            try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {

                for (String course : courses) {
                    preparedStatement.setString(1, username);
                    preparedStatement.setString(2, course);
                    preparedStatement.addBatch();
                }
                int[] updateCounts = preparedStatement.executeBatch();
                try {
                    int batchUpdate = Arrays.stream(updateCounts).min().getAsInt();
                    if (batchUpdate >= 1) {
                        //proceed with adding empty grades
                        String queryGrades = "INSERT INTO grades(student_id, course_title, year, grade, passed) VALUES (?, ?, 2024, 0, false) ON CONFLICT (student_id, course_title) DO UPDATE SET grade = EXCLUDED.grade, year = EXCLUDED.year, passed = EXCLUDED.passed;";
                        try (PreparedStatement preparedStatement1 = connection.prepareStatement(queryGrades)) {

                            for (String course : courses) {
                                preparedStatement1.setString(1, username);
                                preparedStatement1.setString(2, course);
                                preparedStatement1.addBatch();
                            }

                            try {
                                int[] gradeCounts = preparedStatement1.executeBatch();
                                int gradesUpdate = Arrays.stream(gradeCounts).min().getAsInt();
                                if (gradesUpdate >= 1) {
                                    connection.close();
                                    return true;
                                }

                            } catch (SQLException e) {
                                e.printStackTrace();
                            }

                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                } catch (NoSuchElementException e) {
                    e.printStackTrace();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static List<List<Object>> getStudentGrades(String username) {
        List<List<Object>> grades = new ArrayList<>();

        try (Connection connection = Database.getConnection()) {
            String query = "SELECT grades.course_title,courses.year,grades.grade FROM grades RIGHT OUTER JOIN courses ON grades.course_title = courses.title WHERE grades.student_id = ? ORDER BY courses.year DESC, courses.title;";

            assert connection != null;
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, username);
            try (ResultSet result = preparedStatement.executeQuery()) {
                while (result.next()) {
                    List<Object> grade = new ArrayList<>();
                    grade.add(result.getString(1));
                    grade.add(result.getInt(2));
                    grade.add(result.getInt(3));
                    grades.add(grade);
                }

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

    public static List<List<Object>> getTeacherGrades(String username) {
        List<List<Object>> grades = new ArrayList<>();

        try (Connection connection = Database.getConnection()) {
            String query = "SELECT students.full_name,grades.course_title,grades.year,grades.grade FROM students RIGHT OUTER JOIN grades ON students.id = grades.student_id JOIN courses ON courses.title = grades.course_title WHERE courses.professor = ? ORDER BY course_title, year DESC;";
            try {
                assert connection != null;
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, username);

                try (ResultSet result = preparedStatement.executeQuery()) {
                    while (result.next()) {
                        List<Object> grade = new ArrayList<>();
                        grade.add(result.getString(1));
                        grade.add(result.getString(2));
                        grade.add(result.getInt(3));
                        grade.add(result.getInt(4));
                        grades.add(grade);
                    }
                    connection.close();
                    return grades;
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<List<Object>> getEmptyGrades (String username) {
        List<List<Object>> grades = new ArrayList<>();

        try (Connection connection = Database.getConnection()) {
            String query = "SELECT students.full_name,grades.course_title FROM students RIGHT OUTER JOIN grades ON students.id = grades.student_id JOIN courses ON courses.title = grades.course_title WHERE courses.professor = ? AND grades.grade = 0 AND grades.year = 2024 ORDER BY course_title;";

            try {
                assert connection != null;
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, username);

                try (ResultSet result = preparedStatement.executeQuery()) {

                    while (result.next()) {
                        List<Object> grade = new ArrayList<>();
                        grade.add(result.getString(1));
                        grade.add(result.getString(2));
                        grades.add(grade);
                    }

                    connection.close();
                    return grades;

                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }


        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean assignGrades (int[] grades, String username) {
        List<List<Object>> emptyGrades = getEmptyGrades(username);
        if (emptyGrades != null) {
            try (Connection connection = Database.getConnection()) {
                String query = "UPDATE grades SET grade = ?, passed = CASE WHEN grade >= 50 THEN true ELSE false END WHERE course_title = ? AND student_id = (SELECT id FROM students WHERE full_name = ?);";
                try {
                    assert connection != null;
                    PreparedStatement preparedStatement = connection.prepareStatement(query);
                    if (emptyGrades.size() == grades.length) {
                        int i = 0;
                        for (List<Object> emptyGrade : emptyGrades) {
                            preparedStatement.setInt(1, grades[i]);
                            preparedStatement.setString(2, emptyGrade.getLast().toString());
                            preparedStatement.setString(3, emptyGrade.getFirst().toString());
                            preparedStatement.addBatch();
                            i += 1;
                        }

                        try {
                            int[] result = preparedStatement.executeBatch();
                            int gradesUpdate = Arrays.stream(result).min().getAsInt();
                            connection.close();
                            if (gradesUpdate >= 1) {
                                return true;
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public static List<Object> getStudentInfo(String username) {
        List<Object> profileInfo = new ArrayList<>();

        try (Connection connection = Database.getConnection()) {
            String query = "SELECT full_name,entrance_year,email,phone_number FROM students WHERE id = ?;";

            try {
                assert connection != null;
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, username);

                try (ResultSet result = preparedStatement.executeQuery()) {
                    while (result.next()) {
                        profileInfo.add(result.getString(1));
                        profileInfo.add(result.getInt(2));
                        profileInfo.add(result.getString(3));
                        profileInfo.add(result.getString(4));
                    }

                    return profileInfo;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Object> getProfessorInfo(String username) {
        List<Object> professorInfo = new ArrayList<>();

        try (Connection connection = Database.getConnection()) {
            String query = "SELECT full_name, email, phone_number, office_addr, rank FROM professors WHERE id = ?;";

            try {
                assert connection != null;
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                preparedStatement.setString(1, username);
                try (ResultSet result = preparedStatement.executeQuery()) {
                    while (result.next()) {
                        professorInfo.add(result.getString(1));
                        professorInfo.add(result.getString(2));
                        professorInfo.add(result.getString(3));
                        professorInfo.add(result.getString(4));
                        professorInfo.add(result.getString(5));
                    }
                    return professorInfo;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
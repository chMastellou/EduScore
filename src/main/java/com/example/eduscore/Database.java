package com.example.eduscore;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    static final String JDBC_URL = "jdbc:postgresql://localhost:5432/edubase?currentSchema=public&user=edu_admin&password=$Edu5432!"; //edu_user $Edu8765!

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(JDBC_URL);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }

}

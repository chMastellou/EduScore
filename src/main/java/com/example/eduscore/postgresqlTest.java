package com.example.eduscore;

import java.sql.Connection;
import java.sql.DriverManager;



public class postgresqlTest {
    static final String JDBC_URL = "jdbc:postgresql://localhost:5432/edubase?currentSchema=public&user=edu_admin&password=$Edu5432!";

    public static Connection DBconnect() {
        Connection conn = null;

        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(JDBC_URL);
        } catch (Exception e) {
            System.out.println("PostgreSQL JDBC Driver not found");
        }

        return conn;
    }
}

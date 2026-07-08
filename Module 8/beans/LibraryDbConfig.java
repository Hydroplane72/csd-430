package beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/*
 Name: Matthew Rozendaal
 Date: 2026-06-16
 Assignment: Module 5 and 6 - Library Runtime Config
 Purpose: Store the Library database connection settings for the JSP pages.
 Note: In a production application, you would not want to hard-code these values in your source code. 
 Instead, you would typically read them from a configuration file or environment variables. 
 However, for the purposes of this assignment, I am keeping it simple and hard-coding the values here.
 */
public final class LibraryDbConfig {

    private static final String JDBC_URL = "jdbc:mysql://127.0.0.1:3306/CSD430?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USERNAME = "student1";
    private static final String PASSWORD = "pass";

    private LibraryDbConfig() {
    }

    public static String getJdbcUrl() {
        return JDBC_URL;
    }

    public static String getUsername() {
        return USERNAME;
    }

    public static String getPassword() {
        return PASSWORD;
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException classNotFoundException) {
            throw new SQLException("MySQL JDBC driver not found.", classNotFoundException);
        }

        return DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
    }
}

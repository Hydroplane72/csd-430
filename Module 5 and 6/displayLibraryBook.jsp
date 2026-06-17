<%--
Name: Matthew Rozendaal
Date: 2026-06-16
Assignment: Module 5 and 6 - Library Book Display
Purpose: Display the selected Library book record in a table.
--%>
<%@ page import="java.sql.*,module5and6.LibraryBookBean,module5and6.LibraryDbConfig" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%!
    private String htmlEscape(String value) {
        if (value == null) {
            return "";
        }
        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;");
    }
%>
<%
    String bookId = request.getParameter("bookId");
    LibraryBookBean selectedBook = null;
    String message = "";

    if (bookId == null || bookId.trim().isEmpty()) {
        message = "Please return to the selector page and choose a book.";
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

                try (Connection connection = DriverManager.getConnection(
                    LibraryDbConfig.getJdbcUrl(),
                    LibraryDbConfig.getUsername(),
                    LibraryDbConfig.getPassword());
                 PreparedStatement statement = connection.prepareStatement(
                         "SELECT ID, Name, Summary, Author, Genre, IsCheckedOut, LastCheckedOut, `Condition`, ISBN FROM matthew_library_data WHERE ID = ?")) {
                statement.setInt(1, Integer.parseInt(bookId));

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        selectedBook = new LibraryBookBean();
                        selectedBook.setId(resultSet.getInt("ID"));
                        selectedBook.setName(resultSet.getString("Name"));
                        selectedBook.setSummary(resultSet.getString("Summary"));
                        selectedBook.setAuthor(resultSet.getString("Author"));
                        selectedBook.setGenre(resultSet.getString("Genre"));
                        selectedBook.setCheckedOut(resultSet.getBoolean("IsCheckedOut"));
                        selectedBook.setLastCheckedOut(resultSet.getString("LastCheckedOut"));
                        selectedBook.setCondition(resultSet.getString("Condition"));
                        selectedBook.setIsbn(resultSet.getString("ISBN"));
                    } else {
                        message = "No Library book was found for the selected ID.";
                    }
                }
            }
        } catch (Exception exception) {
            message = exception.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Selected Library Book</title>
    <link rel="stylesheet" href="ProjectMain.css" />
</head>
<body>
<div class="container">
    <h1>Selected Library Book</h1>
    <p>
        The table below displays the selected book record from the Library database.
    </p>

    <% if (!message.isEmpty()) { %>
        <div class="<%= message.contains("error") || message.contains("Error") ? "error" : "notice" %>">
            <strong><%= message.contains("error") || message.contains("Error") ? "Error:" : "Notice:" %></strong> <%= htmlEscape(message) %>
        </div>
    <% } %>

    <% if (selectedBook != null) { %>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Summary</th>
                <th>Author</th>
                <th>Genre</th>
                <th>Checked Out</th>
                <th>Last Checked Out</th>
                <th>Condition</th>
                <th>ISBN</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td><%= selectedBook.getId() %></td>
                <td><%= htmlEscape(selectedBook.getName()) %></td>
                <td><%= htmlEscape(selectedBook.getSummary()) %></td>
                <td><%= htmlEscape(selectedBook.getAuthor()) %></td>
                <td><%= htmlEscape(selectedBook.getGenre()) %></td>
                <td><%= selectedBook.isCheckedOut() ? "Yes" : "No" %></td>
                <td><%= selectedBook.getLastCheckedOut() == null || selectedBook.getLastCheckedOut().trim().isEmpty() ? "N/A" : htmlEscape(selectedBook.getLastCheckedOut()) %></td>
                <td><%= htmlEscape(selectedBook.getCondition()) %></td>
                <td><%= htmlEscape(selectedBook.getIsbn()) %></td>
            </tr>
            </tbody>
        </table>
    <% } %>

    <div class="nav-links">
        <a href="libraryBookSelector.jsp">Choose Another Book</a>
        <a href="index.jsp">Return to Module 5 and 6 Index</a>
    </div>
</div>
</body>
</html>
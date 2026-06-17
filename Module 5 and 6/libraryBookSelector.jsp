<%--
Name: Matthew Rozendaal
Date: 2026-06-16
Assignment: Module 5 and 6 - Library Book Selector
Purpose: Load Library book keys from the database and let the user choose one.
--%>
<%@ page import="java.sql.*,java.util.ArrayList,module5and6.LibraryBookBean,module5and6.LibraryDbConfig" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    ArrayList<LibraryBookBean> books = new ArrayList<LibraryBookBean>();
    String loadMessage = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection(
                    LibraryDbConfig.getJdbcUrl(),
                    LibraryDbConfig.getUsername(),
                    LibraryDbConfig.getPassword());
             PreparedStatement statement = connection.prepareStatement("SELECT ID, Name FROM matthew_library_data ORDER BY ID");
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                LibraryBookBean book = new LibraryBookBean();
                book.setId(resultSet.getInt("ID"));
                book.setName(resultSet.getString("Name"));
                books.add(book);
            }
        }
    } catch (Exception exception) {
        loadMessage = exception.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Library Book Selector</title>
    <link rel="stylesheet" href="ProjectMain.css" />
</head>
<body>
<div class="container container-narrow">
    <h1>Library Book Selector</h1>
    <p>
        Choose a book from the Library database to display its full record on the next page.
    </p>

    <% if (!loadMessage.isEmpty()) { %>
        <div class="error"><strong>Database error:</strong> <%= htmlEscape(loadMessage) %></div>
    <% } %>

    <form action="displayLibraryBook.jsp" method="post">
        <div class="form-group">
            <label for="bookId">Select a Book</label>
            <select id="bookId" name="bookId" required>
                <option value="">-- Choose a Book --</option>
                <% for (LibraryBookBean book : books) { %>
                    <option value="<%= book.getId() %>">#<%= book.getId() %> - <%= htmlEscape(book.getName()) %></option>
                <% } %>
            </select>
        </div>
        <button type="submit">Show Selected Record</button>
    </form>

    <div class="nav-links">
        <a href="index.jsp">Return to Module 5 and 6 Index</a>
    </div>
</div>
</body>
</html>
<%--
Name: Matthew Rozendaal
Date: 2026-07-06
Assignment: Module 7 - Library Insert and Display
Purpose: Use JavaBean methods to insert a new record and display all Library records.
--%>
<%@ page import="java.util.List,beans.LibraryBookBean" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:useBean id="libraryBookBean" class="beans.LibraryBookBean" scope="page" />
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

    private String safeTrim(String value) {
        return value == null ? "" : value.trim();
    }
%>
<%
    boolean hasFormData = request.getParameter("name") != null;
    String message = "";
    List<LibraryBookBean> books = null;

    if (hasFormData) {
        String name = safeTrim(request.getParameter("name"));
        String summary = safeTrim(request.getParameter("summary"));
        String author = safeTrim(request.getParameter("author"));
        String genre = safeTrim(request.getParameter("genre"));
        boolean isCheckedOut = Boolean.parseBoolean(safeTrim(request.getParameter("isCheckedOut")));
        String lastCheckedOut = safeTrim(request.getParameter("lastCheckedOut"));
        String condition = safeTrim(request.getParameter("condition"));
        String isbn = safeTrim(request.getParameter("isbn"));

        if (name.isEmpty() || summary.isEmpty() || author.isEmpty() || genre.isEmpty() || condition.isEmpty() || isbn.isEmpty()) {
            message = "Please provide all required form fields before submitting.";
        } else {
            libraryBookBean.setName(name);
            libraryBookBean.setSummary(summary);
            libraryBookBean.setAuthor(author);
            libraryBookBean.setGenre(genre);
            libraryBookBean.setCheckedOut(isCheckedOut);
            libraryBookBean.setLastCheckedOut(lastCheckedOut);
            libraryBookBean.setCondition(condition);
            libraryBookBean.setIsbn(isbn);

            try {
                int rowsInserted = libraryBookBean.insertRecord();
                if (rowsInserted > 0) {
                    message = "A new Library record was added successfully.";
                } else {
                    message = "No record was inserted. Please try again.";
                }
            } catch (Exception exception) {
                message = "Database error: " + exception.getMessage();
            }
        }
    }

    try {
        books = libraryBookBean.getAllRecords();
    } catch (Exception exception) {
        if (message.isEmpty()) {
            message = "Database error: " + exception.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Library Records Table</title>
    <link rel="stylesheet" href="ProjectMain.css" />
</head>
<body>
<div class="container">
    <h1>Library Records Table</h1>
    <p>
        The table below displays all records and field values from the Library database table.
    </p>

    <p class="description">
        <strong>Data Description:</strong> Each row represents one book record and each column represents one field, including key, title, summary, author, genre, checkout status, date, condition, and ISBN.
    </p>

    <% if (!message.isEmpty()) { %>
        <div class="<%= message.toLowerCase().contains("error") ? "error" : "notice" %>">
            <strong><%= message.toLowerCase().contains("error") ? "Error:" : "Notice:" %></strong> <%= htmlEscape(message) %>
        </div>
    <% } %>

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
        <% if (books != null && !books.isEmpty()) { %>
            <% for (LibraryBookBean book : books) { %>
                <tr>
                    <td><%= book.getId() %></td>
                    <td><%= htmlEscape(book.getName()) %></td>
                    <td><%= htmlEscape(book.getSummary()) %></td>
                    <td><%= htmlEscape(book.getAuthor()) %></td>
                    <td><%= htmlEscape(book.getGenre()) %></td>
                    <td><%= book.isCheckedOut() ? "Yes" : "No" %></td>
                    <td><%= book.getLastCheckedOut() == null || book.getLastCheckedOut().trim().isEmpty() ? "N/A" : htmlEscape(book.getLastCheckedOut()) %></td>
                    <td><%= htmlEscape(book.getCondition()) %></td>
                    <td><%= htmlEscape(book.getIsbn()) %></td>
                </tr>
            <% } %>
        <% } else { %>
                <tr>
                    <td colspan="9">No Library records are available yet.</td>
                </tr>
        <% } %>
        </tbody>
    </table>

    <div class="nav-links">
        <a href="libraryBookSelector.jsp">Add Another Record</a>
        <a href="index.jsp">Return to Module 7 Index</a>
    </div>
</div>
</body>
</html>
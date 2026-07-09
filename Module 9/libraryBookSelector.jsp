<%--
Name: Matthew Rozendaal
Date: 2026-07-06
Assignment: Module 8 - Library Add Record Form
Purpose: Collect user input for adding a new Library record.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Library Add Record Form</title>
    <% String projectMainCssVersion = String.valueOf(new java.io.File(application.getRealPath("/ProjectMain.css")).lastModified()); %>
    <link rel="stylesheet" href="ProjectMain.css?v=<%= projectMainCssVersion %>" />
</head>
<body>
<div class="container container-narrow">
    <h1>Library Record Input Form</h1>
    <p>
        Enter the field values below to create a new Library record. The database key value is generated when the record is submitted.
    </p>

    <form action="displayLibraryBook.jsp" method="post">
        <input type="hidden" name="action" value="add" />
        <div class="form-group">
            <label for="name">Book Name</label>
            <input id="name" name="name" type="text" maxlength="120" required />
        </div>

        <div class="form-group">
            <label for="summary">Summary</label>
            <textarea id="summary" name="summary" rows="4" maxlength="1000" required></textarea>
        </div>

        <div class="form-group">
            <label for="author">Author</label>
            <input id="author" name="author" type="text" maxlength="120" required />
        </div>

        <div class="form-group">
            <label for="genre">Genre</label>
            <input id="genre" name="genre" type="text" maxlength="80" required />
        </div>

        <div class="form-group">
            <label for="isCheckedOut">Checked Out</label>
            <select id="isCheckedOut" name="isCheckedOut" required>
                <option value="false">No</option>
                <option value="true">Yes</option>
            </select>
        </div>

        <div class="form-group">
            <label for="lastCheckedOut">Last Checked Out Date (Optional)</label>
            <input id="lastCheckedOut" name="lastCheckedOut" type="date" />
        </div>

        <div class="form-group">
            <label for="condition">Condition</label>
            <input id="condition" name="condition" type="text" maxlength="80" required />
        </div>

        <div class="form-group">
            <label for="isbn">ISBN</label>
            <input id="isbn" name="isbn" type="text" maxlength="20" required />
        </div>

        <button type="submit">Add Record and Display Table</button>
    </form>

    <div class="description">
        <strong>Record Description:</strong> The record includes title, summary, author, genre, checkout status, checkout date, condition, and ISBN.
    </div>

    <div class="nav-links">
        <a href="displayLibraryBook.jsp">View All Records</a>
        <a href="index.jsp">Return to Module 8 Index</a>
    </div>
</div>
</body>
</html>
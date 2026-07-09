<%--
Name: Matthew Rozendaal
Date: 2026-07-08
Assignment: Module 9 - Library Project Part 4 Index
Purpose: Provide links to the Module 9 add, display, and delete pages.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Module 9 Index</title>
    <% String indexCssVersion = String.valueOf(new java.io.File(application.getRealPath("/indexStyle.css")).lastModified()); %>
    <link rel="stylesheet" href="indexStyle.css?v=<%= indexCssVersion %>" />
</head>
<body>
<div class="container">
    <h1>Module 9 - Library Project Part 4</h1>
<p>
    Use the links below to add records and open the display page where each book can be deleted from the table.
</p>

<ul>
    <li><a href="libraryBookSelector.jsp">Add Library Record Form</a></li>
    <li><a href="displayLibraryBook.jsp">Display and Edit Library Records</a></li>
    <li><a href="MatthewcreateDatabase.sql">Create Database SQL</a></li>
    <li><a href="MatthewcreateTable.sql">Create Table SQL</a></li>
    <li><a href="MatthewpopulateTable.sql">Populate Table SQL</a></li>
    <li><a href="MatthewdropTable.sql">Drop Table SQL</a></li>
</ul>
</div>
</body>
</html>
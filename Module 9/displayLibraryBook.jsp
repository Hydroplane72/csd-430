<%--
Name: Matthew Rozendaal
Date: 2026-07-07
Assignment: Module 8 - Library Edit and Display
Purpose: Insert and update Library records through JavaBean methods, then display all records.
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

    private int safeParseInt(String value) {
        try {
            return Integer.parseInt(safeTrim(value));
        } catch (Exception exception) {
            return -1;
        }
    }

    private String urlEncode(String value) {
        try {
            return java.net.URLEncoder.encode(value, "UTF-8");
        } catch (Exception exception) {
            return "";
        }
    }
%>
<%
    String action = safeTrim(request.getParameter("action"));
    if (action.isEmpty() && request.getParameter("name") != null) {
        action = "add";
    }

    String status = safeTrim(request.getParameter("status"));
    String searchTerm = safeTrim(request.getParameter("searchTerm"));
    String searchTermLower = searchTerm.toLowerCase();
    String message = "";
    List<LibraryBookBean> books = null;
    LibraryBookBean editBook = null;
    boolean showEditModal = false;
    int editId = safeParseInt(request.getParameter("id"));

    if ("updated".equalsIgnoreCase(status)) {
        message = "Library record was updated successfully.";
    }

    if ("add".equalsIgnoreCase(action)) {
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
    } else if ("openEdit".equalsIgnoreCase(action)) {
        if (editId <= 0) {
            message = "Please select a valid record to edit.";
        } else {
            try {
                editBook = libraryBookBean.getRecordById(editId);
                if (editBook == null) {
                    message = "The selected record could not be found.";
                } else {
                    showEditModal = true;
                }
            } catch (Exception exception) {
                message = "Database error: " + exception.getMessage();
            }
        }
    } else if ("saveEdit".equalsIgnoreCase(action)) {
        String name = safeTrim(request.getParameter("name"));
        String summary = safeTrim(request.getParameter("summary"));
        String author = safeTrim(request.getParameter("author"));
        String genre = safeTrim(request.getParameter("genre"));
        boolean isCheckedOut = Boolean.parseBoolean(safeTrim(request.getParameter("isCheckedOut")));
        String lastCheckedOut = safeTrim(request.getParameter("lastCheckedOut"));
        String condition = safeTrim(request.getParameter("condition"));
        String isbn = safeTrim(request.getParameter("isbn"));

        editBook = new LibraryBookBean();
        editBook.setId(editId);
        editBook.setName(name);
        editBook.setSummary(summary);
        editBook.setAuthor(author);
        editBook.setGenre(genre);
        editBook.setCheckedOut(isCheckedOut);
        editBook.setLastCheckedOut(lastCheckedOut);
        editBook.setCondition(condition);
        editBook.setIsbn(isbn);
        showEditModal = true;

        if (editId <= 0 || name.isEmpty() || summary.isEmpty() || author.isEmpty() || genre.isEmpty() || condition.isEmpty() || isbn.isEmpty()) {
            message = "Please provide all required fields before saving your update.";
        } else {
            try {
                libraryBookBean.setId(editId);
                libraryBookBean.setName(name);
                libraryBookBean.setSummary(summary);
                libraryBookBean.setAuthor(author);
                libraryBookBean.setGenre(genre);
                libraryBookBean.setCheckedOut(isCheckedOut);
                libraryBookBean.setLastCheckedOut(lastCheckedOut);
                libraryBookBean.setCondition(condition);
                libraryBookBean.setIsbn(isbn);

                int rowsUpdated = libraryBookBean.updateRecord();
                if (rowsUpdated > 0) {
                    String redirectUrl = "displayLibraryBook.jsp?status=updated";
                    if (!searchTerm.isEmpty()) {
                        redirectUrl += "&searchTerm=" + urlEncode(searchTerm);
                    }
                    response.sendRedirect(redirectUrl);
                    return;
                } else {
                    message = "No record was updated. Please try again.";
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

    String cancelEditUrl = "displayLibraryBook.jsp";
    if (!searchTerm.isEmpty()) {
        cancelEditUrl += "?searchTerm=" + urlEncode(searchTerm);
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
        <strong>Data Description:</strong> Use Edit for any row to open a popup form, update field values, and save changes back to the database.
    </p>

    <% if (!message.isEmpty()) { %>
        <div class="<%= message.toLowerCase().contains("error") ? "error" : "notice" %>">
            <strong><%= message.toLowerCase().contains("error") ? "Error:" : "Notice:" %></strong> <%= htmlEscape(message) %>
        </div>
    <% } %>

    <form action="displayLibraryBook.jsp" method="get">
        <div class="form-group">
            <label for="searchTerm">Search Books (All Columns)</label>
            <input id="searchTerm" name="searchTerm" type="text" value="<%= htmlEscape(searchTerm) %>" placeholder="Enter any value to filter table rows" />
        </div>
        <button type="submit">Search</button>
    </form>

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
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (books != null && !books.isEmpty()) { %>
            <%
                int displayedRows = 0;
                for (LibraryBookBean book : books) {
                    String idValue = String.valueOf(book.getId());
                    String nameValue = book.getName() == null ? "" : book.getName();
                    String summaryValue = book.getSummary() == null ? "" : book.getSummary();
                    String authorValue = book.getAuthor() == null ? "" : book.getAuthor();
                    String genreValue = book.getGenre() == null ? "" : book.getGenre();
                    String checkedOutValue = book.isCheckedOut() ? "yes" : "no";
                    String lastCheckedOutValue = book.getLastCheckedOut() == null ? "" : book.getLastCheckedOut();
                    String conditionValue = book.getCondition() == null ? "" : book.getCondition();
                    String isbnValue = book.getIsbn() == null ? "" : book.getIsbn();

                    boolean matchesSearch = searchTermLower.isEmpty()
                            || idValue.toLowerCase().contains(searchTermLower)
                            || nameValue.toLowerCase().contains(searchTermLower)
                            || summaryValue.toLowerCase().contains(searchTermLower)
                            || authorValue.toLowerCase().contains(searchTermLower)
                            || genreValue.toLowerCase().contains(searchTermLower)
                            || checkedOutValue.contains(searchTermLower)
                            || lastCheckedOutValue.toLowerCase().contains(searchTermLower)
                            || conditionValue.toLowerCase().contains(searchTermLower)
                            || isbnValue.toLowerCase().contains(searchTermLower);

                    if (!matchesSearch) {
                        continue;
                    }

                    displayedRows++;
            %>
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
                    <td>
                        <form action="displayLibraryBook.jsp" method="get" class="inline-form">
                            <input type="hidden" name="action" value="openEdit" />
                            <input type="hidden" name="id" value="<%= book.getId() %>" />
                            <input type="hidden" name="searchTerm" value="<%= htmlEscape(searchTerm) %>" />
                            <button type="submit" class="row-action">Edit</button>
                        </form>
                    </td>
                </tr>
            <%
                }
                if (displayedRows == 0) {
            %>
                <tr>
                    <td colspan="10">No Library records matched the search criteria.</td>
                </tr>
            <%
                }
            %>
        <% } else { %>
                <tr>
                    <td colspan="10">No Library records are available yet.</td>
                </tr>
        <% } %>
        </tbody>
    </table>

    <div class="nav-links">
        <a href="libraryBookSelector.jsp">Add Another Record</a>
        <a href="index.jsp">Return to Module 8 Index</a>
    </div>
</div>

<div class="modal <%= (showEditModal && editBook != null) ? "show" : "" %>">
    <div class="modal-content">
        <h2>Edit Library Record</h2>
        <p class="description">
            Update the editable fields below and select Save Changes. The ID is displayed but cannot be updated.
        </p>

        <% if (showEditModal && editBook != null) { %>
            <form action="displayLibraryBook.jsp" method="post">
                <input type="hidden" name="action" value="saveEdit" />
                <input type="hidden" name="id" value="<%= editBook.getId() %>" />
                <input type="hidden" name="searchTerm" value="<%= htmlEscape(searchTerm) %>" />

                <div class="form-group">
                    <label>Record ID (read only)</label>
                    <input type="text" value="<%= editBook.getId() %>" readonly />
                </div>

                <div class="form-group">
                    <label for="editName">Book Name</label>
                    <input id="editName" name="name" type="text" maxlength="120" value="<%= htmlEscape(editBook.getName()) %>" required />
                </div>

                <div class="form-group">
                    <label for="editSummary">Summary</label>
                    <textarea id="editSummary" name="summary" rows="4" maxlength="1000" required><%= htmlEscape(editBook.getSummary()) %></textarea>
                </div>

                <div class="form-group">
                    <label for="editAuthor">Author</label>
                    <input id="editAuthor" name="author" type="text" maxlength="120" value="<%= htmlEscape(editBook.getAuthor()) %>" required />
                </div>

                <div class="form-group">
                    <label for="editGenre">Genre</label>
                    <input id="editGenre" name="genre" type="text" maxlength="80" value="<%= htmlEscape(editBook.getGenre()) %>" required />
                </div>

                <div class="form-group">
                    <label for="editCheckedOut">Checked Out</label>
                    <select id="editCheckedOut" name="isCheckedOut" required>
                        <option value="false" <%= editBook.isCheckedOut() ? "" : "selected" %>>No</option>
                        <option value="true" <%= editBook.isCheckedOut() ? "selected" : "" %>>Yes</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="editLastCheckedOut">Last Checked Out Date (Optional)</label>
                    <input id="editLastCheckedOut" name="lastCheckedOut" type="date" value="<%= htmlEscape(editBook.getLastCheckedOut()) %>" />
                </div>

                <div class="form-group">
                    <label for="editCondition">Condition</label>
                    <input id="editCondition" name="condition" type="text" maxlength="80" value="<%= htmlEscape(editBook.getCondition()) %>" required />
                </div>

                <div class="form-group">
                    <label for="editIsbn">ISBN</label>
                    <input id="editIsbn" name="isbn" type="text" maxlength="20" value="<%= htmlEscape(editBook.getIsbn()) %>" required />
                </div>

                <div class="modal-actions">
                    <button type="submit">Save Changes</button>
                    <a href="<%= cancelEditUrl %>" class="modal-cancel">Cancel</a>
                </div>
            </form>
        <% } %>
    </div>
</div>
</body>
</html>
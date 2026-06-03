<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*" %>
<%
/*
 Name: Matthew Rozendaal
 Date: 2026-06-03
 Assignment: Module 2 - Dynamic HTML Page Using JSP Scriptlets
 Purpose: Display grouped book records in an HTML table using JSP scriptlets and external CSS.
 Source Note: Book list and general page structure created by hand; 
 GitHub Copilot was used to assist with repetitive code patterns and CSS formatting. 
 GitHub Copilot also helped with book descriptions, which were generated based on the book's general theme and style. 
 The overall page structure and data organization were designed by the author, with GitHub Copilot providing suggestions for code efficiency and readability.
*/

// Book record format: {Title, Author, Description}
Map<String, List<String[]>> groupedBooks = new LinkedHashMap<String, List<String[]>>();

groupedBooks.put("Fantasy", new ArrayList<String[]>());
groupedBooks.get("Fantasy").add(new String[] {"Harry Potter", "J. K. Rowling", "A wizarding-world story centered on friendship and courage."});
groupedBooks.get("Fantasy").add(new String[] {"Tiger's Curse", "Colleen Houck", "A myth-inspired fantasy adventure with a magical curse."});

groupedBooks.put("Mythology and Adventure", new ArrayList<String[]>());
groupedBooks.get("Mythology and Adventure").add(new String[] {"Percy Jackson", "Rick Riordan", "A modern mythological journey featuring Greek gods."});
groupedBooks.get("Mythology and Adventure").add(new String[] {"Alex Rider", "Anthony Horowitz", "A fast-paced young-spy action adventure."});

groupedBooks.put("Humor and Picture Books", new ArrayList<String[]>());
groupedBooks.get("Humor and Picture Books").add(new String[] {"The Book with No Pictures", "B. J. Novak", "A playful read-aloud that uses words to create humor."});

int totalRecords = 0;
for (Map.Entry<String, List<String[]>> entry : groupedBooks.entrySet()) {
    totalRecords += entry.getValue().size();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Records by Category</title>
    <link rel="stylesheet" href="books-styles.css">
</head>
<body>
    <main class="page-wrap">
        <header class="page-header">
            <h1>Book Records</h1>
            <p class="subtitle">Dynamic JSP table output grouped by topical categories.</p>
        </header>

        <section class="description-card">
            <h2>Overall Data Description</h2>
            <p>
                This page shows <strong><%= totalRecords %></strong> book records. Each record contains
                three fields and is grouped into a topical category.
            </p>

            <h3>Field Descriptions</h3>
            <ul>
                <li><strong>Title:</strong> The name of the book.</li>
                <li><strong>Author:</strong> The writer of the book.</li>
                <li><strong>Description:</strong> A short summary of the book's theme or style.</li>
            </ul>
        </section>

        <% for (Map.Entry<String, List<String[]>> categoryEntry : groupedBooks.entrySet()) { %>
        <section class="category-section">
            <h2><%= categoryEntry.getKey() %></h2>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Description</th>
                    </tr>
                </thead>
                <tbody>
                    <% int rowNumber = 1; %>
                    <% for (String[] book : categoryEntry.getValue()) { %>
                    <tr>
                        <td><%= rowNumber %></td>
                        <td><%= book[0] %></td>
                        <td><%= book[1] %></td>
                        <td><%= book[2] %></td>
                    </tr>
                    <% rowNumber++; %>
                    <% } %>
                </tbody>
            </table>
        </section>
        <% } %>
    </main>
</body>
</html>
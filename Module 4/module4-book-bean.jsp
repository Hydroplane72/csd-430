<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.util.*, module4.BookRecordBean" %>
<%!
/*
 Name: Matthew Rozendaal
 Date: 2026-06-12
 Assignment: Module 4 - JavaBean Data Display
 Purpose: Display grouped book records from a JavaBean-style data model in a formatted JSP table.
 Source Note: Book data was adapted from the Module 2 JSP assignment.
*/
%>
<%
// Create the sample book records that will be shown on the page.
List<BookRecordBean> bookRecords = new ArrayList<BookRecordBean>();

bookRecords.add(new BookRecordBean(
        "Fantasy",
        "Harry Potter",
        "J. K. Rowling",
        "A wizarding-world story centered on friendship and courage.",
        "Wizarding adventure"));

bookRecords.add(new BookRecordBean(
        "Fantasy",
        "Tiger's Curse",
        "Colleen Houck",
        "A myth-inspired fantasy adventure with a magical curse.",
        "Mythic quest"));

bookRecords.add(new BookRecordBean(
        "Mythology and Adventure",
        "Percy Jackson",
        "Rick Riordan",
        "A modern mythological journey featuring Greek gods.",
        "Modern mythology"));

bookRecords.add(new BookRecordBean(
        "Mythology and Adventure",
        "Alex Rider",
        "Anthony Horowitz",
        "A fast-paced young-spy action adventure.",
        "Spy thriller"));

bookRecords.add(new BookRecordBean(
        "Humor and Picture Books",
        "The Book with No Pictures",
        "B. J. Novak",
        "A playful read-aloud that uses words to create humor.",
        "Interactive comedy"));

// Group the books by category so the display can show one table per topic.
Map<String, List<BookRecordBean>> groupedBooks = new LinkedHashMap<String, List<BookRecordBean>>();
for (BookRecordBean book : bookRecords) {
    if (!groupedBooks.containsKey(book.getCategory())) {
        groupedBooks.put(book.getCategory(), new ArrayList<BookRecordBean>());
    }
    groupedBooks.get(book.getCategory()).add(book);
}

// Store the total so the page can describe how many records it is rendering.
int totalRecords = bookRecords.size();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Module 4 Book Bean Display</title>
    <link rel="stylesheet" href="module4-book-bean.css">
</head>
<body>
    <main class="page-wrap">
        <header class="page-header">
            <p class="eyebrow">Module 4 JavaBean Display</p>
            <h1>Book Records from a JavaBean</h1>
            <p class="subtitle">The page reads book data from a bean-style model and presents it in grouped tables.</p>
        </header>

        <section class="description-card">
            <h2>Overall Data Description</h2>
            <p>
                This page shows <strong><%= totalRecords %></strong> book records. The data is organized by category and
                displayed with a JavaBean-style object for each book.
            </p>

            <!-- Describe each field so the table columns are easy to understand. -->
            <h3>Field Descriptions</h3>
            <ul>
                <li><strong>Category:</strong> The book group the record belongs to.</li>
                <li><strong>Title:</strong> The name of the book.</li>
                <li><strong>Author:</strong> The writer of the book.</li>
                <li><strong>Description:</strong> A short summary of the book's theme or style.</li>
                <li><strong>Theme:</strong> A short label that describes the book's overall appeal.</li>
            </ul>
        </section>

        <!-- Render one table section for each book category. -->
        <% for (Map.Entry<String, List<BookRecordBean>> categoryEntry : groupedBooks.entrySet()) { %>
        <section class="category-section">
            <h2><%= categoryEntry.getKey() %></h2>
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Category</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Description</th>
                        <th>Theme</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Number the rows within each category table. -->
                    <% int rowNumber = 1; %>
                    <% for (BookRecordBean book : categoryEntry.getValue()) { %>
                    <tr>
                        <td><%= rowNumber %></td>
                        <td><%= book.getCategory() %></td>
                        <td><%= book.getTitle() %></td>
                        <td><%= book.getAuthor() %></td>
                        <td><%= book.getDescription() %></td>
                        <td><%= book.getTheme() %></td>
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
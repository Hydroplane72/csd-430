package module4;

import java.io.Serializable;

/*
 Name: Matthew Rozendaal
 Date: 2026-06-12
 Assignment: Module 4 - JavaBean Data Display
 Purpose: Hold a single book record for the Module 4 JSP display.
 Source Note: Book fields and data structure were adapted from the Module 2 JSP assignment.
 */
public class BookRecordBean implements Serializable {

    private static final long serialVersionUID = 1L;

    // Each field stores one piece of book data for the JSP table.
    private String category;
    private String title;
    private String author;
    private String description;
    private String theme;

    // Default constructor required by the JavaBean pattern.
    public BookRecordBean() {
    }

    // Convenience constructor used when creating sample records.
    public BookRecordBean(String category, String title, String author, String description, String theme) {
        this.category = category;
        this.title = title;
        this.author = author;
        this.description = description;
        this.theme = theme;
    }

    // Standard getters and setters expose the bean properties to JSP.
    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }
}

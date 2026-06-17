package module5and6;

import java.io.Serializable;

/*
 Name: Matthew Rozendaal
 Date: 2026-06-16
 Assignment: Module 5 and 6 - Library JavaBean
 Purpose: Hold one Library book record for JSP display.
 */
public class LibraryBookBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String summary;
    private String author;
    private String genre;
    private boolean checkedOut;
    private String lastCheckedOut;
    private String condition;
    private String isbn;

    public LibraryBookBean() {
    }

    public LibraryBookBean(int id, String name, String summary, String author, String genre, boolean checkedOut, String lastCheckedOut, String condition, String isbn) {
        this.id = id;
        this.name = name;
        this.summary = summary;
        this.author = author;
        this.genre = genre;
        this.checkedOut = checkedOut;
        this.lastCheckedOut = lastCheckedOut;
        this.condition = condition;
        this.isbn = isbn;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public boolean isCheckedOut() {
        return checkedOut;
    }

    public void setCheckedOut(boolean checkedOut) {
        this.checkedOut = checkedOut;
    }

    public String getLastCheckedOut() {
        return lastCheckedOut;
    }

    public void setLastCheckedOut(String lastCheckedOut) {
        this.lastCheckedOut = lastCheckedOut;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
}

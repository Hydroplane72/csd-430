package beans;

import java.io.Serializable;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

/*
 Name: Matthew Rozendaal
 Date: 2026-07-08
 Assignment: Module 9 - Library Record Bean
 Purpose: Hold one Library book record and run database CRUD operations for JSP display.
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

    public int insertRecord() throws SQLException {
        String insertSql = "INSERT INTO matthew_library_data (Name, Summary, Author, Genre, IsCheckedOut, LastCheckedOut, `Condition`, ISBN) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (java.sql.Connection connection = LibraryDbConfig.getConnection(); PreparedStatement insertStatement = connection.prepareStatement(insertSql)) {

            insertStatement.setString(1, getName());
            insertStatement.setString(2, getSummary());
            insertStatement.setString(3, getAuthor());
            insertStatement.setString(4, getGenre());
            insertStatement.setBoolean(5, isCheckedOut());

            if (getLastCheckedOut() == null || getLastCheckedOut().trim().isEmpty()) {
                insertStatement.setNull(6, Types.DATE);
            } else {
                insertStatement.setString(6, getLastCheckedOut());
            }

            insertStatement.setString(7, getCondition());
            insertStatement.setString(8, getIsbn());

            return insertStatement.executeUpdate();
        }
    }

    public int updateRecord() throws SQLException {
        String updateSql = "UPDATE matthew_library_data SET Name = ?, Summary = ?, Author = ?, Genre = ?, IsCheckedOut = ?, LastCheckedOut = ?, `Condition` = ?, ISBN = ? WHERE ID = ?";

        try (java.sql.Connection connection = LibraryDbConfig.getConnection(); PreparedStatement updateStatement = connection.prepareStatement(updateSql)) {

            updateStatement.setString(1, getName());
            updateStatement.setString(2, getSummary());
            updateStatement.setString(3, getAuthor());
            updateStatement.setString(4, getGenre());
            updateStatement.setBoolean(5, isCheckedOut());

            if (getLastCheckedOut() == null || getLastCheckedOut().trim().isEmpty()) {
                updateStatement.setNull(6, Types.DATE);
            } else {
                updateStatement.setString(6, getLastCheckedOut());
            }

            updateStatement.setString(7, getCondition());
            updateStatement.setString(8, getIsbn());
            updateStatement.setInt(9, getId());

            return updateStatement.executeUpdate();
        }
    }

    public int deleteRecord() throws SQLException {
        String deleteSql = "DELETE FROM matthew_library_data WHERE ID = ?";

        try (java.sql.Connection connection = LibraryDbConfig.getConnection(); PreparedStatement deleteStatement = connection.prepareStatement(deleteSql)) {
            deleteStatement.setInt(1, getId());
            return deleteStatement.executeUpdate();
        }
    }

    public List<LibraryBookBean> getAllRecords() throws SQLException {
        List<LibraryBookBean> records = new ArrayList<>();
        String selectSql = "SELECT ID, Name, Summary, Author, Genre, IsCheckedOut, LastCheckedOut, `Condition`, ISBN FROM matthew_library_data ORDER BY ID";

        try (java.sql.Connection connection = LibraryDbConfig.getConnection(); PreparedStatement statement = connection.prepareStatement(selectSql); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                LibraryBookBean book = new LibraryBookBean();
                book.setId(resultSet.getInt("ID"));
                book.setName(resultSet.getString("Name"));
                book.setSummary(resultSet.getString("Summary"));
                book.setAuthor(resultSet.getString("Author"));
                book.setGenre(resultSet.getString("Genre"));
                book.setCheckedOut(resultSet.getBoolean("IsCheckedOut"));
                book.setLastCheckedOut(resultSet.getString("LastCheckedOut"));
                book.setCondition(resultSet.getString("Condition"));
                book.setIsbn(resultSet.getString("ISBN"));
                records.add(book);
            }
        }

        return records;
    }

    public LibraryBookBean getRecordById(int recordId) throws SQLException {
        String selectByIdSql = "SELECT ID, Name, Summary, Author, Genre, IsCheckedOut, LastCheckedOut, `Condition`, ISBN FROM matthew_library_data WHERE ID = ?";

        try (java.sql.Connection connection = LibraryDbConfig.getConnection(); PreparedStatement statement = connection.prepareStatement(selectByIdSql)) {
            statement.setInt(1, recordId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    LibraryBookBean book = new LibraryBookBean();
                    book.setId(resultSet.getInt("ID"));
                    book.setName(resultSet.getString("Name"));
                    book.setSummary(resultSet.getString("Summary"));
                    book.setAuthor(resultSet.getString("Author"));
                    book.setGenre(resultSet.getString("Genre"));
                    book.setCheckedOut(resultSet.getBoolean("IsCheckedOut"));
                    book.setLastCheckedOut(resultSet.getString("LastCheckedOut"));
                    book.setCondition(resultSet.getString("Condition"));
                    book.setIsbn(resultSet.getString("ISBN"));
                    return book;
                }
            }
        }

        return null;
    }
}

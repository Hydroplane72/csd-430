-- Name: Matthew Rozendaal
-- Date: 2026-06-16
-- Assignment: Module 5 and 6 - Library Table Creation
-- Purpose: Create the Library table used to store book records.

USE CSD430;

CREATE TABLE IF NOT EXISTS matthew_library_data (
    ID INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Summary VARCHAR(255) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Genre VARCHAR(50) NOT NULL,
    IsCheckedOut BOOLEAN NOT NULL,
    LastCheckedOut DATE NULL,
    `Condition` VARCHAR(20) NOT NULL,
    ISBN VARCHAR(20) NOT NULL,
    PRIMARY KEY (ID),
    UNIQUE KEY uk_matthew_library_data_isbn (ISBN)
);
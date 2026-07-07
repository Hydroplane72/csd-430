-- Name: Matthew Rozendaal
-- Date: 2026-06-16
-- Assignment: Module 5 and 6 - Library Database Setup
-- Purpose: Create the CSD430 database for the Library assignment.

CREATE DATABASE IF NOT EXISTS CSD430;
USE CSD430;

CREATE USER IF NOT EXISTS 'student1'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost';
FLUSH PRIVILEGES;
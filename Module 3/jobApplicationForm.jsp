<%--
Name: Matthew Rozendaal
Date: 2026-06-11
Assignment: Module 3 - Job Application Form
Purpose: Collect job application details and submit them to a separate JSP page.
Source Credit: Data inputs, form structure, and general layout thought of by me.
                AI was used to help with general HTML structure and CSS styling (GitHub Copilot).
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Compute the default and maximum DOB values so applicants must be at least 18 years old.
    java.time.LocalDate today = java.time.LocalDate.now();
    java.time.LocalDate eighteenYearsAgo = today.minusYears(18);
    String dobMaxAndDefault = eighteenYearsAgo.toString();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Job Application Form</title>
    <link rel="stylesheet" href="jobApplication.css" />
</head>
<body>
<!-- Main page container for the job application form. -->
<div class="container form-container">
    <h1>Job Application Form</h1>
    <p class="description">
        Complete the fields below to submit a sample job application. This form gathers personal details,
        eligibility information, and background experience that will be displayed on the results page.
    </p>

    <!-- Form submits application data to the separate JSP results page using POST. -->
    <form action="displayJobApplication.jsp" method="post">
        <!-- Applicant first name input field. -->
        <div class="field-group">
            <label for="firstName">First Name</label>
            <input type="text" id="firstName" name="firstName" required maxlength="50" />
            <p class="field-help">Enter your legal first name (up to 50 characters).</p>
        </div>

        <!-- Applicant last name input field. -->
        <div class="field-group">
            <label for="lastName">Last Name</label>
            <input type="text" id="lastName" name="lastName" required maxlength="50" />
            <p class="field-help">Enter your legal last name (up to 50 characters).</p>
        </div>

        <!-- Gender selection dropdown. -->
        <div class="field-group">
            <label for="gender">Gender</label>
            <select id="gender" name="gender" required>
                <option value="">-- Select Gender --</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Prefer not to say">Prefer not to say</option>
            </select>
            <p class="field-help">Select the option you are most comfortable sharing.</p>
        </div>

        <!-- Date picker constrained to dates at least 18 years in the past. -->
        <div class="field-group">
            <label for="dateOfBirth">Date of Birth</label>
            <input type="date" id="dateOfBirth" name="dateOfBirth" required value="<%= dobMaxAndDefault %>" max="<%= dobMaxAndDefault %>" />
            <p class="field-help">Default is set to 18 years ago, and newer dates are blocked.</p>
        </div>

        <!-- Numeric input for years of professional experience. -->
        <div class="field-group">
            <label for="yearsExperience">Years of Professional Experience</label>
            <input type="number" id="yearsExperience" name="yearsExperience" required min="0" max="80" step="1" />
            <p class="field-help">Enter a whole number from 0 to 80.</p>
        </div>

        <!-- Free-text area for one or more job titles. -->
        <div class="field-group">
            <label for="jobTitles">Job Titles</label>
            <textarea id="jobTitles" name="jobTitles" required placeholder="Enter one or more job titles, separated by commas or new lines."></textarea>
            <p class="field-help">Example: Software Developer, Team Lead, Project Coordinator.</p>
        </div>

        <!-- Submit button for sending form data. -->
        <div class="actions">
            <button type="submit">Submit Application</button>
        </div>
    </form>

    <p class="note">
        Note: This page is implemented as JSP and submits via HTTP POST to a separate JSP page for display.
    </p>
</div>
</body>
</html>

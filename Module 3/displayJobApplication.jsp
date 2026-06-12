<%--
Name: Matthew Rozendaal
Date: 2026-06-11
Assignment: Module 3 - Job Application Display
Purpose: Receive and display submitted job application data in a descriptive table.
Source Credit: Data inputs, form structure, and general layout thought of by me.
                AI was used to help with general HTML structure and CSS styling (GitHub Copilot).
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Read request method so we can detect direct page visits vs. form submission.
    String method = request.getMethod();

    // Read each form field from the POST request.
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String gender = request.getParameter("gender");
    String dateOfBirth = request.getParameter("dateOfBirth");
    String yearsExperience = request.getParameter("yearsExperience");
    String jobTitles = request.getParameter("jobTitles");

    // Replace null values with empty strings to avoid rendering "null" in the table.
    if (firstName == null) { firstName = ""; }
    if (lastName == null) { lastName = ""; }
    if (gender == null) { gender = ""; }
    if (dateOfBirth == null) { dateOfBirth = ""; }
    if (yearsExperience == null) { yearsExperience = ""; }
    if (jobTitles == null) { jobTitles = ""; }

    // Escape special HTML characters before displaying user-submitted values.
    firstName = firstName.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    lastName = lastName.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    gender = gender.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    dateOfBirth = dateOfBirth.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    yearsExperience = yearsExperience.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    jobTitles = jobTitles.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");

    // Preserve line breaks from the textarea when rendering in HTML.
    jobTitles = jobTitles.replace("\r\n", "<br />").replace("\n", "<br />");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Submitted Job Application</title>
    <link rel="stylesheet" href="jobApplication.css" />
</head>
<body>
<!-- Main page container for displaying submitted application data. -->
<div class="container">
    <h1>Submitted Job Application Data</h1>
    <p class="description">
        This page receives and displays the submitted job application using JSP request handling.
        The table below provides each field label, a short description, and the applicant's submitted value.
    </p>

    <!-- Show a warning when this page is opened directly without a POST submission. -->
    <% if (!"POST".equalsIgnoreCase(method)) { %>
        <div class="warning">
            This page is designed to display data submitted through the form using POST.
            Some values may be blank because no form submission was detected.
        </div>
    <% } %>

    <!-- Display all submitted values in a structured table with labels and descriptions. -->
    <table>
        <thead>
        <tr>
            <th>Field</th>
            <th>Field Description</th>
            <th>Submitted Value</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>First Name</td>
            <td>Applicant's legal first name.</td>
            <td><%= firstName %></td>
        </tr>
        <tr>
            <td>Last Name</td>
            <td>Applicant's legal last name.</td>
            <td><%= lastName %></td>
        </tr>
        <tr>
            <td>Gender</td>
            <td>Selected gender identity option.</td>
            <td><%= gender %></td>
        </tr>
        <tr>
            <td>Date of Birth</td>
            <td>Date value from the date picker (minimum age requirement was 18 years).</td>
            <td><%= dateOfBirth %></td>
        </tr>
        <tr>
            <td>Years of Professional Experience</td>
            <td>Total full years of professional work experience.</td>
            <td><%= yearsExperience %></td>
        </tr>
        <tr>
            <td>Job Titles</td>
            <td>One or more job titles entered by the applicant.</td>
            <td><%= jobTitles %></td>
        </tr>
        </tbody>
    </table>

    <p class="meta">
        Overall Data Description: This dataset represents a basic job application profile that includes
        identity details, age eligibility, work experience, and prior role history.
    </p>

    <p class="meta">
        <a href="jobApplicationForm.jsp">Return to Job Application Form</a>
    </p>
</div>
</body>
</html>

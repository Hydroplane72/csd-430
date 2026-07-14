# JSP File Uploading

## What does file uploading look like with JSP
Uploading files in JSP requires you to use servlets to do the work. JSP itself is **not** designed to handle JSP files. Attempting to do so and succeeding would make me question how maintainable your code would be in the final JSP file. In other words, don't try to handle the entire file upload process using only JSP.

The concept of JSP not handling file uploads itself is not limited to JSP. For instance, you are unlikely to use JavaScript to process file uploads and save them directly to the server. You could have JavaScript send a file to an endpoint that saves it to the server. But saving directly from the client's machine to the server machine is generally considered a very bad idea.


## How does one do this?
In general, the flow of file processing will follow this:
1. JSP will display the upload form
2. The browser will send a multipart/form-data POST request.
3. The Servlet will receive the file using code similar to ``` request.getPart("file") ```
4. The servlet will then write the file to the disk. 


In most modern enterprise-level solutions (including non-Java), instead of just writing the file to a private repository/database. You will upload to something like blob storage, then save the blob storage URL in the database as a reference to the uploaded file. (This helps protect the system from malicious file uploads.)

## Why is this important to know?
This is important for us to know because, at some point in your careers, you will need to handle files in one way or another. I would be incredibly shocked if you could go your entire career as a software developer without ever needing to deal with files at least once.
-- Name: Matthew Rozendaal
-- Date: 2026-06-16
-- Assignment: Module 5 and 6 - Library Table Population
-- Purpose: Insert sample Library book records into the table.

USE CSD430;

INSERT INTO matthew_library_data (ID, Name, Summary, Author, Genre, IsCheckedOut, LastCheckedOut, `Condition`, ISBN) VALUES
(1, 'Stormbreaker', 'Alex Rider is pulled into his first high-stakes spy mission.', 'Anthony Horowitz', 'Adventure', FALSE, NULL, 'Good', '978-0-14-240612-9'),
(2, 'Point Blank', 'Alex Rider is sent undercover to a dangerous academy.', 'Anthony Horowitz', 'Adventure', TRUE, '2026-06-01', 'Fair', '978-0-14-240613-6'),
(3, 'Sorcerer''s Stone', 'Harry discovers a hidden world of magic and friendship.', 'J.K. Rowling', 'Fantasy', FALSE, NULL, 'Excellent', '978-0-439-70818-8'),
(4, 'Chamber of Secrets', 'A mystery at Hogwarts puts students and secrets at risk.', 'J.K. Rowling', 'Fantasy', TRUE, '2026-05-29', 'Good', '978-0-439-06487-3'),
(5, 'Eragon', 'A farm boy finds a dragon egg and a destiny of his own.', 'Christopher Paolini', 'Fantasy', FALSE, NULL, 'Very Good', '978-0-375-82824-8'),
(6, 'Eldest', 'Eragon continues his training while danger spreads.', 'Christopher Paolini', 'Fantasy', FALSE, NULL, 'Good', '978-0-375-84006-6'),
(7, 'Tiger''s Curse', 'A curse and a tiger set off a quest through legend.', 'Colleen Houck', 'Fantasy', TRUE, '2026-06-11', 'Fair', '978-0-307-59293-2'),
(8, 'Tiger''s Quest', 'A dangerous journey uncovers more of the ancient curse.', 'Colleen Houck', 'Fantasy', FALSE, NULL, 'Excellent', '978-0-307-59294-9'),
(9, 'The Fellowship of the Ring', 'A fellowship forms to protect the ring and begin the quest.', 'J.R.R. Tolkien', 'Fantasy', TRUE, '2026-06-12', 'Good', '978-0-618-00222-8'),
(10, 'The Book with No Pictures', 'Every word is designed to be playful, loud, and silly.', 'B.J. Novak', 'Children', FALSE, NULL, 'Very Good', '978-0-698-15069-9');
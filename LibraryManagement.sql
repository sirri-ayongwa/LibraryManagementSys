-- Drop the existing database if it exists
DROP DATABASE IF EXISTS LibraryManagement;

-- Create the database
CREATE DATABASE LibraryManagement;

-- Use the new database
USE LibraryManagement;

-- Create table for authors
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Country VARCHAR(50)
);

-- Create table for books
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    AuthorID INT,
    PublishedYear INT,
    Genre VARCHAR(50),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

-- Create table for members
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    MembershipDate DATE
);

-- Create table for loans
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- Insert sample data into Authors table
INSERT INTO Authors (Name, Country) VALUES ('Ellen Ullman', 'US');
INSERT INTO Authors (Name, Country) VALUES ('Neil Postman', 'US');
INSERT INTO Authors (Name, Country) VALUES ('Anna Weiner', 'US');
INSERT INTO Authors (Name, Country) VALUES ('Andy Greenberg', 'US');
INSERT INTO Authors (Name, Country) VALUES ('Janet Murray', 'US');
INSERT INTO Authors (Name, Country) VALUES ('Mike Isaac', 'US');
INSERT INTO Authors (Name, Country) VALUES ('Claire Evans', 'US');
INSERT INTO Authors (Name, Country) VALUES ('Kate Losse', 'US');
INSERT INTO Authors (Name, Country) VALUES ('Lewis Hyde', 'US');
INSERT INTO Authors (Name, Country) VALUES ('Mark Bergen', 'US');

-- Insert sample data into Books table
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES ('Close to the Machine: Technophilia and Its Discontents', 1, 2012, 'Tech');
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES ('Technopoly: The Surrender of Culture to Technology', 2, 1993, 'Tech');
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES ('Uncanny Valley', 3, 2021, 'Tech');
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES ('This Machine Kills Secrets: Julian Assange, the Cypherpunks, and Their Fight to Empower Whistleblowers', 4, 2012, 'Tech');
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES ('Hamlet on the Holodeck: The Future of Narrative in Cyberspace', 5, 2017, 'Tech');
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES ('Super Pumped: The Battle for Uber', 6, 2020, 'Tech');
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES ('Broad Band: The Untold Story of the Women Who Made the Internet', 7, 2020, 'Tech');
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES ('The Boy Kings: A Journey into the Heart of the Social Network', 8, 2014, 'Tech');
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES ('Common as Air: Revolution, Art, and Ownership', 9, 2011, 'Tech');
INSERT INTO Books (Title, AuthorID, PublishedYear, Genre) VALUES ('Like, Comment, Subscribe: Inside YouTube’s Chaotic Rise to World Domination', 10, 2022, 'Tech');

-- Insert sample data into Members table
INSERT INTO Members (Name, Email, MembershipDate) VALUES ('Sirri Ayongwa', 'sirri@gmail.com', '2024-01-01');
INSERT INTO Members (Name, Email, MembershipDate) VALUES ('Sylvia Berg', 'sylvia@gmail.com', '2024-02-15');
INSERT INTO Members (Name, Email, MembershipDate) VALUES ('Owen Mark', 'owen@gmail.com', '2024-02-17');
INSERT INTO Members (Name, Email, MembershipDate) VALUES ('Luke Eren', 'luke@gmail.com', '2024-02-19');
INSERT INTO Members (Name, Email, MembershipDate) VALUES ('Jane Lola', 'jane@gmail.com', '2024-02-21');

-- Insert sample data into Loans table
INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate) VALUES (1, 2, '2024-03-01', '2024-03-15');
INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate) VALUES (3, 1, '2024-03-10', '2024-03-24');
INSERT INTO Loans (BookID, MemberID, LoanDate, ReturnDate) VALUES (7, 4, '2024-03-15', '2024-03-29');

-- Sample query: Get all books with author names
SELECT Books.Title, Authors.Name AS Author, Books.PublishedYear, Books.Genre
FROM Books
JOIN Authors ON Books.AuthorID = Authors.AuthorID;

-- Sample query: Get all books loaned by a specific member
SELECT Books.Title, Members.Name AS Member, Loans.LoanDate, Loans.ReturnDate
FROM Loans
JOIN Books ON Loans.BookID = Books.BookID
JOIN Members ON Loans.MemberID = Members.MemberID
WHERE Members.Name = 'Sirri Ayongwa';

-- Sample query: Get all books that are currently loaned out
SELECT Books.Title, Members.Name AS Member, Loans.LoanDate, Loans.ReturnDate
FROM Loans
JOIN Books ON Loans.BookID = Books.BookID
JOIN Members ON Loans.MemberID = Members.MemberID
WHERE Loans.ReturnDate IS NULL OR Loans.ReturnDate > CURDATE();

-- Sample query: Get all members who have loaned a specific book
SELECT Members.Name, Books.Title, Loans.LoanDate, Loans.ReturnDate
FROM Loans
JOIN Members ON Loans.MemberID = Members.MemberID
JOIN Books ON Loans.BookID = Books.BookID
WHERE Books.Title = 'Uncanny Valley';

-- Query to get members that loaned a book detailes and loan date
SELECT 
    Members.Name AS Member,
    Books.Title AS BookTitle,
    Authors.Name AS Author,
    Books.PublishedYear,
    Books.Genre,
    Loans.LoanDate,
    Loans.ReturnDate
FROM 
    Loans
JOIN 
    Books ON Loans.BookID = Books.BookID
JOIN 
    Authors ON Books.AuthorID = Authors.AuthorID
JOIN 
    Members ON Loans.MemberID = Members.MemberID;

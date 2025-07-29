-- EXPERIMENT : 1

-- Q1: Easy Level
CREATE TABLE Authors_tbl (
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100),
    Country VARCHAR(100)
);

CREATE TABLE Books_tbl (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    AuthorID INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors_tbl(AuthorID)
);

INSERT INTO Authors_tbl (AuthorID, AuthorName, Country)
VALUES
(1, 'J.K. Rowling', 'United Kingdom'),
(2, 'George R.R. Martin', 'United States'),
(3, 'Haruki Murakami', 'Japan');

INSERT INTO Books_tbl (BookID, Title, AuthorID)
VALUES
(101, 'Harry Potter', 1),
(102, 'Game of Thrones', 2),
(103, 'Norwegian Wood', 3);

SELECT 
    B.Title AS BookTitle,
    A.AuthorName,
    A.Country
FROM 
    Books_tbl B
INNER JOIN 
    Authors_tbl A ON B.AuthorID = A.AuthorID;

-- Q2: Medium Level
CREATE TABLE Departments_tbl (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL
);

CREATE TABLE Courses_tbl (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Departments_tbl(DeptID)
);

INSERT INTO Departments_tbl (DeptID, DeptName) VALUES
(1, 'Computer Science'),
(2, 'Mechanical Engineering'),
(3, 'Electrical Engineering'),
(4, 'Mathematics'),
(5, 'Physics');

INSERT INTO Courses_tbl (CourseID, CourseName, DeptID) VALUES
(101, 'ADMS', 1),
(102, 'DSA', 1),
(103, 'Operating Systems', 1),
(104, 'Thermodynamics', 2),
(105, 'Computer Network', 2),
(106, 'Robotics', 3),
(107, 'Signals and Systems', 3),
(108, 'Machine Learning', 4),
(109, 'Quantum Mechanics', 5),
(110, 'Computer Graphics', 5);

SELECT DeptName
FROM Departments_tbl
WHERE DeptID IN (
    SELECT DeptID
    FROM Courses_tbl
    GROUP BY DeptID
    HAVING COUNT(*) > 2
);

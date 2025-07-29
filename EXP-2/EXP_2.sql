-- EXPERIMENT: 2

-- Ques_1
CREATE TABLE Employee_data (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    ManagerID INT NULL
);

ALTER TABLE Employee_data
ADD CONSTRAINT FK_Manager_data FOREIGN KEY (ManagerID) REFERENCES Employee_data(EmpID);

INSERT INTO Employee_data (EmpID, EmpName, Department, ManagerID)
VALUES
(1, 'Alice', 'HR', NULL),       
(2, 'Bob', 'Finance', 1),
(3, 'Charlie', 'IT', 1),
(4, 'David', 'Finance', 2),
(5, 'Eve', 'IT', 3),
(6, 'Frank', 'HR', 1);

SELECT 
    E.EmpName AS EmployeeName,
    E.Department AS EmployeeDept,
    M.EmpName AS ManagerName,
    M.Department AS ManagerDept
FROM 
    Employee_data E
LEFT JOIN 
    Employee_data M 
ON 
    E.ManagerID = M.EmpID;

-- Ques_2 
CREATE TABLE Year_info (
    id INT,
    year INT,
    NPV INT
);

INSERT INTO Year_info (id, year, NPV)
VALUES
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

CREATE TABLE Queries_info (
    id INT,
    year INT
);

INSERT INTO Queries_info (id, year)
VALUES
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

SELECT 
    Q.id AS ID,
    Q.year AS Year,
    ISNULL(Y.NPV, 0) AS NPV
FROM 
    Queries_info AS Q
LEFT OUTER JOIN 
    Year_info AS Y
ON 
    Q.id = Y.id AND Q.year = Y.year;

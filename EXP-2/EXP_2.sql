-- EXPERIMENT: 2

-- Ques_1
CREATE TABLE Staff_tbl (
    StaffID INT PRIMARY KEY,
    StaffName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    SupervisorID INT NULL
);

ALTER TABLE Staff_tbl
ADD CONSTRAINT FK_Supervisor FOREIGN KEY (SupervisorID) REFERENCES Staff_tbl(StaffID);

INSERT INTO Staff_tbl (StaffID, StaffName, Department, SupervisorID)
VALUES
(1, 'Alice', 'HR', NULL),       
(2, 'Bob', 'Finance', 1),
(3, 'Charlie', 'IT', 1),
(4, 'David', 'Finance', 2),
(5, 'Eve', 'IT', 3),
(6, 'Frank', 'HR', 1);

SELECT 
    E.StaffName AS EmployeeName,
    E.Department AS EmployeeDept,
    M.StaffName AS ManagerName,
    M.Department AS ManagerDept
FROM 
    Staff_tbl E
LEFT JOIN 
    Staff_tbl M 
ON 
    E.SupervisorID = M.StaffID;

-- Ques_2 
CREATE TABLE YearData_tbl (
    RecordID INT,
    YearVal INT,
    NPV INT
);

INSERT INTO YearData_tbl (RecordID, YearVal, NPV)
VALUES
(1, 2018, 100),
(7, 2020, 30),
(13, 2019, 40),
(1, 2019, 113),
(2, 2008, 121),
(3, 2009, 12),
(11, 2020, 99),
(7, 2019, 0);

CREATE TABLE QueryData_tbl (
    RecordID INT,
    YearVal INT
);

INSERT INTO QueryData_tbl (RecordID, YearVal)
VALUES
(1, 2019),
(2, 2008),
(3, 2009),
(7, 2018),
(7, 2019),
(7, 2020),
(13, 2019);

SELECT 
    Q.RecordID AS ID,
    Q.YearVal AS Year,
    ISNULL(Y.NPV, 0) AS NPV
FROM 
    QueryData_tbl AS Q
LEFT OUTER JOIN 
    YearData_tbl AS Y
ON 
    Q.RecordID = Y.RecordID AND Q.YearVal = Y.YearVal;

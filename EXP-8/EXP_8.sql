------------------------------Experiment 08-------------------------------
---------------------Medium Level Problem-----------------------------
-- Create Students table
CREATE TABLE Students
(
    Id INT PRIMARY KEY,
    Name VARCHAR(50) UNIQUE,
    Age INT,
    Class INT
);

-- Insert sample data
INSERT INTO Students (ID, Name, Age, Class) VALUES
(1, 'Tanisha', 17, 8),
(2, 'Tarun', 16, 4),
(3, 'Diksha', 15, 6),
(4, 'Charu', 16, 7),
(5, 'Kushagra', 17, 8),
(6, 'Kiran', 15, 6);

SELECT * FROM Students;

-------------------------------------------------------------
-- Implicit Transaction (Auto-commit)
-------------------------------------------------------------
-- Each SQL statement commits automatically
UPDATE Students
SET Name = 'XYZ'
WHERE Id = 6;

SELECT * FROM Students;

-------------------------------------------------------------
-- Explicit Transaction with COMMIT
-------------------------------------------------------------
BEGIN TRANSACTION;

UPDATE Students
SET Name = 'Tanisha Sharma'
WHERE Id = 1;

COMMIT;

SELECT * FROM Students;

-------------------------------------------------------------
-- Explicit Transaction with ROLLBACK
-------------------------------------------------------------
BEGIN TRANSACTION;

UPDATE Students
SET Name = 'TEMP'
WHERE Id = 6;

ROLLBACK;

SELECT * FROM Students;

---------------------Hard Level Problem-----------------------------
/*
Design a robust PostgreSQL transaction system for the students table where multiple student 
records are inserted in a single transaction. 

If any insert fails due to invalid data, only that insert should be rolled back while preserving the 
previous successful inserts using savepoints. 

The system should provide clear messages for both successful and failed insertions, ensuring data integrity 
and controlled error handling.

HINT: YOU HAVE TO USE SAVEPOINTS
*/

------SOLUTION--------
-- Create students table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE,
    age INT,
    class INT
);

-------------------------------------------------------------
-- Successful Transaction Scenario
-------------------------------------------------------------
DO $$
BEGIN
    -- Start transaction
    BEGIN
        -- Insert multiple students
        INSERT INTO students(name, age, class)
        VALUES ('Tanisha', 16, 8);

        INSERT INTO students(name, age, class)
        VALUES ('Neha', 17, 8);

        INSERT INTO students(name, age, class)
        VALUES ('Mayank', 19, 9);

        -- If all succeed
        RAISE NOTICE 'Transaction Successfully Done';

    EXCEPTION WHEN OTHERS THEN
        -- If any insert fails
        RAISE NOTICE 'Transaction Failed! Rolling back changes.';
        RAISE;
    END;
END;
$$;

-- View all data
SELECT * FROM students;


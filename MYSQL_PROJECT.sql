-- Create a database named EmployeeManagementDB
CREATE DATABASE IF NOT EXISTS EmployeeManagementDB;

-- Switch to the created database
USE EmployeeManagementDB;

-- Create the Employee table to store employee information
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(15),
    DepartmentID INT,
    JoinDate DATE,
    Salary DECIMAL(10, 2),
    IsActive BOOLEAN
);

-- Insert sample data into the Employee table
INSERT INTO Employee (EmployeeID, FirstName, LastName, Email, PhoneNumber, DepartmentID, JoinDate, Salary, IsActive)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', 101, '2022-01-15', 60000.00, true),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', 102, '2021-12-10', 55000.00, true),
    (3, 'Michael', 'Johnson', 'michael.johnson@example.com', '456-789-0123', 103, '2022-02-20', 62000.00, true),
    (4, 'Emily', 'Brown', 'emily.brown@example.com', '789-012-3456', 101, '2022-03-05', 58000.00, true),
    (5, 'David', 'Lee', 'david.lee@example.com', '321-654-9870', 102, '2021-11-25', 65000.00, true),
    (11, 'Ava', 'Taylor', 'ava.taylor@example.com', '345-678-9012', 104, '2022-07-20', 61000.00, true),
    (12, 'Ethan', 'Clark', 'ethan.clark@example.com', '012-345-6789', 105, '2022-08-05', 57000.00, true),
    (13, 'Mia', 'Rodriguez', 'mia.rodriguez@example.com', '890-123-4567', 104, '2021-12-01', 59000.00, true),
    (14, 'Noah', 'Lopez', 'noah.lopez@example.com', '567-890-1234', 105, '2022-03-15', 63000.00, true),
    (15, 'Isabella', 'Hernandez', 'isabella.hernandez@example.com', '234-567-8901', 104, '2022-06-10', 60000.00, true);

-- Print the created Employee table with sample data
SELECT * FROM Employee;

-- Retrieve employees whose salary is greater than $60,000
SELECT * FROM Employee
WHERE Salary > 60000.00;

-- Retrieve employees who joined after January 1, 2022
SELECT * FROM Employee
WHERE JoinDate > '2022-01-01';

-- Retrieve active employees in the IT department (DepartmentID = 101)
SELECT * FROM Employee
WHERE IsActive = true AND DepartmentID = 101;

-- Retrieve employees whose last name starts with 'S'
SELECT * FROM EMPLOYEE 
WHERE LastName Like 'S%';

-- This line retrieves all employees with salaries between $55,000 and $60,000 (inclusive)
SELECT *
FROM Employee
WHERE Salary BETWEEN 55000.00 AND 60000.00;

-- This query finds employees with salaries NOT between $55,000 and $60,000 (inclusive)
SELECT *
FROM Employee
WHERE Salary NOT BETWEEN 55000.00 AND 60000.00;

-- Retrieve employees whose salary is between $50,000 and $60,000 and are from the Sales department
SELECT * FROM Employee
WHERE Salary BETWEEN 50000.00 AND 60000.00
AND DepartmentID = 101;

-- Retrieve employees who joined after January 1, 2022, or have a salary greater than $60,000
SELECT * FROM Employee
WHERE JoinDate > '2022-01-01'
OR Salary > 60000.00;

-- SORTING DATA (ORDER BY Clause)

 -- Orders the result set by the Salary column in descending order
SELECT * FROM Employee
ORDER BY Salary DESC;

 -- Orders the result set by the Salary column in ascending order 
 SELECT * FROM Employee
ORDER BY Salary ASC;

-- Aggregate functions 

SELECT 
    MIN(Salary) AS MinSalary, -- Calculates the minimum salary value in the Salary column
    MAX(Salary) AS MaxSalary, -- Calculates the maximum salary value in the Salary column
    COUNT(*) AS TotalEmployees, -- Counts the total number of rows in the result set (total employees)
    AVG(Salary) AS AvgSalary -- Calculates the average salary value in the Salary column
FROM Employee;

-- GROUPING DATA (GROUP BY Clause)
SELECT 
    DepartmentID, 
    AVG(Salary) AS AvgSalary -- Calculates the average salary for each department
FROM Employee
GROUP BY DepartmentID; 

SELECT 
    DepartmentID, -- Specifies the column to group by
    SUM(Salary) AS TotalSalary -- Calculates the total salary for each department
FROM Employee
GROUP BY DepartmentID; -- Groups the result set by the DepartmentID column

-- JOINING TABLES (INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN)

-- Create Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    ProjectManager VARCHAR(100),
    DepartmentID INT,
    StartDate DATE,
    EndDate DATE
);

-- Insert sample data into Projects table
INSERT INTO Projects (ProjectID, ProjectName, ProjectManager, DepartmentID, StartDate, EndDate)
VALUES
    (1, 'Website Redesign', 'Emily Johnson', 101, '2022-01-15', '2022-06-30'),
    (2, 'Product Launch', 'Michael Smith', 103, '2022-03-01', '2022-09-30'),
    (3, 'Marketing Campaign', 'Jessica Brown', 104, '2022-02-15', '2022-08-31'),
    (4, 'Software Development', 'David Wilson', 101, '2022-04-01', '2022-11-30'),
    (5, 'Sales Training', 'Ava Taylor', 103, '2022-05-15', '2022-10-31');

-- Inner join returns only the rows from both tables that have matching values based on the specified join condition.

-- This query selects employee details along with the project they are assigned to using INNER JOIN.
SELECT 
    EmployeeID, FirstName, LastName, ProjectName
FROM 
    Employee AS e
INNER JOIN 
    Projects AS p
    ON e.DepartmentID = p.DepartmentID;

-- Right join: Returns all the rows from the right table (second table mentioned in the query), and the matched rows from the left table (first table mentioned in the query). If there are no matches, NULL values are included for the columns of the left table.
-- Selects employee details along with the project they are assigned to using RIGHT JOIN.
SELECT 
    EmployeeID, FirstName, LastName, ProjectName
FROM 
    Employee AS e
RIGHT JOIN 
    Projects AS p
    ON e.DepartmentID = p.DepartmentID;
    
    

-- Left join syntax retrieves all rows from the left table and matching rows from the right table. 
-- If there are no matches, it includes NULL values for the columns of the right table.

SELECT 
    EmployeeID, FirstName, LastName, ProjectName
FROM 
    Employee AS e
LEFT JOIN 
    Projects AS p 
    ON e.DepartmentID = p.DepartmentID;
    
    -- Full outer join syntax retrieves all rows from both tables. 
-- If there are no matches, it includes NULL values for the columns of the opposite table.

-- Simulating a full outer join using left join, right join, and union
SELECT 
    e.EmployeeID, e.FirstName, e.LastName, p.ProjectName
FROM 
    Employee e
LEFT JOIN 
    Projects p ON e.DepartmentID = p.DepartmentID

UNION

SELECT 
    e.EmployeeID, e.FirstName, e.LastName, p.ProjectName
FROM 
    Employee e
RIGHT JOIN 
    Projects p ON e.DepartmentID = p.DepartmentID;
    
    -- SUBQUERIES
-- A subquery, also known as an inner query or nested query, is a SQL query embedded within another SQL statement. 
-- It allows you to retrieve data based on the results of another query.

SELECT *
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

SELECT *
FROM Employee
WHERE salary > (SELECT MAX(salary) FROM Employee);

SELECT EmployeeID, FirstName, LastName, DepartmentID, JoinDate, Salary
FROM Employee
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE JoinDate < (
        SELECT MIN(JoinDate)
        FROM Employee
        WHERE DepartmentID = (
            SELECT MAX(DepartmentID)
            FROM Employee
        )
    )
);


-- Set Operations (UNION, UNION ALL , EXCEPT)
-- UNION: Combine the results of queries from both tables, removing duplicates

-- Select employees
SELECT EmployeeID, FirstName, LastName, DepartmentID
FROM Employee
UNION
-- Select projects
SELECT ProjectID, ProjectName, ProjectManager, DepartmentID
FROM Projects;

-- UNION ALL: Combines the results of two or more SELECT queries into a single result set, including all rows from each SELECT query.
-- Duplicate rows are not removed.

-- Select employee details
SELECT EmployeeID, FirstName, LastName, DepartmentID
FROM Employee

UNION ALL

-- Select project details
SELECT ProjectID, ProjectName, NULL AS LastName, DepartmentID
FROM Projects;

-- Selecting data from the Employee table
SELECT EmployeeID, FirstName, LastName, DepartmentID
FROM Employee

UNION ALL

-- Selecting data from the Projects table
SELECT ProjectID, ProjectName, ProjectManager, DepartmentID
FROM Projects;

-- VIEWS
-- A view in SQL is a virtual table created by a query.
-- It stores the result set of a SELECT statement, allowing users to query it like a regular table without altering the underlying data.

CREATE VIEW ProjectsView AS
SELECT ProjectID, ProjectName, ProjectManager, DepartmentID, StartDate, EndDate
FROM Projects;

SELECT * FROM ProjectsView;

-- INDEXES

-- An index in SQL is a structure that improves the speed of data retrieval by storing a sorted list of key values and their corresponding locations in the database.

CREATE INDEX idx_employee_department ON Employee(DepartmentID);

CREATE INDEX idx_projects_department ON Projects(DepartmentID);


-- WINDOW FUNCTIONS
-- RANK Function:Assigns a unique rank to each row based on the specified order (in this case, descending order of salary). Rows with the same value receive the same rank, and the next rank is skipped.

SELECT EmployeeID, FirstName, LastName, 
       RANK() OVER (ORDER BY Salary DESC) AS Rank_OF_EMPLOYEES
FROM Employee;

-- DENSE_RANK Function:Assigns a unique rank to each row based on the specified order (in this case, descending order of salary). Rows with the same value receive the same rank, and the next rank is not skipped.

SELECT EmployeeID, FirstName, LastName, 
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS DenseRank
FROM Employee;

-- ROW_NUMBER Function:Assigns a unique sequential integer to each row, starting from 1, based on the specified order (in this case, descending order of salary).

SELECT *, 
       ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNumber
FROM Employee;


-- TEMPORARY TABLE
-- TEMPORARY TABLE: A temporary table is a table that exists temporarily and is only accessible within the session in which it was created.

-- Create a temporary table to store product information
CREATE TEMPORARY TABLE temp_products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Insert some data into the temporary table
INSERT INTO temp_products (product_id, product_name, category, price)
VALUES
    (1, 'Smartphone', 'Electronics', 599.99),
    (2, 'Laptop', 'Electronics', 999.99),
    (3, 'Headphones', 'Electronics', 99.99),
    (4, 'T-shirt', 'Apparel', 19.99),
    (5, 'Jeans', 'Apparel', 39.99);

-- Select data from the temporary table
SELECT * FROM temp_products;


-- DISTINCT keyword: Used in SQL queries to retrieve unique rows from a result set by eliminating duplicate values.

SELECT  FirstName, LastName
FROM Employee;

SELECT DISTINCT FirstName, LastName
FROM Employee;


-- Create a new table with a default constraint
CREATE TABLE Products_data (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50) DEFAULT 'Uncategorized',  -- Default constraint
    Price DECIMAL(10, 2),
    Quantity INT
);

-- Insert sample data with some duplicates
INSERT INTO Products_data (ProductID, ProductName, Price, Quantity)
VALUES
    (1, 'Laptop', 1200.00, 10),
    (2, 'Smartphone', 800.00, 15),
    (3, 'Keyboard', 50.00, 20),
    (4, 'Laptop', 1200.00, 10),  -- Duplicate
    (5, 'Printer', 200.00, 5),
    (6, 'Chair', 150.00, 30),
    (7, 'Table', 250.00, 15),
    (8, 'Sofa', 500.00, 8),
    (9, 'Chair', 150.00, 30);     -- Duplicate

-- Retrieve data from the table
SELECT * FROM Products_data;

SELECT DISTINCT ProductName FROM Products_data;


-- CASE :The CASE statement in SQL is a conditional expression used to perform different actions based on different conditions
SELECT 
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    CASE 
        WHEN Salary >= 60000 THEN 'High Salary'
        WHEN Salary >= 50000 AND Salary < 60000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS Salary_Category
FROM 
    Employee;
    
-- ADDIG A NEW COLUMN TO AN EXISTING EMPLOYEE TALE

    SET SQL_SAFE_UPDATES=0;
    
    -- Step 1: Add a new column to the table
ALTER TABLE Employee
ADD COLUMN Salary_Category VARCHAR(20);

-- Step 2: Update the new column using a CASE statement
UPDATE Employee
SET Salary_Category =
    CASE 
        WHEN Salary >= 60000 THEN 'High Salary'
        WHEN Salary >= 50000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END;
    
    SELECT * FROM EMPLOYEE;
    
-- MODIFY COLUMN:The MODIFY COLUMN statement in SQL is used within the ALTER TABLE command to alter the definition of an existing column in a table. It allows you to change the data type or constraints of a column.
    
ALTER TABLE Employee
MODIFY COLUMN IsActive VARCHAR(5);

-- CHANGING COLUMN NAME BY USING ALTER COMMAND.

ALTER TABLE Employee
CHANGE COLUMN Email Email_com VARCHAR(100);

SELECT * FROM EMPLOYEE;

-- CHANGING TABLE NAME.

ALTER TABLE Employee
RENAME TO Employee_data;

SELECT * FROM Employee_data;

-- DROPING COLUMNN FROM EMPLOYEE_DATA TABLE.

ALTER TABLE Employee_data
DROP COLUMN IsActive;

SELECT * FROM Employee_data;

-- To delete a specific row from a table in MySQL, you can use the DELETE statement with a WHERE clause that specifies the 

DELETE FROM Employee_data
WHERE EmployeeID = 5;

-- TRUNCATE TABLE
-- The TRUNCATE TABLE statement is used in SQL to remove all rows from a table efficiently. Unlike the DELETE statement, which removes rows one by one and can be rolled back, TRUNCATE TABLE is a faster operation and cannot be rolled back.

TRUNCATE TABLE Employee;

-- REMOVING AN EXISTING DATABASE.

DROP DATABASE employeemanagementdb ;
















    
    
    
    




    
    























    


    


















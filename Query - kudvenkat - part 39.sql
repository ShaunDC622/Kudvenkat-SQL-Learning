-- Views in SQL Server
-----------------------------------------------------------------------------------------
-- A view is a saved SQL query; it can also be considered as a virtual table.
CREATE TABLE tblDepartment1
(
 DeptID INT PRIMARY KEY,
 DeptName NVARCHAR(20)
)

INSERT INTO tblDepartment1 VALUES (1,'IT')
INSERT INTO tblDepartment1 VALUES (2,'Payroll')
INSERT INTO tblDepartment1 VALUES (3,'HR')
INSERT INTO tblDepartment1 VALUES (4,'Admin')

SELECT * FROM tblDepartment1
-----------------------------------------------------------------------------------------
CREATE TABLE tblEmployee5
(
 ID INT PRIMARY KEY,
 Name NVARCHAR(30),
 Salary INT,
 Gender NVARCHAR(10),
 DepartmentID INT
)

INSERT INTO tblEmployee5 VALUES (1,'John', 5000, 'Male', 3)
INSERT INTO tblEmployee5 VALUES (2,'Mike', 3400, 'Male', 2)
INSERT INTO tblEmployee5 VALUES (3,'Pam', 6000, 'Female', 1)
INSERT INTO tblEmployee5 VALUES (4,'Todd', 4800, 'Male', 4)
INSERT INTO tblEmployee5 VALUES (5,'Sara', 3200, 'Female', 1)
INSERT INTO tblEmployee5 VALUES (6,'Ben', 4800, 'Male', 3)

SELECT * FROM tblEmployee5
-----------------------------------------------------------------------------------------
SELECT ID, Name, Salary, Gender, DeptName
FROM tblEmployee5 AS E
LEFT JOIN tblDepartment1 AS D
ON E.DepartmentID = D.DeptID
-- *This has to be executed every time we want to see this joined table, but what if 
--  we can execute something that does require this setup each time? This is when 
--  we use views!
-----------------------------------------------------------------------------------------
CREATE VIEW vWEmployeesByDepartment AS
SELECT ID, Name, Salary, Gender, DeptName
FROM tblEmployee5 AS E
LEFT JOIN tblDepartment1 AS D
ON E.DepartmentID = D.DeptID
-----------------------------------------------------------------------------------------
SELECT * FROM vWEmployeesByDepartment
-- I can imagine views are created and used very often in the work environment :)
-----------------------------------------------------------------------------------------
sp_helptext vWEmployeesByDepartment
-- *A select query is stored when creating a view, not actually data, hence why views are
--  considered virtual tables and not actual tables.
-----------------------------------------------------------------------------------------
-- Advantages of views
-----------------------------------------------------------------------------------------
-- 1. Views can reduce the complexity of the database schema
--    Example of this is seen above
-----------------------------------------------------------------------------------------
-- 2. Views can be used as a mechanism to implement row and column level security
--    An example of this is below; it is for row-level security:
CREATE VIEW vWITEmployees AS
SELECT ID, Name, Salary, Gender, DeptName
FROM tblEmployee5 AS E
LEFT JOIN tblDepartment1 AS D
ON E.DepartmentID = D.DeptID
WHERE D.DeptName = 'IT'
----------------------------------------------------
SELECT * FROM vWITEmployees
--    Another example of this is below; it is for column-level security:
CREATE VIEW vWNonConfidentialData AS
SELECT ID, Name, Gender, DeptName
FROM tblEmployee5 AS E
LEFT JOIN tblDepartment1 AS D
ON E.DepartmentID = D.DeptID
----------------------------------------------------
SELECT * FROM vWNonConfidentialData
-----------------------------------------------------------------------------------------
-- 3. Views can be used to present aggregated data and hide detailed data
--    An example of this is below:
CREATE VIEW vWSummarisedData AS
SELECT DeptName, COUNT(ID) AS [Total Employees]
FROM tblEmployee5 AS E
LEFT JOIN tblDepartment1 AS D
ON E.DepartmentID = D.DeptID
GROUP BY DeptName
----------------------------------------------------
SELECT * FROM vWSummarisedData
-----------------------------------------------------------------------------------------
-- *To modify a view, you use ALTER view statements
-- *To drop a view, you use DROP view vWName statements
-- View Limitations
------------------------------------------------------------------------------------------
-- 1. You cannot pass parameters to view. Table-Valued functions are a good replacement
--    for parameterised views.
------------------------------------------------------------------------------------------
SELECT * FROM tblEmployee5
-------------------------------------------
CREATE VIEW vWEmployeeDetails
AS
SELECT ID, Name, Gender, DepartmentID
FROM tblEmployee5
-------------------------------------------
SELECT * FROM vWEmployeeDetails
------------------------------------------------------------------------------------------
-- For demonstration, we will try to create a view with a parameter:
CREATE VIEW vWEmployeeDetails1
@Gender NVARCHAR(20)
AS
SELECT ID, Name, Gender, DepartmentID
FROM tblEmployee5
WHERE Gender = @Gender
------------------------------------------------------------------------------------------
-- However, it is possible to filter in a view; an example of this is below:
SELECT * FROM vWEmployeeDetails WHERE Gender = 'Male'
SELECT * FROM vWEmployeeDetails WHERE Gender = 'Female'
------------------------------------------------------------------------------------------
-- We can use Inline Table Valued functions as a replacement for parameterised views:
CREATE FUNCTION fnEmployeeDetails(@Gender NVARCHAR(20))
RETURNS TABLE
AS 
RETURN
(
SELECT ID, Name, Gender, DepartmentID
FROM tblEmployee5
WHERE Gender = @Gender
)
----------------------------------------------------------
SELECT * FROM dbo.fnEmployeeDetails('Male')
-- We call the function the same way we do a view, but with the inclusion of the parameter.
------------------------------------------------------------------------------------------
-- 2. Rules and Defaults cannot be associated with views. Views are virtual tables; 
--    they do not store any data (except for Indexed Views).

-- 3. The ORDER BY clause is invalid in views unless TOP or FOR XML is specified.
------------------------------------------------------------------------------------------
-- For demonstration, let's try to use ORDER BY clause on a view:
ALTER VIEW vWEmployeeDetails
AS
SELECT ID, Name, Gender, DepartmentID
FROM tblEmployee5
ORDER BY ID
-- *We get the error: "The ORDER BY clause is invalid in views, inline functions,
--  derived tables, subqueries, and common table expressions, unless TOP, OFFSET 
--  or FOR XML is also specified."
------------------------------------------------------------------------------------------
-- 4. Views cannot be based on temporary tables.
Create Table ##TestTempTable
(
ID INT,
Name NVARCHAR(20),
Gender NVARCHAR(10)
)

INSERT INTO ##TestTempTable VALUES(101, 'Martin', 'Male')
INSERT INTO ##TestTempTable VALUES(102, 'Joe', 'Female')
INSERT INTO ##TestTempTable VALUES(103, 'Pam', 'Female')
INSERT INTO ##TestTempTable VALUES(104, 'James', 'Male')
------------------------------------------------------------------
SELECT * FROM ##TestTempTable
------------------------------------------------------------------
-- For demonstration, we shall try to create a view on this temp table:
CREATE VIEW vWOnTempTable
AS
SELECT Id, Name, Gender
FROM ##TestTempTable
-- *We get the error: "Views or functions are not allowed on temporary tables. 
--  Table names that begin with '#' denote temporary tables."
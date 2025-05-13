-- Stored Procedures --
SELECT * FROM tblEmployee4

SELECT Name, Gender FROM tblEmployee4
-- We want to create a stored procedure for the query above that calls
-- upon it easily.
--------------------------------------------------------------------
CREATE PROCEDURE spGetEmployees
AS 
BEGIN
    SELECT Name, Gender FROM tblEmployee4
END
--------------------------------------------------------------------
spGetEmployees
-- OR --
EXEC spGetEmployees
-- OR --
EXECUTE spGetEmployees
--------------------------------------------------------------------
CREATE PROCEDURE spGetEmployeesByGenderAndDepartment
@Gender NVARCHAR(20), -- creating first parameter, i.e. placeholders/variables
@DepartmentID INT -- creating second parameter
AS 
BEGIN
    SELECT Name, Gender, DepartmentID 
	FROM tblEmployee4
	WHERE Gender = @Gender AND DepartmentID = @DepartmentID
END
--------------------------------------------------------------------
spGetEmployeesByGenderAndDepartment 'Male',1
-- OR --
spGetEmployeesByGenderAndDepartment @DepartmentID = 1, @Gender = 'Male'
--------------------------------------------------------------------
sp_helptext spGetEmployees 
-- A stored procedure that provides the text for a provided store procedure
-- NB: System stored procedures have the prefix 'sp_', thus it is
-- suggested we do not create our own stored procedures with the same prefix
--------------------------------------------------------------------
-- Altering stored procedures
ALTER PROCEDURE spGetEmployees  
AS   
BEGIN  
    SELECT Name, Gender FROM tblEmployee4
	ORDER BY Name
END
--------------------------------------------------------------------
EXECUTE spGetEmployees
--------------------------------------------------------------------
-- Dropping/deleting stored procedures
DROP PROCEDURE spGetEmployees  
--------------------------------------------------------------------
-- Encrypting stored procedures
ALTER PROCEDURE spGetEmployeesByGenderAndDepartment  
@Gender NVARCHAR(20), -- creating first parameter, i.e. placeholders/variables  
@DepartmentID INT -- creating second parameter
WITH ENCRYPTION
AS   
BEGIN  
    SELECT Name, Gender, DepartmentID   
 FROM tblEmployee4  
 WHERE Gender = @Gender AND DepartmentID = @DepartmentID  
END
-------------------------------------------------------------------------
sp_helptext spGetEmployeesByGenderAndDepartment
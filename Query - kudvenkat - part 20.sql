-- Stored Procedures Output Parameters or Return Values
SELECT * FROM tblEmployee4
--------------------------------------------------------
ALTER PROCEDURE spGetNameByID
@ID INT
AS
BEGIN
    SELECT Name AS 'Employee Name'
	FROM tblEmployee4
	WHERE ID = @ID
END
--------------------------------------------------------
EXECUTE spGetNameByID 3
--------------------------------------------------------
--------------------------------------------------------
-- Using OUTPUT parameters
CREATE PROCEDURE spGetTotalCountofEmployees1
@TotalCount INT OUTPUT
AS
BEGIN
    SELECT @TotalCount = COUNT(ID) FROM tblEmployee4
END
--------------------------------------------------------
DECLARE @TotalEmployees INT
EXECUTE spGetTotalCountofEmployees1 @TotalEmployees OUTPUT
SELECT  @TotalEmployees -- SELECT and PRINT give different output formats
--------------------------------------------------------
--------------------------------------------------------
-- Using RETURN instead of OUTPUT parameters
CREATE PROCEDURE spGetTotalCountofEmployees2
AS
BEGIN
    RETURN (SELECT COUNT(ID) FROM tblEmployee4) 
	-- The brackets are necessary to ensure what was in them is done
	-- first and then it gets returned.
END
--------------------------------------------------------
DECLARE @TotalEmployees INT
EXECUTE @TotalEmployees = spGetTotalCountofEmployees2
PRINT  @TotalEmployees -- I'm using PRINT for demonstration purposes.
--------------------------------------------------------------------------
--------------------------------------------------------------------------
ALTER PROCEDURE spGetNameByID1
@ID INT,
@NAME NVARCHAR(50) OUTPUT
AS
BEGIN
    SELECT @Name = Name -- This part and order is crucial: you are asking 
	                    -- the output to match the result from the Name column 
						-- from the SELECT call   
	FROM tblEmployee4
	WHERE ID = @ID
END
--------------------------------------------------------------------------
DECLARE @EmployeeName NVARCHAR(50)
EXECUTE spGetNameByID1 3, @EmployeeName OUTPUT
PRINT  'The name of the Employee is ' + @EmployeeName
--------------------------------------------------------------------------
--------------------------------------------------------------------------
ALTER PROCEDURE spGetNameByID2
@ID INT
AS
BEGIN
    RETURN (SELECT Name
	FROM tblEmployee4
	WHERE ID = @ID)
END
--------------------------------------------------------------------------
DECLARE @EmployeeName NVARCHAR(50)
EXECUTE @EmployeeName = spGetNameByID2 3
PRINT  'The name of the Employee is ' + @EmployeeName
-- An error occurs because the RETURN output is always an integer;
-- its return value indicates a success or failure in integer form (i.e. binary)
-- In conclusion using Output Parameters is more flexible in its usage than RETURN
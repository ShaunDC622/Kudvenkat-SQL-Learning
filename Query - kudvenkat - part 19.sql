-- Stored Procedures w/ Output Parameters
---------------------------------------------------------------------------
SELECT * FROM tblEmployee4
---------------------------------------------------------------------------
ALTER PROCEDURE spGetEmployeeCountByGender
@Gender NVARCHAR(20),
@EmployeeCount INT OUTPUT -- OUT or OUTPUT
AS
BEGIN
    SELECT @EmployeeCount = COUNT(ID)
	FROM tblEmployee4
	WHERE Gender = @Gender
END
---------------------------------------------------------------------------
DECLARE @TotalMaleCount INT
EXECUTE spGetEmployeeCountByGender 'Male', @TotalMaleCount OUTPUT
PRINT   @TotalMaleCount
-- Seems you have to DECLARE a variable to capture the output 
-- since this is a Stored Procedure with an Output Parameter
DECLARE @TotalFemaleCount INT
EXECUTE spGetEmployeeCountByGender 'Female', @TotalFemaleCount OUTPUT
PRINT   @TotalFemaleCount
---------------------------------------------------------------------------
sp_help spGetEmployeeCountByGender
sp_help tblEmployee4
-- Seems similar to the help function in Python
---------------------------------------------------------------------------
sp_depends spGetEmployeeCountByGender -- shows what the Stored Procedure depends on
sp_depends tblEmployee4 -- shows the dependants of this table.
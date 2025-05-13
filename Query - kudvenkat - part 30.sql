-- Scalar User defined functions (UDFs)
-------------------------------------------------------------------------------------
SELECT SQUARE(234.343)
SELECT GETDATE() AS [Date and Time]
-- Examples of pre-existing scalar functions built into SQL.
-- Scalar functions are functions that return a single, scalar result.
-------------------------------------------------------------------------------------
-- Syntax for creating a scalar function:
CREATE FUNCTION Function_Name(@Parameter1 DataType, @Parameter2 DataType,..@Parametern Datatype)
RETURNS Return_Datatype
AS 
BEGIN
    Function Body
    Return Return_Datatype
END
-- scalar functions can return any data type EXCEPT text, ntext, image, cursor, and timestamp
----------------------------------------------------------------------------------------
-- Exercise:
DECLARE @DOB DATE -- declaring the variable DOB of datatype DATE
DECLARE @Age INT  -- declaring the variable Age of datatype INT
SET @DOB = '10/08/1982' -- setting the initial value of variable DOB

SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) -
               CASE
			   WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR
			        (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
			   THEN 1
			   ELSE 0
			   END
SELECT @Age
-- *Note that what has been done is not a function; all we did was set values 
--  and then call on the variable again.
-------------------------------------------------------------------------------------
CREATE FUNCTION CalculateAge(@DOB DATE)
RETURNS INT
AS
BEGIN
DECLARE @Age INT  -- declaring the variable Age of datatype INT

SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) -
               CASE
			   WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR
			        (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
			   THEN 1
			   ELSE 0
			   END
RETURN @Age
END
-- *Note the differences:
--  1. You don't need to declare NOR set the variable DOB since it is the parameter
--     of the function.
--  2. SELECT @Age has become RETURN @Age since functions need to return a value afterwards.

SELECT dbo.CalculateAge('10/08/1982') AS [Age]
-- If it is a USF, you HAVE to have the prefix dbo. in front of the functions name.
SELECT [Kudvenkat SQL].dbo.CalculateAge('10/08/1982') AS [Age]
-- In this case, the database name is included for cases where you call a database
-- you don't have direct access to, like a client's database.
----------------------------------------------------------------------------------------
-- Exercise:
SELECT * FROM tblEmployeesDates
----------------------------------------------------------------------------------------
SELECT Name, DateofBirth, dbo.CalculateAge(DateofBirth) AS [Age]
FROM tblEmployeesDates
----------------------------------------------------------------------------------------
SELECT Name, DateofBirth, dbo.CalculateAge(DateofBirth) AS [Age]
FROM tblEmployeesDates
WHERE dbo.CalculateAge(DateofBirth) > 42

-- *The advantage of scalar functions over, say, stored procedures is that they
--  can be passed through select statements whereas stored procedures cannot.

-- DateTime Functions cont. --
--------------------------------------------------------------------------
PRINT DATEPART(mm, GETDATE())
PRINT DATEPART(dd, GETDATE())
PRINT DATEPART(qq, GETDATE())
PRINT DATEPART(weekday, GETDATE())

-- *Returns the integer value of the DatePart you state in the first parameter
--  of the date provided in the second parameter.
--------------------------------------------------------------------------
PRINT DATENAME(mm, GETDATE())
PRINT DATENAME(dd, GETDATE())
PRINT DATENAME(qq, GETDATE())
PRINT DATENAME(weekday, GETDATE())

-- *Notice the difference between DATEPART and DATENAME: the former returns
--  integers and the latter returns strings (yes, the integer values in this
--  example are in fact strings. See the query below:

SELECT SQL_VARIANT_PROPERTY(CONVERT(sql_variant, DATENAME(mm, GETDATE())), 'BaseType') AS DataType;
SELECT SQL_VARIANT_PROPERTY(CONVERT(sql_variant, DATEPART(mm, GETDATE())), 'BaseType') AS DataType;
--------------------------------------------------------------------------
PRINT DATEADD(mm, 2 ,GETDATE())
PRINT DATEADD(dd, 2 ,GETDATE())
PRINT DATEADD(yy, 2 ,GETDATE())
PRINT DATEADD(qq, 2 ,GETDATE())
PRINT DATEADD(weekday, 2 ,GETDATE())

-- * Returns the date in the format matching the 3rd parameter with the addition to
--   its date part in the 1st parameter by the amount specified in the 2nd parameter.
-- * You can have negative integers in the 2nd parameter; this will subtract from the DatePart
--   instead of add.

--------------------------------------------------------------------------
PRINT DATEDIFF(dd, '2015-10-20',GETDATE())
PRINT DATEDIFF(yy, '2015-10-20','2015-12-31')
PRINT DATEDIFF(mm, '2015-10-20',GETDATE())
PRINT DATEDIFF(yy, '2015-10-20',GETDATE())
PRINT DATEDIFF(qq, '2015-10-20',GETDATE())

-- * Returns the difference in two dates (2nd and 3rd parameters in order of 3rd - 2nd)
--   based on the date part specified in the 1st parameter.
-- * However, BE CAREFUL! The function specifically focuses on the DatePart of the dates
-- * provided when performing the difference: with the case of 
--   PRINT DATEDIFF(yy, '2015-10-20','2015-12-31') returns 0 whereas 
--   PRINT DATEDIFF(yy, '2015-10-20','2016-01-01') returns 1 . See below:

PRINT DATEDIFF(yy, '2015-10-20','2015-12-31')
PRINT DATEDIFF(yy, '2015-10-20','2016-01-01')
--------------------------------------------------------------------------
-- Exercise:

DECLARE @DOB DATETIME, @tempdate DATETIME, @years INT, @months INT, @days INT
SET @DOB = '1982-10-08'

SELECT @tempdate = @DOB

SELECT @years = DATEDIFF(YEAR, @tempdate, GETDATE()) -
                CASE
				    WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR
					(MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
					THEN 1 ELSE 0
				END
SELECT @tempdate = DATEADD(YEAR, @years, @tempdate)

SELECT @months = DATEDIFF(MONTH,@tempdate, GETDATE()) -
                 CASE
				     WHEN (DAY(@DOB) > DAY(GETDATE()))
					 THEN 1 ELSE 0
				 END
SELECT @days = DATEDIFF(DAY, @tempdate, GETDATE())

SELECT @years AS [Years], @months AS [Months], @days AS [Days]
--------------------------------------------------------------------------
-- Exercise:

ALTER FUNCTION fnComputeAge(@DOB DATETIME)
RETURNS NVARCHAR(50)
AS
BEGIN

DECLARE @tempdate DATETIME, @years INT, @months INT, @days INT

SELECT @tempdate = @DOB

SELECT @years = DATEDIFF(YEAR, @tempdate, GETDATE()) -
                CASE
				    WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR
					(MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE()))
					THEN 1 ELSE 0
				END
SELECT @tempdate = DATEADD(YEAR, @years, @tempdate)

SELECT @months = DATEDIFF(MONTH,@tempdate, GETDATE()) -
                 CASE
				     WHEN (DAY(@DOB) > DAY(GETDATE()))
					 THEN 1 ELSE 0
				 END
SELECT @days = DATEDIFF(DAY, @tempdate, GETDATE())

DECLARE @Age NVARCHAR(50)
SET @Age = CAST(@years AS NVARCHAR(50)) + ' years, ' + CAST(@months AS NVARCHAR(50)) + ' months, and ' + CAST(@days AS NVARCHAR(50)) + ' days old.'

RETURN @Age

END
----------------------------------------------------------------------
SELECT dbo.fnComputeAge('01/01/2024')
----------------------------------------------------------------------
SELECT ID, Name, DateofBirth, dbo.fnComputeAge(DateofBirth) AS [Age] 
FROM tblEmployeesDates
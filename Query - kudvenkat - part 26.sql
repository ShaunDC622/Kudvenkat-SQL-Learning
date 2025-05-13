-- IsDate, Day, Month, Year and DateName, DateTime Functions --
---------------------------------------------------------------------------
SELECT ISDATE('Hello')
SELECT ISDATE(GETDATE())
-- * Returns 0 if the argument is not a date output and returns 1 if it is.
-- * A rare exception is the argument datetime2; ISDATE will return 0.
---------------------------------------------------------------------------
SELECT DAY(GETDATE())
SELECT DAY('2011-02-13')
SELECT DAY('06/25/2023')
-- * Returns the date day number in the provided argument
---------------------------------------------------------------------------
SELECT MONTH(GETDATE())
SELECT MONTH('2011-02-13')
SELECT MONTH('06/25/2023')
-- * Returns the date month number in the provided argument
---------------------------------------------------------------------------
SELECT YEAR(GETDATE())
SELECT YEAR('2011-02-13')
SELECT YEAR('06/25/2023')
-- * Returns the date year number in the provided argument
---------------------------------------------------------------------------
SELECT DATENAME(DAY,GETDATE())
SELECT DATENAME(WEEKDAY,GETDATE())
SELECT DATENAME(MONTH,GETDATE())
SELECT DATENAME(YEAR,GETDATE())
SELECT DATENAME(DAYOFYEAR,GETDATE())
-- * Returns a string result based on the first parameter (the interval)
--   and the provided date in the second parameter.
-- * There is a list of DatePart entries that could be used as the first
--   parameter in DATENAME.

SELECT SQL_VARIANT_PROPERTY(CONVERT(sql_variant, DATENAME(DAY,GETDATE())), 'BaseType') AS DataType;
-- nvarchar is to SQL Server Management Studio what str or string is to Python.
---------------------------------------------------------------------------
SELECT * FROM tblEmployeesDates
---------------------------------------------------------------------------
-- Exercise:
SELECT Name, DateofBirth, DATENAME(WEEKDAY,DateofBirth) AS [Day],
       MONTH(DateofBirth) AS [Month Number],
	   DATENAME(MONTH,DateofBirth) AS [Month Name],
	   Year(DateofBirth) AS [Year]
FROM tblEmployeesDates
	   




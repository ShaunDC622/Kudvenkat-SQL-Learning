-- Cast and Convert functions
-----------------------------------------------------------------------------------
-- To convert one data type to another, CAST and CONVERT functions can be used.
SELECT * FROM tblEmployeesDates
-----------------------------------------------------------------------------------
SELECT ID, Name, DateofBirth, CAST(DateofBirth AS nvarchar) AS [Converted DOB]
FROM tblEmployeesDates
-- *CAST needs an expression, the 'AS' tie-in, and lastly the date type.
-- *It is optional to include the length of the data type in round brackets, e.g. nvarchar(50)
--------------------------------------------------------------------------------------------
SELECT ID, Name, DateofBirth, CONVERT(nvarchar, DateofBirth, 103) AS [Converted DOB]
FROM tblEmployeesDates
-- *CONVERT needs the datatype first then the expression being converted.
-- *It is optional to provide a 3rd parameter for the data style; you'd need to look them up.

--\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
-- Comparison: CONVERT has more options for changing date data types than CAST because\/\/
-- of its optional third parameter, the data style.                                   \/\/
--\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
--------------------------------------------------------------------------------------------
PRINT GETDATE()
PRINT CONVERT(VARCHAR(10),GETDATE(),101)
-- Getting only the date part of the entire GETDATE output
PRINT CAST(GETDATE() AS DATE)
PRINT CONVERT(DATE, GETDATE())
--------------------------------------------------------------------------------------------
-- Exercise:
SELECT ID, Name, Name + ' - ' + CAST(ID AS NVARCHAR) AS [Name - ID] FROM tblEmployeesDates
-- *The purpose of this exercise is to generate a new column with concatenated data from 
--  the original two columns, but their data types are not the same. Thus, we use CAST to 
--  change the INT values in ID to NVARCHAR data to then concatenate. You can choose to use
--  CAST or CONVERT to achieve this, we just decided to use CAST for this instance.
SELECT ID, Name, Name + ' - ' + CONVERT(NVARCHAR, ID) AS [Name - ID] FROM tblEmployeesDates
--------------------------------------------------------------------------------------------
-- Exercise:
SELECT * FROM tblRegistrations

SELECT CAST(RegisteredDate AS DATE) AS [Registered Date], 
       COUNT(ID) AS [Total]
FROM tblRegistrations
GROUP BY CAST(RegisteredDate AS DATE)
--------------------------------------------------------------------------------------------
-- Differences between the two; more detail:
-- *CAST is based on ANSI (American National Standards Institute) standard and CONVERT is
--  specific to SQL Server. If portability is an issue, then rather use CAST.
-- *As mentioned before, CONVERT is more flexible than CAST; there is a choice in style
--  of date types.
-- *Conclusion: use CAST unless you want the advantage of style functionality, then you use CONVERT
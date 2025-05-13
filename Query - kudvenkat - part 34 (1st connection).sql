-- Temporary Tables (1st Connection)
-------------------------------------------------------------------------------------------
-- *They share similar properties to permanent tables, with the exception that they
--  get created in the TempDB and are automatically deleted when they are no longer used.
-- *There are different types of temp tables: local and global.
-------------------------------------------------------------------------------------------
-- Temp tables are made in a similar fashion to perm tables with the exception that we
-- label their names with a # in front. See the example to follow:
CREATE TABLE #PersonDetails(
ID INT,
Name NVARCHAR(20))

INSERT INTO #PersonDetails VALUES(1, 'Mike')
INSERT INTO #PersonDetails VALUES(2, 'John')
INSERT INTO #PersonDetails VALUES(3, 'Todd')

SELECT * FROM #PersonDetails
-- This table is temporarily stored in the tempdb database under "Temporary Tables".
-------------------------------------------------------------------------------------------
-- Another way to check if the table was stored is the following line:
SELECT NAME FROM tempdb..sysobjects
WHERE NAME like '#PersonDetails%'
-- *It is better to use LIKE when calling on the name of the temp table since SQL creates
--  temp tables with added characters to the end of it.
-------------------------------------------------------------------------------------------
-- *If the temp table is created inside a stored procedure, it gets dropped automatically
--  upon the completion of the stored procedure execution. See the example below:
CREATE PROCEDURE spCreateLocalTempTable
AS
BEGIN
CREATE TABLE #PersonDetails(
ID INT,
Name NVARCHAR(20))

INSERT INTO #PersonDetails VALUES(1, 'Mike')
INSERT INTO #PersonDetails VALUES(2, 'John')
INSERT INTO #PersonDetails VALUES(3, 'Todd')

SELECT * FROM #PersonDetails
END
-- Executing the stored procedure and calling the temp table:
EXECUTE spCreateLocalTempTable

SELECT * FROM #PersonDetails
-- *After executing the line above, you cannot since executing the stored procedure has 
--  deleted the temp table created within it.
-------------------------------------------------------------------------------------------
-- *What has been seen so far were Local Temporary Tables; we will now consider 
--  Global Temporary Tables.
-- *Global Temporary Tables are created using double # in front of their names. 
--  See the example below:
CREATE TABLE ##EmployeeDetails(
ID INT,
Name NVARCHAR(20))

SELECT * FROM ##EmployeeDetails
-- *Global temp tables are only destroyed once the last connection referencing the table is
--  closed.

-- *Knowing what Local Temporary Tables and Global Temporary Tables are, their properties, and
--  the difference between the two is a potential INTERVIEW QUESTION.
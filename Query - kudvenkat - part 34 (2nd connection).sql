-- Temporary Tables (2nd Connection)
-------------------------------------------------------------------------------------------
SELECT * FROM #PersonDetails
-- *Since this query, this connection, did not create the temp table, it cannot call it.
-- *If you try to call it, you get the error message: "Invalid object name '#PersonDetails'."
-------------------------------------------------------------------------------------------
CREATE TABLE #PersonDetails(
ID INT,
Name NVARCHAR(20))

INSERT INTO #PersonDetails VALUES(1, 'Mike')
INSERT INTO #PersonDetails VALUES(2, 'John')
INSERT INTO #PersonDetails VALUES(3, 'Todd')

SELECT * FROM #PersonDetails
-- *After creating this temp table and the one in the first connection, they have
--  different extentions to their names that SQL automatically adds.
-- *The one has an extension name of 000000000005 and the other 000000000006.
-------------------------------------------------------------------------------------------
SELECT * FROM ##EmployeeDetails
-- *Notice that this table, although created in the 1st connection, can be called here in
--  the 2nd connection - this is what makes it global instead of local.
-------------------------------------------------------------------------------------------
-- *Global temp tables have to have unique names since SQL does NOT add extensions to global
--  temp table names. 
-- *If you try to create the table with the same name again, you get the following:
CREATE TABLE ##EmployeeDetails(
ID INT,
Name NVARCHAR(20))
-- Error message: "There is already an object named '##EmployeeDetails' in the database."

-- *Knowing what Local Temporary Tables and Global Temporary Tables are, their properties, and
--  the difference between the two is a potential INTERVIEW QUESTION.
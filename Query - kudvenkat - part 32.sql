-- Multi-Statement Table Valued (MSTV) functions
--------------------------------------------------------------------------------------------
-- *MSTV functions are very similar to ITV functions with a few differences.
--------------------------------------------------------------------------------------------
-- Example: ILTVF and MSTVF creating the same function
-- 1. ILTVF
ALTER FUNCTION fn_ILTVF_GetEmployees()
RETURNS TABLE
AS
RETURN (SELECT ID, Name, CAST(DateOfBirth AS DATE) AS DOB
        FROM tblEmployeesDates1)
-- *No BEGIN and END block.
---------------------------------------------------------------
SELECT * FROM tblEmployeesDates1
SELECT * FROM fn_ILTVF_GetEmployees()
---------------------------------------------------------------
-- 2. MSTVF
ALTER FUNCTION fn_MSTVF_GetEmployees()
RETURNS @Table TABLE (ID INT, Name NVARCHAR(20), DOB DATE)
AS
BEGIN
 INSERT INTO @Table
 SELECT ID, Name, CAST(DateOfBirth AS DATE)
 FROM tblEmployeesDates1
 -- retrieving records from a different table in a certain way and placing them into @Table
 RETURN
END
-- *Provide variable for the return, in this case @Table.
-- *Since TABLE is the datatype for the variable, you need to specify 
--  the columns and their respective datatypes.
-- *There is a BEGIN and END block.
-- *You have to INSERT INTO the representative variable and then the SELECT statement.
-- *Note that since the variable already has the column DOB, you don't need to specify the
--  name in SELECT statement as was the case with the ILTVF.
---------------------------------------------------------------
SELECT * FROM tblEmployeesDates1
SELECT * FROM fn_MSTVF_GetEmployees()
--------------------------------------------------------------------------------------------
-- *The main take away from this is that MSTV functions allow more structure and control
--  over how the function works and is formed.
-- *In other words, you don't specify the structure of the table in ILTV functions, but
--  in MSTV functions you do.
-- *However, ILTV functions are better for performance than MSTV functions (this should come as
--  no surprise).
-- *It is possible to update the underlying table using ILTVF but not MSTVF.
--------------------------------------------------------------------------------------------
-- Example showing how ILTVFs can be updated
UPDATE fn_ILTVF_GetEmployees() SET Name = 'Samantha' WHERE ID = 1
SELECT * FROM fn_ILTVF_GetEmployees()
--------------------------------------------------------------------------------------------
UPDATE fn_ILTVF_GetEmployees() SET Name = 'Samuel' WHERE ID = 1
SELECT * FROM fn_ILTVF_GetEmployees()
--------------------------------------------------------------------------------------------
-- Example showing how MSTVFs can NOT be updated
UPDATE fn_MSTVF_GetEmployees() SET Name = 'Samantha' WHERE ID = 1
SELECT * FROM fn_MSTVF_GetEmployees()
-- *Highlight and Execute; see for yourself.
-- *HOWEVER, you can do this:
UPDATE tblEmployeesDates1 SET Name = 'Samantha' WHERE ID = 1
SELECT * FROM fn_MSTVF_GetEmployees()
-- *The point is that the MSTVF we created for our example gets all its info from
--  the table tblEmployeesDates1, thus if we update that table, the change will reflect
--  in our  MSTVF example.

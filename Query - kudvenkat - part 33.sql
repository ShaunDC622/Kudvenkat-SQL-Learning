-- Functions - Important Concepts
---------------------------------------------------------------------------------------
-- *Deterministic functions: always return the same result any time they are called
--  with a specific set of input values and given the same state of the database.
-- *Examples are functions like: SQUARE(), POWER(), SUM(), AVG() and COUNT().
---------------------------------------------------------------------------------------
-- Example of deterministic function:
SELECT * FROM tblEmployeesDates1
SELECT COUNT(*) FROM tblEmployeesDates1
-- *No matter how many times you run the line above, it will always return 5.
-- *It is only if you change the state of the database will the return change.
---------------------------------------------------------------------------------------
-- *Nondeterministic functions: may return different results each time they are called
--  with a specific set of input values even if the database state that they access remains
--  the same.
-- *Examples are functions like: GETDATE() and CURRENT_TIMESTAMP.
-- *RAND() function is a nondeterministic function, but if you provide the seed value, 
--  the function becomes deterministic, as the same value gets returned for the same seed
--  value.
---------------------------------------------------------------------------------------
-- Example of nondeterministic function:
SELECT GETDATE() as [Current Date and Time]
SELECT CURRENT_TIMESTAMP as [Current Date and Time]
-----------------------------------------------------
SELECT CAST(RAND()*100 AS INT) -- nondeterministic
SELECT CAST(RAND(54654654)*100 AS INT) -- deterministic
--------------------------------------------------------------------------------------
-- Knowing what deterministic and nondeterministic functions are and their differences
-- can be an INTERVIEW QUESTION!!!
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Encryption and Schemabinding
CREATE FUNCTION fn_GetNameByID(@ID INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    RETURN(SELECT Name FROM tblEmployeesDates1 WHERE ID = @ID)
END
---------------------------------------------------------------------------------------
SELECT dbo.fn_GetNameByID(1)
---------------------------------------------------------------------------------------
sp_helptext fn_GetNameByID -- to get the function structure in text format
---------------------------------------------------------------------------------------
-- To encrypt the function, you write the function as follows:
ALTER FUNCTION fn_GetNameByID(@ID INT)  
RETURNS NVARCHAR(50) 
WITH ENCRYPTION
AS  
BEGIN  
    RETURN(SELECT Name FROM tblEmployeesDates1 WHERE ID = @ID)  
END
---------------------------------------------------------------------------------------
-- Now, if we try to view the function using the stored procedure, we get the following:
sp_helptext fn_GetNameByID
-- "The text for object 'fn_GetNameByID' is encrypted."
-- *It is possible to decrypt the function, but it won't be covered here.
---------------------------------------------------------------------------------------
-- *Schemabinding specifies that the function is bound to the database objects that it 
--  references. In other words, this prevents a table/database from being dropped since
--  it is bounded to a function that calls on it.
ALTER FUNCTION fn_GetNameByID(@ID INT)  
RETURNS NVARCHAR(50)
WITH SCHEMABINDING
AS  
BEGIN  
    RETURN(SELECT Name FROM dbo.tblEmployeesDates1 WHERE ID = @ID) 
	-- Note the schema dbo. for the table's name is used
END
---------------------------------------------------------------------------------------
-- Now if we try to drop the table tblEmployeesDates1, we get the following:
DROP TABLE tblEmployeesDates1
-- "Cannot DROP TABLE 'tblEmployeesDates1' because it is being referenced by object 
--  'fn_GetNameByID'."
---------------------------------------------------------------------------------------
-- Lastly, it is possible to use both ENCRYPTION and SCHEMABINDING at the same time:
ALTER FUNCTION fn_GetNameByID(@ID INT)  
RETURNS NVARCHAR(50)
WITH ENCRYPTION,SCHEMABINDING
AS  
BEGIN  
    RETURN(SELECT Name FROM dbo.tblEmployeesDates1 WHERE ID = @ID) 
	-- Note the schema dbo. for the table's name is used
END

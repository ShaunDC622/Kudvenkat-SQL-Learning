-- Advantages of Stored Procedures
--------------------------------------------------------------------------------
SELECT Name FROM tblEmployee4 WHERE ID = 1
SELECT Name FROM tblEmployee4 WHERE ID = 2
--------------------------------------------------------------------------------
sp_helptext spGetNameByID
--------------------------------------------------------------------------------
EXECUTE spGetNameByID 1 
EXECUTE spGetNameByID 2
--------------------------------------------------------------------------------
-- 1. Stored Procedures reuse execution plans instead of generating new ones.
-- 2. They reduce network traffic.
-- 3. They have easy maintainability and reusability 
--    (in terms of changing/updating them)
-- 4. They are better for security purposes especially if you encrypt it.
-- 5. They avoid SQL Injection attacks
-- *SQL injection is a code injection technique that might destroy your database.
-- *It is one of the most common web hacking techniques.
-- *It is the placement of malicious code in SQL statements, via web page input.

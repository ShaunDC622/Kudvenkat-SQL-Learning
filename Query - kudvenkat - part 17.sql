--CREATE TABLE tblUKCustomers(
--ID INT PRIMARY KEY,
--Name NVARCHAR(50),
--Email NVARCHAR(50)
--)
-----------------------------------------------------------------------
--INSERT INTO tblUKCustomers
--VALUES (2, 'Sam', 'S@S.com')

--SELECT * FROM tblUKCustomers
-----------------------------------------------------------------------
SELECT * FROM tblIndiaCustomers
SELECT * FROM tblUKCustomers
-----------------------------------------------------------------------
--Using UNION ALL to combine the tables:
SELECT * FROM tblIndiaCustomers
UNION ALL
SELECT * FROM tblUKCustomers
-- Conclusion: a simple combining of the right table to the left table,
-- this is NOT like how union is done for 2 sets in set theory
-- in other words, duplicates could appear when using UNION ALL
-- it does not sort in order; this makes it faster than UNION
-- NB: This is could be an interview question!
-----------------------------------------------------------------------
--Using UNION to combine the tables:
SELECT * FROM tblIndiaCustomers
UNION
SELECT * FROM tblUKCustomers
-- Conclusion: this is EXACTLY how union works in set theory
-- No duplicates at all; just like union in set theory
-- It sorts in order; this makes it slower than UNION ALL
-- NB: This is could be an interview question!
-----------------------------------------------------------------------
--Using UNION ALL to combine the tables with different matching columns:
SELECT ID, Email, Name FROM tblIndiaCustomers
UNION ALL
SELECT ID, Name, Email FROM tblUKCustomers
-- As long as the number of columns are equal between the two tables,
-- it will perform the UNION ALL
-----------------------------------------------------------------------
-- Using ORDER BY along with UNION ALL
SELECT * FROM tblIndiaCustomers
UNION ALL
SELECT * FROM tblUKCustomers
ORDER BY Name
-- UNION ALL first to combine the tables and then use
--  ORDER BY to change the overall order of the resulting table
--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
-- UNION vs JOIN: In short, UNION combines rows from 2 or more tables,
-- whereas JOIN combines columns from 2 or more tables.
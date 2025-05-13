--CREATE TABLE tblEmployee3 (
--ID int PRIMARY KEY,
--FirstName nvarchar(50),
--MiddleName nvarchar(50),
--LastName nvarchar(50)
--)
------------------------------------------------------------------------
--INSERT INTO tblEmployee3 
--VALUES (5,'James','Nick','Nancy')

--SELECT * FROM tblEmployee3
------------------------------------------------------------------------
-- I had to create the table before beginning the main part of the session
SELECT ID, COALESCE(FirstName, MiddleName, LastName) AS Name
FROM tblEmployee3
-- It will return the first non-NULL value it finds
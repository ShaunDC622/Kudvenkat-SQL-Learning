-- Advantages and disadvantages of Indexes
-----------------------------------------------------------------------------------------
-- *Previously, we have learnt that indexes are used by queries to find data quickly. 
-----------------------------------------------------------------------------------------
CREATE TABLE [tblEmployee4]
(
 [ID] INT PRIMARY KEY,
 [First Name] NVARCHAR(50),
 [Last Name] NVARCHAR(50),
 [Salary] INT,
 [Gender] NVARCHAR(10),
 [City] NVARCHAR(50)
)
-----------------------------------------------------------------------------------------
INSERT INTO tblEmployee4 VALUES(1,'Mike', 'Sandoz',4500,'Male','New York')
INSERT INTO tblEmployee4 VALUES(2,'Sara', 'Menco',6500,'Female','London')
INSERT INTO tblEmployee4 VALUES(3,'John', 'Barber',2500,'Male','Sydney')
INSERT INTO tblEmployee4 VALUES(4,'Pam', 'Grove',3500,'Female','Toronto')
INSERT INTO tblEmployee4 VALUES(5,'James', 'Mirch',7500,'Male','London')
-----------------------------------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_tblEmployee4_Salary
ON tblEmployee4 (Salary ASC)
-----------------------------------------------------------------------------------------
SELECT * FROM tblEmployee4
-----------------------------------------------------------------------------------------
-- The advantages of indexes:
-- *All of the queries below benefit from having an index created since the time it takes
--  to execute the query on the Salary column is reduced with the index created over the
--  Salary column.
SELECT * FROM tblEmployee4 WHERE Salary > 4000 AND Salary < 8000
-- Now, we are going to edit the data in the table:
DELETE FROM tblEmployee4 WHERE Salary = 2500
UPDATE tblEmployee4 SET Salary = 9000 WHERE Salary = 7500
-----------------------------------------------------------------------------------------
SELECT * FROM tblEmployee4 ORDER BY Salary
-- ORDER BY ASC
SELECT * FROM tblEmployee4 ORDER BY Salary DESC
-- ORDER BY DESC
-----------------------------------------------------------------------------------------
SELECT Salary, COUNT(Salary) AS Total
FROM tblEmployee4
GROUP BY Salary
-----------------------------------------------------------------------------------------
-- The disadvantages of indexes:
-- 1. Additional disk space: Clustered Indexes don't require any additional storage. 
--    However, every Nonclustered index requires additional space as it is stored 
--    separately from the table. The amount of space required will depend on the size of 
--    the table, and the number and types of columns used in the index.
-- 1.1 However, as technology advantages, storage becomes less and less of an issue, and
--     system performance is then favoured over storage.
-- 2. INSERT, UPDATE and DELETE statements can become slow: When DML
--    (Data Manipulation Language) statements modify data in a table, the data in
--    all the indexes also needs to be updated. Indexes can help to search and
--    locate the rows that we want to delete, but too many indexes to update
--    can actually hurt the performance of data modifications.
-----------------------------------------------------------------------------------------
-- Covering Query:
-- *A covering query is a query that contains the necessary column(s) that a table has
--  index(es) for those same columns. This means there are less lookups performed when
--  a covering query is used. SELECT * is also a covering query.
-- *A clustered index will always cover a query since it contains all of the data in a table.
-----------------------------------------------------------------------------------------
-- Composite index:
-- *A composite index is an index on two or more columns. Both clustered and nonclustered
--  indexes can be composite indexes.
-- *To a certain extent, a composite index can cover a query.

-- Indexes
--------------------------------------------------------------------------------------------
-- *They are used in queries to find data from tables quickly
-- *Index on a table or view is similar to an index in a book.
-- *The use of a good index can drastically reduce the time it takes to located data
-- *If you don't use an index, you run the risk of the query engine performing a Table Scan,
--  which scanes every row in the table from beginning to end which is bad for performance.
--------------------------------------------------------------------------------------------
CREATE TABLE tblEmployeeSalary(
ID int PRIMARY KEY NOT NULL,
Name NVARCHAR(20),
Salary INT,
Gender NVARCHAR(10)
)
--------------------------------------------------------------------------------------------
INSERT INTO tblEmployeeSalary VALUES (1, 'Sam', 2500, 'Male')
INSERT INTO tblEmployeeSalary VALUES (2, 'Pam', 6500, 'Female')
INSERT INTO tblEmployeeSalary VALUES (3, 'John', 4500, 'Male')
INSERT INTO tblEmployeeSalary VALUES (4, 'Sara', 5500, 'Female')
INSERT INTO tblEmployeeSalary VALUES (5, 'Todd', 3100, 'Male')
--------------------------------------------------------------------------------------------
SELECT * FROM tblEmployeeSalary
WHERE Salary > 5000 and Salary < 7000
--------------------------------------------------------------------------------------------
CREATE INDEX IX_tblEmployeeSalary_Salary 
-- We place '_Salary' in the name to indicate which column the index will be placed.
ON tblEmployeeSalary (Salary ASC)
-- *We select the table we place the index into and select the column in the table, 
--  ordered in ascending order.
--------------------------------------------------------------------------------------------
sp_Helpindex tblEmployeeSalary 
-- This stored procedure finds all the indexes that are created for the table 'tblEmployeeSalary'.
--------------------------------------------------------------------------------------------
-- If you wish to drop the index, you can by executing the line below:
DROP INDEX tblEmployeeSalary.IX_tblEmployeeSalary_Salary 
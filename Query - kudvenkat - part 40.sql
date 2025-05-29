-- Updateable Views
-----------------------------------------------------------------------------------------
SELECT * FROM tblEmployee5
-------------------------------------------
CREATE VIEW vWEmployeesDataExceptSalary AS
SELECT ID, Name, Gender, DepartmentID
FROM tblEmployee5
--------------------------------------------
SELECT * FROM vWEmployeesDataExceptSalary
-----------------------------------------------------------------------------------------
-- *Is it possible to INSERT, UPDATE & DELETE from the base table through the view?
--  (Based on my understanding of SQL, tables, and views, my initial thought is no).
-- *According to Venkat, it IS possible! :O
UPDATE vWEmployeesDataExceptSalary
SET Name = 'Mikey' WHERE ID = 2
-------------------------------------
SELECT * FROM tblEmployee5
-- *It works! That is rather interesting, but isn't that problematic? The view is a 
--  derivative of the base table, surely making changes to it SHOULDN'T affect 
--  the base table!?
-------------------------------------
DELETE FROM vWEmployeesDataExceptSalary WHERE ID = 2
-- *Again, this works on both the view and base table, which I think is problematic.
-- *Let us put back the row we just deleted:
INSERT INTO vWEmployeesDataExceptSalary VALUES (2, 'Mikey', 'Male', 2)
-- *Since the view withholds the salary info, when inserting into it, the base table will
--  have a NULL value in its Salary column. Again, this is an issue.
-----------------------------------------------------------------------------------------
-- *We have already created a view based on two tables joined together:
SELECT * FROM vWEmployeesByDepartment
-- What happens when you udpate a view like this that depends on more than one table?
UPDATE vWEmployeesByDepartment SET DeptName = 'IT' WHERE Name = 'John'
-- *Note that the update was supposed to only affect John's department, 
--  yet it affected Ben's too. Why did this happen? What went wrong?
-----------------------------------------------------------------------------------------
-- Select the data from the two base tables; let's see what is happening:
SELECT * FROM tblEmployee5
SELECT * FROM tblDepartment1 
-- *The issue comes from tblDepartment1: the department with DeptID = 3 has been
--  changed to IT from HR.
-- *Instead of changing John's DepartmentID to 1 so that he is now with the IT department, 
--  the update query instead took the DepartmentID he previously had, which was 3, and
--  changed its corresponding department from HR to IT, thus everyone with the DepartmentID 
--  of 3 are with the IT department and no longer the HR department.

-- *What can be concluded: if a view is created using multiple tables, and it gets updated,
--  it may not update the underlying based tables correctly.
-- *To correctly update a view based on multiple tables, INSTEAD OF triggers should be used.
--  INSTEAD OF triggers will be looked at in a future session/query.

 -- Joins in SQL Server
 ---------------------------------------------------------------------------
CREATE TABLE tblDepartment
(
     ID INT PRIMARY KEY,
     DepartmentName NVARCHAR(50),
     Location NVARCHAR(50),
     DepartmentHead NVARCHAR(50)
)
---------------------------------------------------------------------------
INSERT INTO tblDepartment VALUES (1, 'IT', 'London', 'Rick')
INSERT INTO tblDepartment VALUES (2, 'Payroll', 'Delhi', 'Ron')
INSERT INTO tblDepartment VALUES (3, 'HR', 'New York', 'Christie')
INSERT INTO tblDepartment VALUES (4, 'Other Department', 'Sydney', 'Cindrella')
---------------------------------------------------------------------------
CREATE TABLE tblEmployee1
(
     ID INT PRIMARY KEY,
     Name NVARCHAR(50),
     Gender NVARCHAR(50),
     Salary INT,
     DepartmentID INT FOREIGN KEY REFERENCES tblDepartment(ID)
)
---------------------------------------------------------------------------
Insert into tblEmployee1 values (1, 'Tom', 'Male', 4000, 1)
Insert into tblEmployee1 values (2, 'Pam', 'Female', 3000, 3)
Insert into tblEmployee1 values (3, 'John', 'Male', 3500, 1)
Insert into tblEmployee1 values (4, 'Sam', 'Male', 4500, 2)
Insert into tblEmployee1 values (5, 'Todd', 'Male', 2800, 2)
Insert into tblEmployee1 values (6, 'Ben', 'Male', 7000, 1)
Insert into tblEmployee1 values (7, 'Sara', 'Female', 4800, 3)
Insert into tblEmployee1 values (8, 'Valarie', 'Female', 5500, 1)
Insert into tblEmployee1 values (9, 'James', 'Male', 6500, NULL)
Insert into tblEmployee1 values (10, 'Russell', 'Male', 8800, NULL)
---------------------------------------------------------------------------
Select * FROM tblEmployee1
Select * FROM tblDepartment

Select Name, Gender, Salary, DepartmentName
FROM tblEmployee1
INNER JOIN tblDepartment -- Also known as JOIN; it is an "Intersection".
ON tblEmployee1.DepartmentID = tblDepartment.ID
---------------------------------------------------------------------------
Select * FROM tblEmployee1
Select * FROM tblDepartment

Select Name, Gender, Salary, DepartmentName
FROM tblEmployee1
LEFT OUTER JOIN tblDepartment -- Also known as LEFT JOIN; All of "Left Circle"
ON tblEmployee1.DepartmentID = tblDepartment.ID
---------------------------------------------------------------------------
Select * FROM tblEmployee1
Select * FROM tblDepartment

Select Name, Gender, Salary, DepartmentName
FROM tblEmployee1
RIGHT OUTER JOIN tblDepartment -- Also known as RIGHT JOIN; All of "Right Circle"
ON tblEmployee1.DepartmentID = tblDepartment.ID
---------------------------------------------------------------------------
Select * FROM tblEmployee1
Select * FROM tblDepartment

Select Name, Gender, Salary, DepartmentName
FROM tblEmployee1
FULL OUTER JOIN tblDepartment -- Also known as FULL JOIN; it is a "Union"
ON tblEmployee1.DepartmentID = tblDepartment.ID
---------------------------------------------------------------------------
Select * FROM tblEmployee1
Select * FROM tblDepartment

Select Name, Gender, Salary, DepartmentName
FROM tblEmployee1
CROSS JOIN tblDepartment -- Cartesian product of the two tables.
--------------------------------------------------------------------------
-- General Formula for JOINS --
--SELECT      ColumnList
--FROM        LeftTable
--JoinType    RightTable
--ON          JoinCondition
--------------------------------------------------------------------------

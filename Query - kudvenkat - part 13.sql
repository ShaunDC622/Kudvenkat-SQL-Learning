SELECT * FROM tblEmployee1
SELECT * FROM tblDepartment

---------------------------------------------------------------------------
-- LEFT JOIN that only has info contained in the left table
-- and NOT the right table.
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee1 E -- Providing a short-hand variable for the column name.
LEFT JOIN tblDepartment D -- Same as comment above.
ON E.DepartmentID = D.ID
WHERE D.ID IS NULL
---------------------------------------------------------------------------
-- RIGHT JOIN that only has info contained in the right table
-- and NOT the left table.
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee1 E -- Providing a short-hand variable for the column name.
RIGHT JOIN tblDepartment D -- Same as comment above.
ON E.DepartmentID = D.ID
WHERE E.DepartmentID IS NULL
---------------------------------------------------------------------------
-- FULL JOIN that provides info NOT shared between the two tables
SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee1 E -- Providing a short-hand variable for the column name.
FULL JOIN tblDepartment D -- Same as comment above.
ON E.DepartmentID = D.ID
WHERE D.ID IS NULL OR E.DepartmentID IS NULL
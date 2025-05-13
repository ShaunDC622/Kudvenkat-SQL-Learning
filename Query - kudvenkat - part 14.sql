-- Self Join: can be classified as inner, outer or cross self join
-----------------------------------------------------------------------
SELECT * FROM tblEmployee2
-----------------------------------------------------------------------
-- Left Join
SELECT E.Name AS Employee, M.Name AS Manager
FROM tblEmployee2 E
LEFT JOIN tblEmployee2 M
ON E.ManagerID = M.EmployeeID
-----------------------------------------------------------------------
-- Right Join
SELECT E.Name AS Employee, M.Name AS Manager
FROM tblEmployee2 E
RIGHT JOIN tblEmployee2 M
ON E.ManagerID = M.EmployeeID
-- This is not a useful join table; the left self join is more useful.
-----------------------------------------------------------------------
-- Inner Join
SELECT E.Name AS Employee, M.Name AS Manager
FROM tblEmployee2 E
INNER JOIN tblEmployee2 M
ON E.ManagerID = M.EmployeeID
-----------------------------------------------------------------------
-- Cross Join
SELECT E.Name AS Employee, M.Name AS Manager
FROM tblEmployee2 E
CROSS JOIN tblEmployee2 M
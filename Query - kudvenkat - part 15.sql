SELECT * FROM tblEmployee2
-------------------------------------------------------------------------
-- Recalling the Self Join example done in the previous part.
SELECT E.Name AS Employee, M.Name AS Manager
FROM tblEmployee2 E
LEFT JOIN tblEmployee2 M
ON E.ManagerID = M.EmployeeID
-------------------------------------------------------------------------
-- Learning the ISNULL function
SELECT ISNULL(NULL,'No Manager') AS Manager
SELECT ISNULL('PRAGIM','No Manager') AS Manager
-------------------------------------------------------------------------
-- Using ISNULL in the Self Join example
SELECT E.Name AS Employee, ISNULL(M.Name,'No Manager') AS Manager
FROM tblEmployee2 E
LEFT JOIN tblEmployee2 M
ON E.ManagerID = M.EmployeeID
-------------------------------------------------------------------------
-- Learning the COALESCE function
SELECT COALESCE(NULL,'No Manager') AS Manager
SELECT COALESCE('PRAGIM','No Manager') AS Manager
-- Conclusion: similar to ISNULL function, but apparently more powerful.
-- COALESCE function to be studied in the next part.
-------------------------------------------------------------------------
-- Using COALESCE in the Self Join example
SELECT E.Name AS Employee, COALESCE(M.Name,'No Manager') AS Manager
FROM tblEmployee2 E
LEFT JOIN tblEmployee2 M
ON E.ManagerID = M.EmployeeID
-------------------------------------------------------------------------
-- Learning the CASE statements
-- Syntax is: CASE WHEN Expression THEN '' ELSE '' END
-------------------------------------------------------------------------
-- Using CASE statement in the Self Join example
SELECT E.Name AS Employee, 
CASE WHEN M.Name IS NULL THEN 'No Manager' ELSE M.Name END AS Manager
FROM tblEmployee2 E
LEFT JOIN tblEmployee2 M
ON E.ManagerID = M.EmployeeID
-- Instead Of INSERT triggers
------------------------------------------------------------------------------------------
SELECT ID, Name, Gender, DepartmentID FROM tblEmployee5
-- Correcting an entry in the tblDepartment1 table:
UPDATE tblDepartment1 SET DeptName = 'HR' WHERE DeptID = 3 
SELECT * FROM tblDepartment1
------------------------------------------------------------------------------------------
-- Creating a new view a part of this session and its purpose
CREATE VIEW vWEmployeeAndDeptDetails
AS
SELECT ID, Name, Gender, DeptName FROM vWEmployeeDetails AS v
LEFT JOIN tblDepartment1 AS d
ON v.DepartmentID = d.DeptID
------------------------------------------------------------------------------------------
SELECT * FROM vWEmployeeAndDeptDetails
------------------------------------------------------------------------------------------
-- For demonstration purposes; it is expected to fail
INSERT INTO vWEmployeeAndDeptDetails VALUES (7, 'Valarie', 'Female', 'IT')
-- *We get the error: "View or function 'vWEmployeeAndDeptDetails' is not updatable 
--  because the modification affects multiple base tables."
-- *Since the view was made using more than one table, SQL doesn't know which table
--  the row should be inserted into.
-- *Instead of triggers are often used to update views based on multiple tables correctly.
------------------------------------------------------------------------------------------
CREATE TRIGGER tr_vWEmployeeAndDeptDetails_InsteadOfInsert
ON vWEmployeeAndDeptDetails
INSTEAD OF INSERT
AS
BEGIN
     DECLARE @DeptID INT

	 -- Check if there is a valide DepartmentID for the given DepartmentName:
	 SELECT @DeptID = DeptID
	 FROM tblDepartment1 as d
	 JOIN inserted
	 ON inserted.DeptName = d.DeptName

	 -- If DepartmentID is null, throw an error and stop processing:
	 IF(@DeptID IS NULL)
	 BEGIN
	     RAISERROR('Invalid Department Name. Statement terminated', 16, 1)
		 -- the 2nd parameter is for the severity level
		 -- the 3rd parameter is for the state, which is usually 1
		 RETURN
     END

	 --Finally, insert into tblEmployee5 table:
	 INSERT INTO tblEmployee5 (ID, Name, Gender, DepartmentID)
	 SELECT ID, Name, Gender, @DeptID
	 FROM inserted
END
------------------------------------------------------------------------------------------
-- *Now, to test:
--  Test 1:
INSERT INTO vWEmployeeAndDeptDetails VALUES (7, 'Valarie', 'Female', 'Nokjnflkfn')
--  Test 2:
INSERT INTO vWEmployeeAndDeptDetails VALUES (7, 'Valarie', 'Female', 'IT')
SELECT * FROM vWEmployeeAndDeptDetails

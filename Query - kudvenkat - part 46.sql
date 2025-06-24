-- Instead Of UPDATE Trigger
------------------------------------------------------------------------------------------
-- Checking I am using the correct tables for the purposes of this query
SELECT * FROM tblDepartment1
SELECT * FROM tblEmployee5
-- Checking I am using the correct views for the purposes of this query
SELECT * FROM vWEmployeeDetails
SELECT * FROM vWEmployeeAndDeptDetails
------------------------------------------------------------------------------------------
-- For demonstration purposes; the query below will fail:
UPDATE vWEmployeeAndDeptDetails SET Name = 'Johnny', DeptName = 'IT' WHERE ID = 1
-- *It gives the error: "View or function 'vWEmployeeAndDeptDetails' is not updatable 
--  because the modification affects multiple base tables."
------------------------------------------------------------------------------------------
-- *If you choose to only UPDATE one column value, instead of two, in the view, it will
--  actually affect one of the base tables as a result:
UPDATE vWEmployeeAndDeptDetails SET DeptName = 'IT' WHERE ID = 1

SELECT * FROM vWEmployeeAndDeptDetails
SELECT * FROM tblDepartment1
-- *This is not what we want to happen. We want the view's row value to change, not the 
--  base table's value. Let's fix this before we move onto creating the necessary trigger:
UPDATE tblDepartment1 SET DeptName = 'HR' WHERE DeptID = 3
-- Checking we have successfully reverted the problematic UPDATE:
SELECT * FROM tblDepartment1
SELECT * FROM vWEmployeeAndDeptDetails
------------------------------------------------------------------------------------------
-- Creating the trigger for the purpose of this query:
CREATE TRIGGER tr_vWEmployeeAndDeptDetails_InsteadOfUpdate
ON vWEmployeeAndDeptDetails
INSTEAD OF UPDATE
AS
BEGIN
     -- If EmployeeID is updated:
	 IF(UPDATE(ID))
	 BEGIN
	      RAISERROR('ID cannot be changed.', 16, 1)
		  RETURN
	 END
	 -- If DeptName is updated:
	 IF(UPDATE(DeptName))
	 BEGIN
	     DECLARE @DeptID INT

		 SELECT @DeptID = DeptID
		 FROM tblDepartment1 AS d
		 JOIN inserted
		 ON inserted.DeptName = d.DeptName

		 IF(@DeptID IS NULL)
		 BEGIN
		     RAISERROR('Invalid Department Name.', 16, 1)
			 RETURN
		 END

		 UPDATE tblEmployee5 SET DepartmentID = @DeptID
		 FROM inserted
		 JOIN tblEmployee5 as E5
		 ON E5.ID = inserted.ID
	 END
	 -- If Gender is updated:
	 IF(UPDATE(Gender))
	 BEGIN
		 UPDATE tblEmployee5 SET Gender = inserted.Gender
		 FROM inserted
		 JOIN tblEmployee5 as E5
		 ON E5.ID = inserted.ID
	 END
	 -- If Name is updated:
	 IF(UPDATE(Name))
	 BEGIN
		 UPDATE tblEmployee5 SET Name = inserted.Name
		 FROM inserted
		 JOIN tblEmployee5 as E5
		 ON E5.ID = inserted.ID
	 END
END
------------------------------------------------------------------------------------------
-- *Now to test if the trigger is working as intended:
--  Test 1:
UPDATE vWEmployeeAndDeptDetails SET ID = 99 WHERE Name = 'John'
--  Test 2:
UPDATE vWEmployeeAndDeptDetails SET DeptName = 'Operations' WHERE Name = 'John'
--  Test 3:
UPDATE vWEmployeeAndDeptDetails SET Name = 'Johnny' WHERE ID = 1
  -- To switch it back:
  UPDATE vWEmployeeAndDeptDetails SET Name = 'John' WHERE ID = 1
--  Test 4:
UPDATE vWEmployeeAndDeptDetails SET Gender = 'Female' WHERE ID = 1
  -- To switch it back:
  UPDATE vWEmployeeAndDeptDetails SET Gender = 'Male' WHERE ID = 1
--  Test 5:
UPDATE vWEmployeeAndDeptDetails SET DeptName = 'IT' WHERE ID = 1
  -- To switch it back:
  UPDATE vWEmployeeAndDeptDetails SET DeptName = 'HR' WHERE ID = 1
-- Last Test:
UPDATE vWEmployeeAndDeptDetails SET Name = 'Joline', Gender = 'Female', 
DeptName = 'Payroll' WHERE ID = 1
  -- To switch it back:
  UPDATE vWEmployeeAndDeptDetails SET Name = 'John', Gender = 'Male', 
  DeptName = 'HR' WHERE ID = 1


-- Use to quickly check the updated changes:
SELECT * FROM vWEmployeeAndDeptDetails
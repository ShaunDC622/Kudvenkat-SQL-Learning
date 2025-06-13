-- After UPDATE DML trigger
------------------------------------------------------------------------------------------
-- *Make sure to have gone over part 43 introducing triggers and DML triggers 
--  in particular; it won't be repeated here.
------------------------------------------------------------------------------------------
SELECT * FROM tblEmployee5

CREATE TRIGGER tr_tblEmployee5_ForUpdate
ON tblemployee5
FOR UPDATE
AS
BEGIN
     SELECT * FROM deleted
	 SELECT * FROM inserted
END

UPDATE tblEmployee5 SET Name = 'Brock', Salary = 4900 WHERE ID = 6
-- Updating an entry in the table so that the trigger fires
UPDATE tblEmployee5 SET Name = 'Ben', Salary = 4800 WHERE ID = 6
-- Changing it back what it was before.
-------------------------------------------------------------------------------
-- *What we see and learn from this is that UPDATE statements are 
--  secretly DELETE and then INSERT statements bundled in a single statement.
------------------------------------------------------------------------------------------
-- Altering the trigger we just made with something more involved:
ALTER TRIGGER tr_tblEmployee5_ForUpdate
ON tblEmployee5
FOR UPDATE
AS
BEGIN
      -- Declare variables to hold old and updated data
      DECLARE @ID INT
      DECLARE @OldName NVARCHAR(20), @NewName NVARCHAR(20)
      DECLARE @OldSalary INT, @NewSalary INT
      DECLARE @OldGender NVARCHAR(20), @NewGender NVARCHAR(20)
      DECLARE @OldDeptID INT, @NewDeptID INT
     
      -- Variable to build the audit string
      DECLARE @AuditString NVARCHAR(1000)
      
      -- Load the updated records into a temporary table
      SELECT *
      INTO #TempTable
      FROM inserted
     
      -- Loop thru the records in temp table
      WHILE(EXISTS(SELECT ID FROM #TempTable))
      BEGIN
            --Initialize the audit string to empty string
            SET @AuditString = ''
           
            -- Select first row data from temp table
            SELECT TOP 1 @ID = ID, @NewName = Name,      -- TOP 1 helps select the first row
            @NewGender = Gender, @NewSalary = Salary,
            @NewDeptID = DepartmentID
            FROM #TempTable
           
            -- Select the corresponding row from deleted table
            SELECT @OldName = Name, @OldGender = Gender, 
            @OldSalary = Salary, @OldDeptID = DepartmentID
            FROM deleted WHERE ID = @ID
   
     -- Build the audit string dynamically           
            SET @AuditString = 'Employee with ID = ' + CAST(@ID AS NVARCHAR(4)) + ' changed'
            IF(@OldName <> @NewName)
                  SET @AuditString = @AuditString + ' NAME from ' + @OldName + ' to ' + @NewName
                 
            IF(@OldGender <> @NewGender)
                  SET @AuditString = @AuditString + ' GENDER from ' + @OldGender + ' to ' + @NewGender
                 
            IF(@OldSalary <> @NewSalary)
                  SET @AuditString = @AuditString + ' SALARY from ' + CAST(@OldSalary AS NVARCHAR(10))+ ' to ' + CAST(@NewSalary AS NVARCHAR(10))
                  
            IF(@OldDeptId <> @NewDeptId)
                  SET @AuditString = @AuditString + ' DepartmentID from ' + CAST(@OldDeptID AS NVARCHAR(10))+ ' to ' + CAST(@NewDeptID AS NVARCHAR(10))
           
		    -- Inserting into the Audit table the values put together in the AuditString
            INSERT INTO tblEmployee5Audit VALUES(@AuditString)
            
            -- Delete the row from temp table, so we can move to the next row
            DELETE FROM #TempTable WHERE ID = @ID -- if you don't include this, the while loop becomes infinite
      END -- end of while loop
END -- end of altering trigger
------------------------------------------------------------------------------------------
UPDATE tblEmployee5 SET Name = 'Brock', Salary = 4900 WHERE ID = 6
-- Updating an entry in the table so that the trigger fires
UPDATE tblEmployee5 SET Name = 'Ben', Salary = 4800 WHERE ID = 6
-- Changing it back what it was before.

SELECT * FROM tblEmployee5Audit
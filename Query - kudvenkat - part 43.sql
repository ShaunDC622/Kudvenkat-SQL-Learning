-- DML Triggers
----------------------------------------------------------------------------------------
-- *There are 3 types of triggers in SQL server:
--  1. DML triggers
--  2. DDL triggers
--  3. Logon triggers
-- *Triggers can be thought of as special kinds of stored procedures
----------------------------------------------------------------------------------------
-- *DML (Data Managment Language) triggers are fired automatically in response to DML events
--  (i.e. INSERT, UPDATE, and DELETE).
-- *DML triggers can be further classified into 2 types:
--  1. After triggers (sometimes referred to as FOR triggers)
--  2. INSTEAD OF triggers
-- *After triggers fire after the triggering action: the INSERT, UPDATE, and DELETE
--  statements cause an after trigger to fire after the respective statments complete 
--  execution.
-- *INSTEAD OF triggers fire instead of the triggering action: the INSERT, UPDATE, and DELETE
--  statements cause an INSTEAD OF trigger to fire instead of the repsective statement
--  execution.
----------------------------------------------------------------------------------------
-- After triggers
SELECT * FROM tblEmployee5
-----------------------------------------
UPDATE tblEmployee5
SET Salary = 3400
WHERE ID = 2
-----------------------------------------
CREATE TABLE tblEmployee5Audit
(
 ID INT IDENTITY(1,1) PRIMARY KEY,
 [Audit Data] NVARCHAR(1000)
)
----------------------------------------------------------------------------------------
-- Example of After INSERT trigger:
CREATE TRIGGER tr_tblEmployee5_ForInsert
ON tblEmployee5
FOR INSERT
AS
BEGIN
      DECLARE @ID INT
	  SELECT @ID = ID FROM inserted -- this is a special table used by triggers; only ever used in context of triggers 
	  
	  INSERT INTO tblEmployee5Audit
	  VALUES ('New employee with ID = ' + CAST(@ID AS NVARCHAR(5)) + 
	  ' is added at ' + CAST(GETDATE() AS NVARCHAR(20))
	         )
END
----------------------------------------------------------------------------------------
INSERT INTO tblEmployee5 VALUES (7, 'Jane', 1800, 'Female', 3)
INSERT INTO tblEmployee5 VALUES (8, 'Jimmy', 2700, 'Male', 1)

SELECT * FROM tblEmployee5
SELECT * FROM tblEmployee5Audit
----------------------------------------------------------------------------------------
-- Example of After DELETE trigger:
CREATE TRIGGER tr_tblEmployee5_ForDelete
ON tblEmployee5
FOR DELETE
AS
BEGIN
      DECLARE @ID INT
	  SELECT @ID = ID FROM deleted -- this is a special table used by triggers; only ever used in context of triggers 
	  
	  INSERT INTO tblEmployee5Audit
	  VALUES ('An existing employee with ID = ' + CAST(@ID AS NVARCHAR(5)) + 
	  ' is deleted at ' + CAST(GETDATE() AS NVARCHAR(20))
	         )
END
----------------------------------------------------------------------------------------
DELETE FROM tblEmployee5 WHERE ID = 7
DELETE FROM tblEmployee5 WHERE ID = 8

SELECT * FROM tblEmployee5
SELECT * FROM tblEmployee5Audit
----------------------------------------------------------------------------------------
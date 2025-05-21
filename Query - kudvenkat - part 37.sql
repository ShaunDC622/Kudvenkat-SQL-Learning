-- Unique and nonunique indexes
-------------------------------------------------------------------------------------------
-- *A unique index is used to enforce uniqueness of key values in the index.
-- *An example we have used often is the PRIMARY KEY constraint, which is a
--  unique and clustered index.
-- *Uniqueness is a property of an index; this means BOTH clustered and nonclustered indexes
--  CAN be unique.
--------------------------------------------------------------------------------------------
-- switch between CREATE and ALTER when applicable
CREATE TABLE tblEmployee3
(
ID INT PRIMARY KEY,
[First Name] NVARCHAR(50),
[Last Name] NVARCHAR(50),
Salary INT,
[Gender] NVARCHAR(10),
[City] NVARCHAR(50)
)
--------------------------------------------------------------------------------------------
sp_helpindex tblEmployee3
-- *The index description tells us the index we have is 'clustered', 'unique', and
--  a 'primary key' located on the 'ID' column.
-- *Notice that the key constraint and the index for this table are the same; the primary 
--  key constraint uses a unique index "behind the scenes".
--------------------------------------------------------------------------------------------
-- Let's try and drop the index and prove the previous point:
DROP INDEX tblEmployee3.PK__tblEmplo__3214EC2775C96426
-- *When you try to drop it, you get the following error message:
--  "An explicit DROP INDEX is not allowed on index 'tblEmployee3.PK__tblEmplo__3214EC2775C96426'.
--   It is being used for PRIMARY KEY constraint enforcement."
-- *This proves that P K uses unique index to enforce the constraint.
-- *If you try to delete the index using the object explorer in SSMS, you will succeed.
--  if you then refresh the "Keys" folder for the table, the key constraint will be gone too.
--------------------------------------------------------------------------------------------
-- Without the PRIMARY KEY constraint, let's try add values to the table with duplicate values:
INSERT INTO tblEmployee3 VALUES(1,'Mike', 'Sandoz',4500,'Male','New York')
INSERT INTO tblEmployee3 VALUES(1,'John', 'Menco',2500,'Male','London')

SELECT * FROM tblEmployee3
-- *Since there is no PRIMARY KEY constraint, there is no uniqueness constraint enforcement
--  on the ID column.
--------------------------------------------------------------------------------------------
-- Let's see an example of a constructed unique index on the first and last name of an employee:
CREATE UNIQUE NONCLUSTERED INDEX UIX_tblEmployee3_FirstName_LastName
ON tblEmployee3([First Name],[Last Name])
-- *The difference between Unique Constraint and Unique Index:
--  There are NO major differences; in fact, when you add a unique constraint, a unique index
--  get created automatically.
--------------------------------------------------------------------------------------------
-- Let's see this in practice by creating a new unique constraint on the City column:
ALTER TABLE tblEmployee3
ADD CONSTRAINT UQ_tblEmployee3_City 
UNIQUE (City)
-- *By checking the object explorer in SSMS, you will find both a unique constraint and 
--  corresponding unique, nonclustered index has been made.
--------------------------------------------------------------------------------------------
-- *Q: When should you create a Unique constraint over a unique index?
--  A: When data integrity is the objective.
-- *In other cases, the query optimiser doesn't differentiate between the two 
--  when data is being validated.
--------------------------------------------------------------------------------------------
-- *Some final notes:
--  1. By default, a PRIMARY KEY constraint, creates a UNIQUE, CLUSTERED index, where a UNIQUE
--    constraint creates a UNIQUE, NONCLUSTERED index. These defaults can be changed if you
--    wish.
--  2. A UNIQUE constraint (or index) cannot be created on an existing table if the
--     table already contains duplicate values in the key columns. To solve this, remove 
--     the key columns from the index definition or delete/update the duplicate values.

-- Clustered & Non-clustered indexes
--------------------------------------------------------------------------------------------
-- *Clustered index determines the physical order of data in a table.
-- *For this reason, a table can only have one clustered index.
--------------------------------------------------------------------------------------------
ALTER TABLE [tblEmployee2] -- switch between CREATE and ALTER when applicable
(
 [ID] INT PRIMARY KEY,
 [Name] NVARCHAR(50),
 [Salary] INT,
 [Gender] NVARCHAR(10),
 [City] NVARCHAR(50)
)
--------------------------------------------------------------------------------------------
-- When a primary key is created in a table, an automatic clustered index is created.
EXECUTE sp_helpindex tblEmployee2
-- The index description tells us the index we have is 'clustered', 'unique', and
-- a 'primary key' located on the 'ID' column.
--------------------------------------------------------------------------------------------
INSERT INTO tblEmployee2 VALUES(3,'John',4500,'Male','New York')
INSERT INTO tblEmployee2 VALUES(1,'Sam',2500,'Male','London')
INSERT INTO tblEmployee2 VALUES(4,'Sara',5500,'Female','Tokyo')
INSERT INTO tblEmployee2 VALUES(5,'Todd',3100,'Male','Toronto')
INSERT INTO tblEmployee2 VALUES(2,'Pam',6500,'Female','Sydney')
-- Note that the values for ID for each insert into the table is not in numerical order!!
--------------------------------------------------------------------------------------------
SELECT * FROM tblEmployee2
-- *However, since a primary key is a clustered index, it determines the PHYSICAL ORDER of
--  the data in the table ((b ^_^)b ! {{{SUPER IMPORTANT to understand for the importance of 
--  primary keys in general!}}}
--/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
-- *A clustered index is analogous to a phone directory where the data
--  is arranged by the last name. However, an index can contain multiple columns 
--  (i.e. a composite index), just like how a phone directory is organised by last 
--  and first name.
--\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
--------------------------------------------------------------------------------------------
-- Example of creating a clustered index:
-- **IMPORTANT NOTE: delete the primary key index first before attempting to make the 
--   clustered index below.
CREATE CLUSTERED INDEX IX_tblEmployee2_Gender_Salary
ON tblEmployee2(Gender DESC, Salary ASC)
-- We can test if the index has been created and working, we select the table it was created on:
SELECT * FROM tblEmployee2
-- *Notice now that the table is ordered first by Gender in descending order, THEN by Salary
--  in ascending order.
--------------------------------------------------------------------------------------------
-- *Non-clustered index is analogous to an index in a textbook: the data is stored in one
--  place and the index in another place.
-- *The index will have pointers to the storage location of the data.
-- *Since a non-clustered index is stored separately from the data, you can have multiple
--  non-clustered indexes.
-- *When you create an INDEX and you do not specify clustered or nonclustered, that index is 
--  automatically a nonclustered index.
--------------------------------------------------------------------------------------------
-- Example of creating a non-clustered index:
CREATE NONCLUSTERED INDEX IX_tblEmployee2_Name
ON tblEmployee2(Name)

SELECT Name FROM tblEmployee2
SELECT * FROM tblEmployee2
-- *Notice the difference between the results of the two selects:
--  i. the first one returns the Name only column using the nonclustered index specification
--  ii. the second one returns the entire table using the clustered index specification
-- *This result means that the clustered index specs is first considered over 
--  the nonclustered index specs. 
--------------------------------------------------------------------------------------------
-- !!COMMON INTERVIEW QUESTION!!: {{Differences between clustered and non-clustered index}}
-- *Only one clustered index per table, but you can have more than one non-clustered index.
-- *Clustered index is faster than a non-clustered index, because a non-clustered index
--  has to refer back to the table if the selected column is not present in the index.
-- *Clustered index determines the storage order of rows in the table, hence it doesn't
--  require additional disk space, whereas a non-clustered index is stored seperately
--  from the table, additional storage space is required.
--------------------------------------------------------------------------------------------
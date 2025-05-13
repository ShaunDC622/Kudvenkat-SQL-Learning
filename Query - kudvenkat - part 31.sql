-- Inline Table Valued (ITV) Functions
-------------------------------------------------------------------------------------
-- *Scalar functions return scalar values whereas ITV functions return tables.
--------------------------------------------------------------------------------------
CREATE TABLE tblEmployeesDates1
(
 ID INT PRIMARY KEY,
 Name NVARCHAR(50) NULL,
 DateOfBirth DATETIME NULL,
 Gender NVARCHAR(10) NULL,
 DepartmentID INT NULL
)

INSERT INTO tblEmployeesDates1 VALUES(1,'Sam','1980-12-30 00:00:00.000','Male',1)
INSERT INTO tblEmployeesDates1 VALUES(2,'Pam','1982-09-01 12:02:36.260','Female',2)
INSERT INTO tblEmployeesDates1 VALUES(3,'John','1985-08-22 12:03:30.370','Male',1)
INSERT INTO tblEmployeesDates1 VALUES(4,'Sara','1979-11-29 12:59:30.670','Female',3)
INSERT INTO tblEmployeesDates1 VALUES(5,'Todd','1978-11-29 12:59:30.670','Male',1)
-------------------------------------------------------------------------------------
SELECT * FROM tblEmployeesDates1
-------------------------------------------------------------------------------------
CREATE FUNCTION fnEmployeesByGender(@Gender NVARCHAR(10))
RETURNS TABLE
AS
RETURN (SELECT ID, Name, DateofBirth, Gender, DepartmentID
        FROM tblEmployeesDates1
		WHERE Gender = @Gender)
-- *Note that ITV functions use RETURN instead of BEGIN and END.
-- *The brackets after RETURN are not necessary; they are used for readability.

SELECT * FROM fnEmployeesByGender('Male')
SELECT * FROM fnEmployeesByGender('Female')
-------------------------------------------------------------------------------------
SELECT * FROM tblDepartment
-------------------------------------------------------------------------------------
-- Exercise: 
SELECT Name, Gender, DepartmentName  -- Names of columns that could be found in EITHER table
FROM fnEmployeesByGender('Male') E
LEFT JOIN tblDepartment D
ON E.DepartmentID = D.ID
--------------------------------------
SELECT Name, Gender, DepartmentName
FROM fnEmployeesByGender('Female') E
LEFT JOIN tblDepartment D
ON E.DepartmentID = D.ID
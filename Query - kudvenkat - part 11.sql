Create Table tblEmployee (
ID int Primary Key,
Name nvarchar(20),
Gender nvarchar(20),
Salary int,
City nvarchar (20),
)

INSERT INTO tblEmployee VALUES (1,'Tom','Male',4000,'London')
INSERT INTO tblEmployee VALUES (2,'Pam','Female',3000,'New York')
INSERT INTO tblEmployee VALUES (3,'John','Male',3500,'London')
INSERT INTO tblEmployee VALUES (4,'Sam','Male',4500,'London')
INSERT INTO tblEmployee VALUES (5,'Todd','Male',2800,'Sydney')
INSERT INTO tblEmployee VALUES (6,'Ben','Male',7000,'New York')
INSERT INTO tblEmployee VALUES (7,'Sara','Female',4800,'Sydney')
INSERT INTO tblEmployee VALUES (8,'Valarie','Female',5500,'New York')
INSERT INTO tblEmployee VALUES (9,'James','Male',6500,'London')
INSERT INTO tblEmployee VALUES (10,'Russell','Male',8800,'London')

SELECT * FROM tblEmployee

Select SUM(Salary) FROM tblEmployee

Select MIN(Salary) FROM tblEmployee

Select MAX(Salary) FROM tblEmployee

Select COUNT(ID) FROM tblEmployee

SELECT City, SUM(Salary) AS 'Total Salary' FROM tblEmployee GROUP BY City

SELECT Gender, City, SUM(Salary) AS 'Total Salary' 
FROM tblEmployee 
GROUP BY Gender, City
ORDER BY City

SELECT Gender, City, SUM(Salary) AS [Total Salary], COUNT(ID) as [Total Employees] 
FROM tblEmployee 
GROUP BY Gender, City
ORDER BY City

SELECT Gender, City, SUM(Salary) AS [Total Salary], COUNT(ID) as [Total Employees] 
FROM tblEmployee
WHERE Gender = 'Male'
GROUP BY Gender, City
ORDER BY City
-- This is query is more efficient than the query below: it filters first
-- (i.e. reducing the amount of rows) and then aggregations.

SELECT Gender, City, SUM(Salary) AS [Total Salary], COUNT(ID) as [Total Employees] 
FROM tblEmployee
GROUP BY Gender, City
HAVING Gender = 'Male'
ORDER BY City

SELECT Gender, City, SUM(Salary) AS [Total Salary], COUNT(ID) as [Total Employees] 
FROM tblEmployee
GROUP BY Gender, City
HAVING SUM(Salary) > 5000
-- HAVING can have an aggregate call whereas WHERE cannot. 
-- [THIS IS AN INTERVIEW QUESTION]
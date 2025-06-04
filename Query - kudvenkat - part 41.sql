-- Indexed Views
------------------------------------------------------------------------------------------
-- *A standard (or non-indexed view) is a stored SQL query; when we try to retrieve 
--  data from the view, the data is retrieced according to the underlying base tables.
-- *This means a view is just a virtual table; it does not store any data by default.
-- *However, when creating an index on a view, it gets materialised, i.e. its data is
--  capable of getting stored.
-- *In SQL Server, we call them Indexed Views, whereas in Oracle, 
--  they are called Materialised Views.
------------------------------------------------------------------------------------------
CREATE TABLE tblProduct
(
 [Product ID] INT PRIMARY KEY,
 [Name] NVARCHAR(20),
 [Unit Price] INT
)
-----------------------------------------------
INSERT INTO tblProduct VALUES(1, 'Books', 20)
INSERT INTO tblProduct VALUES(2, 'Pens', 14)
INSERT INTO tblProduct VALUES(3, 'Pencils', 11)
INSERT INTO tblProduct VALUES(4, 'Clips', 10)
-----------------------------------------------
CREATE TABLE tblProductSales
(
 [Product ID] INT,
 [Quantity Sold] INT
)
-----------------------------------------------
INSERT INTO tblProductSales VALUES(1, 10)
INSERT INTO tblProductSales VALUES(3, 23)
INSERT INTO tblProductSales VALUES(4, 21)
INSERT INTO tblProductSales VALUES(2, 12)
INSERT INTO tblProductSales VALUES(1, 13)
INSERT INTO tblProductSales VALUES(3, 12)
INSERT INTO tblProductSales VALUES(4, 13)
INSERT INTO tblProductSales VALUES(1, 11)
INSERT INTO tblProductSales VALUES(2, 12)
INSERT INTO tblProductSales VALUES(1, 14)
-----------------------------------------------
SELECT * FROM tblProduct
SELECT * FROM tblProductSales
---------------------------------------------------------------------------------------------------
CREATE VIEW vWTotalSalesByProduct
WITH SCHEMABINDING -- to prevent baseline tables data from being changed when a view is altered
AS
SELECT Name,
SUM(ISNULL(([Quantity Sold]*[Unit Price]), 0)) AS [Total Sales],
COUNT_BIG(*) AS [Total Transactions] -- since view is aggregated by GROUP BY, COUNT_BIG is used
FROM dbo.tblProductSales AS PS -- "dbo." is needed for the schema binding
INNER JOIN dbo.tblProduct AS P -- INNER JOIN has to be used for an index to be created
ON P.[Product ID] = PS.[Product ID]
GROUP BY NAME
---------------------------------------------------------------------------------------------------
SELECT * FROM vWTotalSalesByProduct
---------------------------------------------------------------------------------------------------
CREATE UNIQUE CLUSTERED INDEX UIX_vWTotalSalesByProduct_Name
ON vWTotalSalesByProduct ([Name])
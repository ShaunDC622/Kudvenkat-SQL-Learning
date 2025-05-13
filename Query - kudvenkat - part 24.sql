-- String Functions Continued --
------------------------------------------------------------------------------
-- REPLICATE
-- SPACE
-- PATINDEX
-- REPLACE
-- STUFF
------------------------------------------------------------------------------
PRINT REPLICATE('Test ',3)
-- * Returns a replication of the provided string according the number of times
-- requested.
PRINT REPLICATE('*',5)
PRINT REPLICATE('-',218)
PRINT REPLICATE('*',5)
------------------------------------------------------------------------------
-- Exercise:
SELECT FirstName, LastName,
       SUBSTRING(Email, 1, 2) + REPLICATE('*',5) +
	   SUBSTRING(EMAIL, CHARINDEX('@',Email), LEN(Email)-CHARINDEX('@',Email)+1)
	   AS [Email]
FROM tblEmployee5
------------------------------------------------------------------------------
PRINT 'Legend-' + '    ' + '-ary!'
PRINT 'Legend-' + SPACE(4) + '-ary!'
-- * SPACE(#) returns the amount of space characters you select.
-- * It is a more efficient way of creating spaces especially when creating
--   large amounts of space.
------------------------------------------------------------------------------
-- Exercise:
SELECT FirstName + SPACE(3) + LastName AS [Full Name]
FROM tblEmployee5
------------------------------------------------------------------------------
PRINT PATINDEX('%Bye%','HelloByeHelloBye')
-- * Returns the starting position of the first occurence of a pattern from
--   the given expression
-- * If the returned result is 0, it means there is no occurence found of the pattern  
------------------------------------------------------------------------------
-- Exercise:
SELECT Email, PATINDEX('%@aaa.com',Email) AS [First Occurence]
FROM tblEmployee5
WHERE PATINDEX('%@aaa.com',Email) > 0
------------------------------------------------------------------------------
SELECT Email, PATINDEX('%@aaa.com',Email) AS [First Occurence]
FROM tblEmployee5
WHERE PATINDEX('%@aaa.com',Email) = 0
------------------------------------------------------------------------------
PRINT REPLACE('Hello World','World','Heaven')
-- * Returns the string provided after replacing the specified part 
--   with the replacement string.
------------------------------------------------------------------------------
-- Exercise:
SELECT Email, REPLACE(Email,'.com','.net') AS [Converted Email]
FROM tblEmployee5
------------------------------------------------------------------------------
PRINT STUFF('Hello',3,2,'ww')
-- * Returns the expression that has had it another expression stuffed into it
-- * The replaces parts of the original expression based on the starting
--   position and the length of the expression being replaced.
------------------------------------------------------------------------------
-- Exercise:
SELECT FirstName, LastName, Email, STUFF(Email, 2, 3, REPLICATE('*',5))
AS [Stuffed Email]
FROM tblEmployee5


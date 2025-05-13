-- String Functions
---------------------------------------------------------------------------------
-- Directory is: [Your Database] > Programmability > Functions 
-- > System Functions > String Functions
---------------------------------------------------------------------------------
SELECT * FROM tblEmployee4
---------------------------------------------------------------------------------
SELECT ASCII('@') 
-- Returns the ASCII code value of the first character in its argument
-- it is the inverse function of CHAR()
---------------------------------------------------------------------------------
SELECT CHAR(64) 
-- Returns the character for the provided ASCII code
-- it is the inverse function of ASCII()
---------------------------------------------------------------------------------
-- Exercise: Printing out the upper case Alphabet
SELECT ASCII('A')
--------------------
DECLARE @Start INT
SET @Start = 65
WHILE  (@Start <= 90)
BEGIN
    PRINT CHAR(@Start)
	SET @Start = @Start + 1
END
---------------------------------------------------------------------------------
-- Exercise: Printing out the lower case Alphabet
SELECT ASCII('a')
--------------------
DECLARE @Start INT
SET @Start = 97
WHILE  (@Start <= 122)
BEGIN
    PRINT CHAR(@Start)
	SET @Start = @Start + 1
END
---------------------------------------------------------------------------------
-- Exercise: Printing out the single digit number
SELECT ASCII('0')
--------------------
DECLARE @Start INT
SET @Start = 48
WHILE  (@Start <= 57)
BEGIN
    PRINT CHAR(@Start)
	SET @Start = @Start + 1
END
---------------------------------------------------------------------------------
SELECT '1    HELLO'
SELECT LTRIM('    HELLO') 
-- LTRIM is short for left trim; this means it removes/"trims" 
-- the blanks to the left of the expression provided in the argument.
---------------------------------------------------------------------------------
SELECT * FROM tblEmployee5
---------------------------------------------------------------------------------
SELECT LTRIM(FirstName) AS FirstName, MiddleName, LastName,
FirstName+' '+MiddleName+' '+LastName AS FullName
FROM tblEmployee5
---------------------------------------------------------------------------------
SELECT 'HELLO      1'
SELECT RTRIM('    HELLO') 
-- RTRIM is short for right trim; this means it removes/"trims" 
-- the blanks to the right of the expression provided in the argument.
---------------------------------------------------------------------------------
SELECT LTRIM(FirstName) AS FirstName, MiddleName, LastName,
RTRIM(LTRIM(FirstName))+' '+MiddleName+' '+LastName AS FullName
FROM tblEmployee5
---------------------------------------------------------------------------------
SELECT LOWER('A')
-- Returns the lower case of the experession in the argument.
---------------------------------------------------------------------------------
SELECT UPPER('a')
-- Returns the upper case of the experession in the argument.
---------------------------------------------------------------------------------
-- Example of both in action:
SELECT UPPER(LTRIM(FirstName)) AS FirstName, MiddleName, LOWER(LastName) AS LastName,
RTRIM(LTRIM(FirstName))+' '+MiddleName+' '+LastName AS FullName
FROM tblEmployee5
---------------------------------------------------------------------------------
SELECT REVERSE('abcde')
-- Returns the reverse of the string experession in the argument.
---------------------------------------------------------------------------------
-- Example:
SELECT REVERSE(UPPER(LTRIM(FirstName))) AS FirstName, MiddleName, LOWER(LastName) AS LastName,
RTRIM(LTRIM(FirstName))+' '+MiddleName+' '+LastName AS FullName
FROM tblEmployee5
---------------------------------------------------------------------------------
SELECT LEN('MISSISSIPPI')
-- Returns the length of the string experession in the argument.
-- It counts the blanks at the beginning of the expression, though.
-- However, it excludes the blanks at the end of the expression.
---------------------------------------------------------------------------------
-- Example:
SELECT RTRIM(LTRIM(FirstName)) AS [First Name], 
LEN(RTRIM(LTRIM(FirstName))) AS [Total Characters in FirstName]
FROM tblEmployee5

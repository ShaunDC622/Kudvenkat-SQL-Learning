-- String Functions Continued --
------------------------------------------------------------------------------
-- LEFT()
-- RIGHT()
-- CHARINDEX()
-- SUBSTRING()
------------------------------------------------------------------------------
PRINT LEFT('ABCDEF',3)
-- Returns the specified number of strings from the left of the given string.
------------------------------------------------------------------------------
PRINT RIGHT('ABCDEF',3)
-- Returns the specified number of strings from the right of the given string.
------------------------------------------------------------------------------
PRINT CHARINDEX('@','Sara@aaa.com')
PRINT CHARINDEX('@','Sara@aaa.com', 3)
-- * Returns the character string position in an expression provided.
-- * The last entry is the start position for the search and it can be
--   left blank and will select 1 by default
------------------------------------------------------------------------------
PRINT SUBSTRING('Sara@aaa.com',6,7)
-- * Returns part of a string of a given expression.
-- * It starts the substring at the given start point, i.e. it INCLUDES it.
------------------------------------------------------------------------------
-- Exercise --
PRINT SUBSTRING('Sara@aaa.com',CHARINDEX('@','Sara@aaa.com')+1,
      LEN('Sara@aaa.com')-CHARINDEX('@','Sara@aaa.com'))
------------------------------------------------------------------------------
-- Exercise --
SELECT SUBSTRING(Email,CHARINDEX('@',Email)+1,
      LEN(Email)-CHARINDEX('@',Email)) AS [Email Domain],
	  COUNT(Email) AS [Total]
FROM tblEmployee5
GROUP BY SUBSTRING(Email,CHARINDEX('@',Email)+1,
      LEN(Email)-CHARINDEX('@',Email))
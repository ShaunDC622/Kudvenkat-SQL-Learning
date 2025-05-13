-- Mathematical Functions in SQL Server
------------------------------------------------------------------------------------------
PRINT ABS(125)
PRINT ABS(-87125)
-- *Returns the absolute value of the argument.
------------------------------------------------------------------------------------------
PRINT CEILING(12.125)
PRINT CEILING(-87.678)
-- *Returns the next or same integer value; the integer to the right on the number line.
------------------------------------------------------------------------------------------
PRINT FLOOR(12.125)
PRINT FLOOR(-87.678)
-- *Returns the previous integer or same value; the integer to the left on the number line.
------------------------------------------------------------------------------------------
PRINT POWER(2,3)
PRINT POWER(2.0,-1)
PRINT POWER(2.333,2)
-- *Returns the exponent of base in the 1st argument with the power in the 2nd argument.
-- *If floats are used the result matches the decimal length in the base argument.
------------------------------------------------------------------------------------------
PRINT SQUARE(9)
PRINT SQUARE(-3)
-- Returns the square of the argument.
------------------------------------------------------------------------------------------
PRINT SQRT(9)
PRINT SQRT(48)
-- Returns the square root of the argument.
------------------------------------------------------------------------------------------
PRINT RAND()
-- Returns a random float that is less than 1.
PRINT RAND(5)
-- Always returns the same random seed it generated.
PRINT RAND()*100
-- Returns a random float that is between 0 and 100.
PRINT FLOOR(RAND()*100)
-- Returns a random integer that is between 0 and 100.
------------------------------------------------------------------------------------------
-- Exercise:
DECLARE @Counter INT -- declaring the variable @Counter that takes integer values
SET @Counter = 1 -- setting the variable to have the initial value of 1.
WHILE(@Counter <= 10) -- the condition for the loop to continue
BEGIN
      PRINT FLOOR(RAND() * 100) -- prints out a random integer between 0 and 100
	  SET @COUNTER = @COUNTER + 1 -- increases the variable value by 1; 
	  -- this, in combination with the while condition, ensures that 10 values will
	  -- be printed.
END
------------------------------------------------------------------------------------------
PRINT ROUND(485.1878,2)
PRINT ROUND(12.215784,2)
-- *Returns the rounded off value of the 1st argument to the number of decimal points
--  in the second argument.
-- *Notice that the result always matches the number of decimal places the 1st argument has.
PRINT ROUND(12.215784,2,1)
PRINT ROUND(89.5415,1,45)
-- *If you use a 3rd parameter, it will truncate instead of round.
-- *Using 0 in the 3rd parameter means to round, using non-zero means to truncate.
PRINT ROUND(212.215784,0)
PRINT ROUND(212.215784,-1)
PRINT ROUND(212.215784,-2)
-- *If you use a 0 or negative integer in the 2nd argument, it will round differently:
--  0 rounds it to the nearest unit, -1 rounds it to the nearest 10, -2 rounds it 
--  to the nearest hundred, and so on.

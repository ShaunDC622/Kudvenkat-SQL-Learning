-- DateTime Functions --  
----------------------------------------------------------------------------
SELECT GETDATE() AS 'GETDATE()'
-- Most commonly used.
SELECT CURRENT_TIMESTAMP AS 'CURRENT_TIMESTAMP'
-- ANSI SQL equivalent to GETDATE.
SELECT SYSDATETIME() AS 'SYSDATETIME()'
-- More fractional seconds precision.
SELECT SYSDATETIMEOFFSET() AS 'SYSDATETIMEOFFSET()'
-- More fractional seconds precision + time zone offset.
SELECT GETUTCDATE() AS 'GETUTCDATE()'
-- UTC Date and Time.
SELECT SYSUTCDATETIME() AS 'SYSUTCDATETIME()'
-- UTC Date and Time with more fractional seconds precision.
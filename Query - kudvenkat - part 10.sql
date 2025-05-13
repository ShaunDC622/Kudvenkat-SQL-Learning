Select * From tblPerson Where Name LIKE 'M%'

Select * FROM tblPerson Where Name LIKE '[MST]%'

Select * FROM tblPerson Where Name LIKE '[^MST]%'

Select * From tblPerson Where Email LIKE '%@%'

Select * From tblPerson Where Email LIKE '_@_.com'

Select * From tblPerson Where Email NOT LIKE '_@_.com'

Select * From tblPerson Where Age = 20 OR Age = 23 OR Age = 25

Select * From tblPerson Where Age IN (20,23,29)

Select * From tblPerson Where Age Between 20 AND 25

Select * From tblPerson Where GenderID != 3

Select Distinct Name, Email From tblPerson

Select * FROM tblPerson Where Email NOT LIKE '_@_.com' AND Age > 25

Select * FROM tblPerson Where (Email LIKE '_@_.com' OR Email LIKE '__@__.com') 
AND Age > 20

Select * FROM tblPerson ORDER BY Name ASC

Select * FROM tblPerson ORDER BY Name DESC

Select * FROM tblPerson ORDER BY Name DESC, Age ASC

Select TOP 5 * FROM tblPerson

Select TOP 5 GenderID,Age FROM tblPerson

Select TOP 30 Percent * FROM tblPerson

Select TOP 1 * FROM tblPerson ORDER BY Age DESC

SELECT * FROM tblPerson
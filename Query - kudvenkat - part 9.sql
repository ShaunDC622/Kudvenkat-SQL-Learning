Select * From tblPerson

Alter Table tblPerson
Add Constraint UQ_tblPerson_Email Unique(Email)

Insert Into tblPerson Values (15, 'XYZ', 'a@a.com', 1, 20)

Alter Table tblPerson
Drop Constraint UQ_tblPerson_Email
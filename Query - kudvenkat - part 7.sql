Delete From tblPerson1

DBCC CHECKIDENT(tblPerson1, RESEED, 0)

Select * From tblPerson1

Set Identity_Insert tblPerson1 OFF

Insert Into tblPerson1 Values('Martin')

Delete From tblPerson1 Where PersonID = 1
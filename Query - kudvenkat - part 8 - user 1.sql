--User 1

Insert Into Test2 Values('ZZZ')

Select SCOPE_IDENTITY()
Select @@IDENTITY
Select IDENT_CURRENT('Test2')

Insert Into Test1 Values ('X')

Select * From Test1
Select * From Test2

Create Trigger trForInsert On Test1 For Insert
As
Begin
Insert Into Test2 Values('YYYY')
End

Select SCOPE_IDENTITY()
Select @@IDENTITY

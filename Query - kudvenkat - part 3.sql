INSERT INTO tblPerson
VALUES (6,'Kirsty','k@k.com', NULL)

select * from tblPerson
----------------------------------------------
INSERT INTO tblGender
VALUES (3,'Unknown')

select * from tblGender
-----------------------------------------------
Alter table tblPerson 
add constraint tblPerson_GenderID_FK
FOREIGN KEY (GenderID) references tblGender(ID)
-- *Foreign keys are used to enforce database integrity, 
--  i.e. a FK in one table points to the PK in another table.
-- *The FK constraint prevents invalid data from being inserted into the FK column.
--  The values you enter into the FK column has to be one of the values contained 
--  in the table it points to.
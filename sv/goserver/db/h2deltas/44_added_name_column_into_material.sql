ALTER TABLE materials ADD COLUMN name varchar(255);

--//@UNDO

ALTER TABLE materials DROP COLUMN name;
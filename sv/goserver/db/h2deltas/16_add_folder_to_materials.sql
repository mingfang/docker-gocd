ALTER TABLE materials ADD COLUMN folder varchar(255);

--//@UNDO

ALTER TABLE materials DROP COLUMN folder;
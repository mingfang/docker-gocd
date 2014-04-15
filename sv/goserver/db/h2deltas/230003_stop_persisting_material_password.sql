ALTER TABLE materials DROP COLUMN password;

--//@UNDO

ALTER TABLE materials ADD COLUMN password VARCHAR(255);
ALTER TABLE modifiedFiles ALTER COLUMN fileName VARCHAR(1024);

--//@UNDO

ALTER TABLE modifiedFiles ALTER COLUMN fileName VARCHAR(255);
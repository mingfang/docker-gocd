ALTER TABLE materials ADD COLUMN serveralias VARCHAR(255);

--//@UNDO
ALTER TABLE materials DROP COLUMN serveralias;
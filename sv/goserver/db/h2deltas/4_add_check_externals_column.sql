ALTER TABLE materials ADD COLUMN checkExternals BOOLEAN DEFAULT false;

--//@UNDO

ALTER TABLE materials DROP COLUMN checkExternals;
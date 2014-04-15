ALTER TABLE modifications ADD COLUMN fromExternal BOOLEAN DEFAULT false;

--//@UNDO

ALTER TABLE modifications DROP COLUMN fromExternal;
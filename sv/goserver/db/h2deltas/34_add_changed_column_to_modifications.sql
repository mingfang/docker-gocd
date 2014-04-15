ALTER TABLE modifications ADD COLUMN changed BOOLEAN DEFAULT false;

--//@UNDO
ALTER TABLE modifications DROP COLUMN changed;

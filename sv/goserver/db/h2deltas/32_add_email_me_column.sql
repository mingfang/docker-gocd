ALTER TABLE usersettings ADD COLUMN emailme BOOLEAN DEFAULT false;

--//@UNDO

ALTER TABLE usersettings DROP COLUMN emailme;
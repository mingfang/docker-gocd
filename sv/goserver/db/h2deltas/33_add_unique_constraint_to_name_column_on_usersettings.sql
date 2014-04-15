ALTER TABLE usersettings ADD CONSTRAINT unique_name UNIQUE(name);

--//@UNDO
ALTER TABLE usersettings DROP CONSTRAINT unique_name;

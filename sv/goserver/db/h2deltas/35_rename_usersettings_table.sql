ALTER TABLE usersettings RENAME TO users;

--//@UNDO

ALTER TABLE users RENAME TO usersettings;
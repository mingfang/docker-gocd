ALTER TABLE serverBackups ADD COLUMN username VARCHAR_IGNORECASE(255);
--//@UNDO

ALTER TABLE serverBackups DROP COLUMN username;

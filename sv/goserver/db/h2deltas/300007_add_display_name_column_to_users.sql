ALTER TABLE users ADD COLUMN displayName VARCHAR(255);
UPDATE users SET displayName=name;

--//@UNDO

ALTER TABLE users DROP COLUMN displayName;

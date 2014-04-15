ALTER TABLE users ADD enabled boolean NOT NULL DEFAULT TRUE;

--//@UNDO

ALTER TABLE users DROP COLUMN enabled;

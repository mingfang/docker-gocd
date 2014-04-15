ALTER TABLE environmentVariables ADD COLUMN isSecure BOOLEAN DEFAULT false;

--//@UNDO

ALTER TABLE environmentVariables DROP COLUMN isSecure;
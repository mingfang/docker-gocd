ALTER TABLE stages ADD COLUMN createdTime TIMESTAMP;

--//@UNDO

ALTER TABLE stages DROP COLUMN createdTime;
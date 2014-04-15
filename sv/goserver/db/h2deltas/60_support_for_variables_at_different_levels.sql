
ALTER TABLE environmentVariables ADD entityType VARCHAR(100);
UPDATE environmentVariables SET entityType='Job';
ALTER TABLE environmentVariables ALTER COLUMN entityType SET NOT NULL;
ALTER TABLE environmentVariables ALTER COLUMN jobId RENAME TO entityId;

--//@UNDO

DELETE FROM environmentVariables WHERE entityType != 'Job';
ALTER TABLE environmentVariables DROP COLUMN entityType;
ALTER TABLE environmentVariables ALTER COLUMN entityId RENAME TO jobId;
ALTER TABLE luauState ADD COLUMN lastSuccessfulSyncAt TIMESTAMP;

--//@UNDO

ALTER TABLE luauState DROP COLUMN lastSuccessfulSyncAt;
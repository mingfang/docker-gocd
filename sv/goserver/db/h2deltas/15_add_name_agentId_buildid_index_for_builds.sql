-- this index is designed to improved the get duration sql, before it is 200ms, now it is 10ms.
CREATE INDEX idx_builds_agentId_stageid_name ON builds (NAME, AGENTUUID, STAGEID, STATE, RESULT);

--//@UNDO
DROP INDEX idx_builds_agentId_stageid_name IF EXISTS;

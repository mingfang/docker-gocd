CREATE INDEX IF NOT EXISTS idx_builds_stageId ON builds(stageId);

--//@UNDO

DROP INDEX idx_builds_stageId IF EXISTS;



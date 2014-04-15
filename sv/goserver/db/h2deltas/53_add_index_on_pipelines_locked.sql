
-- this index makes the "lockedPipeline" query faster (was causing sluggishness on Mingle Cruise)
CREATE INDEX idx_pipelines_locked ON pipelines(locked);

--//@UNDO

DROP INDEX IF EXISTS idx_pipelines_locked; 
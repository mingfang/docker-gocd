CREATE INDEX idx_builds_name_stage_id ON builds(name, stageid);

--//@UNDO

DROP INDEX idx_builds_name_stage_id;

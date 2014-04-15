CREATE INDEX IF NOT EXISTS idx_stages_pipelineId ON stages(pipelineid);
CREATE INDEX IF NOT EXISTS idx_resources_buildId ON resources(buildid);

--//@UNDO

DROP INDEX idx_stages_pipelineId IF EXISTS;
DROP INDEX idx_resources_buildId IF EXISTS;


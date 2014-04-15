CREATE INDEX idx_stages_name_pipelineId ON stages(name, pipelineId);

--//@UNDO
DROP INDEX idx_stages_name_pipelineId IF EXISTS;


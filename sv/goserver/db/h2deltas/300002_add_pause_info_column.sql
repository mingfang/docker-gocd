ALTER TABLE pipelineLabelCounts ADD COLUMN pause_cause VARCHAR(255);
ALTER TABLE pipelineLabelCounts ADD COLUMN pause_by VARCHAR(255);
ALTER TABLE pipelineLabelCounts ADD COLUMN paused BOOLEAN DEFAULT false;

--//@UNDO
ALTER TABLE pipelineLabelCounts DROP COLUMN paused;
ALTER TABLE pipelineLabelCounts DROP COLUMN pause_by;
ALTER TABLE pipelineLabelCounts DROP COLUMN pause_cause;

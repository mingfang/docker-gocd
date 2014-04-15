ALTER TABLE stages ADD CONSTRAINT unique_pipeline_id_name_counter UNIQUE(pipelineId, name, counter);

--//@UNDO

ALTER TABLE stages DROP CONSTRAINT unique_pipeline_id_name_counter;
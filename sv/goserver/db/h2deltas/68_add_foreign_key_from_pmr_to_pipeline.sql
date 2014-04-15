ALTER TABLE pipelineMaterialRevisions ADD CONSTRAINT fk_pmr_pipeline FOREIGN KEY (pipelineId) REFERENCES pipelines(id);

--//@UNDO

ALTER TABLE pipelineMaterialRevisions DROP CONSTRAINT fk_pmr_pipeline;
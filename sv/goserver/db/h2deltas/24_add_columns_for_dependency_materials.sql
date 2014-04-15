ALTER TABLE Materials ADD pipelineName VARCHAR(255);
ALTER TABLE Materials ADD stageName VARCHAR(255);

--//@UNDO

ALTER TABLE Materials DROP COLUMN pipelineName;
ALTER TABLE Materials DROP COLUMN stageName;

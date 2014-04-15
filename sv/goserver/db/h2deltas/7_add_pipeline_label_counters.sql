CREATE TABLE pipelineLabelCounts (
    id              BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
    pipelineName    VARCHAR(255),
    labelCount      BIGINT
);

ALTER TABLE pipelineLabelCounts ADD CONSTRAINT unique_pipeline_name UNIQUE (pipelineName);

-- Migrate existing pipeline label data to the new counter table

INSERT INTO pipelineLabelCounts (pipelineName, labelCount)
	(SELECT name, MAX(label) FROM pipelines GROUP BY name);


--//@UNDO

DROP TABLE pipelineLabelCounts IF EXISTS CASCADE;
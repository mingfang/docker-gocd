ALTER TABLE pipelines ADD COLUMN counter BIGINT;
CREATE INDEX idx_pipelines_name_counter ON pipelines( name, counter );

--//@UNDO

DROP INDEX idx_pipelines_name_counter;
ALTER TABLE pipelines DROP COLUMN counter;

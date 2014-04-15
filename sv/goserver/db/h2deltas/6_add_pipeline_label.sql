ALTER TABLE pipelines ADD COLUMN label VARCHAR(255);
CREATE INDEX idx_pipeline_label ON pipelines(label);

// Copy the values from a temp table to the new column
CREATE TABLE temp (label VARCHAR(255));
INSERT INTO temp (label) (SELECT id FROM pipelines);
UPDATE pipelines SET label = (SELECT label FROM temp WHERE temp.label = pipelines.id);
DROP TABLE temp;


--//@UNDO

DROP INDEX idx_pipeline_label IF EXISTS;
ALTER TABLE pipelines DROP COLUMN label;
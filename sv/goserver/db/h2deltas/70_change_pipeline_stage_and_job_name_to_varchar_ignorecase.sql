ALTER TABLE pipelines ALTER COLUMN name VARCHAR_IGNORECASE(255);
ALTER TABLE stages    ALTER COLUMN name VARCHAR_IGNORECASE(255);
ALTER TABLE builds    ALTER COLUMN name VARCHAR_IGNORECASE(255);

--//@UNDO

ALTER TABLE pipelines ALTER COLUMN name VARCHAR(255);
ALTER TABLE stages    ALTER COLUMN name VARCHAR(255);
ALTER TABLE builds    ALTER COLUMN name VARCHAR(255);

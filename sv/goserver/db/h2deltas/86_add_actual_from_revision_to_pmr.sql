-- This index helps speed up the pipeline graph compare queries, and is needed for quickly finding the nextModificationId in the Java migration below   
CREATE INDEX idx_modifications_materialid_id ON modifications(materialId,id);


ALTER TABLE pipelineMaterialRevisions ADD COLUMN actualFromRevisionId BIGINT;
ALTER TABLE pipelineMaterialRevisions ADD CONSTRAINT fk_pmr_actualFromRevisionId FOREIGN KEY (actualFromRevisionId) REFERENCES modifications;

CREATE TABLE DUMMY_TABLE_FOR_MIGRATION_86 (id int);

CREATE TRIGGER TRIGGER_86_FOR_STORY_4643 BEFORE SELECT ON DUMMY_TABLE_FOR_MIGRATION_86 CALL "com.thoughtworks.cruise.server.sqlmigration.Migration_86";

SELECT * FROM DUMMY_TABLE_FOR_MIGRATION_86;

DROP TRIGGER TRIGGER_86_FOR_STORY_4643;

DROP TABLE DUMMY_TABLE_FOR_MIGRATION_86;

ALTER TABLE pipelineMaterialRevisions ALTER COLUMN actualFromRevisionId BIGINT NOT NULL;

--//@UNDO

ALTER TABLE pipelineMaterialRevisions DROP CONSTRAINT fk_pmr_actualFromRevisionId;
ALTER TABLE pipelineMaterialRevisions DROP COLUMN actualFromRevisionId;

DROP INDEX idx_modifications_materialid_id;
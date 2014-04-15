ALTER TABLE pipelinematerialrevisions ADD scheduleTimeFromRevisionId BIGINT;
ALTER TABLE pipelinematerialrevisions ADD scheduleTimeToRevisionId BIGINT;

UPDATE pipelinematerialrevisions SET scheduleTimeFromRevisionId = fromRevisionId;
UPDATE pipelinematerialrevisions SET scheduleTimeToRevisionId = toRevisionId;

ALTER TABLE pipelineMaterialRevisions ADD CONSTRAINT fk_pmr_schedule_time_from_revision FOREIGN KEY (scheduleTimeFromRevisionId) REFERENCES modifications (id);
ALTER TABLE pipelineMaterialRevisions ADD CONSTRAINT fk_pmr_schedule_time_to_revision FOREIGN KEY (scheduleTimeToRevisionId) REFERENCES modifications (id);

ALTER TABLE pipelineMaterialRevisions ALTER COLUMN scheduleTimeFromRevisionId SET NOT NULL;
ALTER TABLE pipelineMaterialRevisions ALTER COLUMN scheduleTimeToRevisionId SET NOT NULL;


--//@UNDO

UPDATE pipelinematerialrevisions  SET fromRevisionId = scheduleTimeFromRevisionId;
UPDATE pipelinematerialrevisions SET toRevisionId = scheduleTimeToRevisionId;

ALTER TABLE pipelinematerialrevisions DROP CONSTRAINT fk_pmr_schedule_time_to_revision;
ALTER TABLE pipelinematerialrevisions DROP CONSTRAINT fk_pmr_schedule_time_from_revision;

ALTER TABLE pipelinematerialrevisions DROP COLUMN scheduleTimeToRevisionId;
ALTER TABLE pipelinematerialrevisions DROP COLUMN scheduleTimeFromRevisionId;

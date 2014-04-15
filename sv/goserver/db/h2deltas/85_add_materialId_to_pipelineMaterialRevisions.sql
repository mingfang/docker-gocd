ALTER TABLE pipelineMaterialRevisions ADD materialId BIGINT;
ALTER TABLE pipelineMaterialRevisions ADD CONSTRAINT fk_pmr_materialId FOREIGN KEY (materialId) REFERENCES materials;

UPDATE pipelineMaterialRevisions
  SET materialId = (SELECT mod.materialId FROM modifications mod WHERE toRevisionId = mod.id);

--//@UNDO

ALTER TABLE pipelineMaterialRevisions DROP CONSTRAINT fk_pmr_materialId;
ALTER TABLE pipelineMaterialRevisions DROP materialId;

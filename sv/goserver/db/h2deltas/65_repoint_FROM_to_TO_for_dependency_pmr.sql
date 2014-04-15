ALTER TABLE pipelineMaterialRevisions ADD materialType VARCHAR(255);

UPDATE pipelineMaterialRevisions pmr SET materialType = (SELECT m.type FROM modifications mods INNER JOIN materials m on mods.materialId = m.id WHERE mods.id = pmr.toRevisionId);

UPDATE pipelineMaterialRevisions SET fromRevisionId = toRevisionId, scheduleTimeFromRevisionId = scheduleTimeToRevisionId WHERE materialType = 'DependencyMaterial';

ALTER TABLE pipelineMaterialRevisions DROP COLUMN materialType;

--//@UNDO
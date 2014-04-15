ALTER TABLE modifications ADD materialType VARCHAR(255);
ALTER TABLE modifications ADD pipelineName VARCHAR(255);
ALTER TABLE modifications ADD pipelineCounter VARCHAR(255);

UPDATE modifications m1 SET materialType = (SELECT materials.type FROM modifications m2 INNER JOIN materials on m2.materialid = materials.id WHERE m1.id = m2.id);

UPDATE modifications SET
       pipelineName = REGEXP_REPLACE(revision, '\/.*', ''),
       pipelineCounter = REGEXP_REPLACE(REGEXP_REPLACE(revision, '^.*?\/', ''), '\/.*', '')
            WHERE materialType = 'DependencyMaterial' AND pipelineLabel IS NULL;

UPDATE modifications m SET m.pipelineLabel = (SELECT p.label FROM pipelines p WHERE p.name = m.pipelineName AND p.counter = m.pipelineCounter) WHERE pipelineCounter REGEXP('\d+') AND pipelineLabel IS NULL;

ALTER TABLE modifications DROP COLUMN materialType;
ALTER TABLE modifications DROP COLUMN pipelineName;
ALTER TABLE modifications DROP COLUMN pipelineCounter;

--//@UNDO
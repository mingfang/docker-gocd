ALTER TABLE modifications
ADD COLUMN materialId INTEGER;

-- associate modifications with materials

update modifications
SET materialId=
    (SELECT materials.id
    FROM materials
    JOIN pipelines
    ON materials.pipelineId=pipelines.id
    AND pipelines.id=modifications.pipelineId
    LIMIT 1);

CREATE INDEX idx_modifications_materialId ON modifications(materialId);
CREATE INDEX idx_modifications_modifiedtime ON modifications(modifiedtime);

-- copy modifications onto new materials for svn repos with multiple materials
-- this is for some number of historical pipelines that were created when
-- multiple materials support was not complete

INSERT INTO modifications(TYPE, USERNAME, COMMENT, EMAILADDRESS, REVISION, MODIFIEDTIME, PIPELINEID, FROMEXTERNAL, MATERIALID )
SELECT m1.TYPE, m1.USERNAME, m1.COMMENT, m1.EMAILADDRESS, m1.REVISION, m1.MODIFIEDTIME, m1.PIPELINEID, m1.FROMEXTERNAL, materials.ID
FROM modifications m1
JOIN materials on  m1.pipelineid = materials.pipelineid
WHERE not exists(select 1 from modifications where modifications.materialId = materials.id);

ALTER TABLE modifications
ALTER COLUMN materialId SET NOT NULL;

ALTER TABLE modifications
ADD CONSTRAINT fk_modifications_materials
FOREIGN KEY (materialId)
REFERENCES materials(id) ON DELETE CASCADE;

--//@UNDO

ALTER TABLE modifications DROP COLUMN materialId;




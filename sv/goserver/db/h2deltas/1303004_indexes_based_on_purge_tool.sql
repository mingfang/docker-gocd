CREATE INDEX IF NOT EXISTS idx_properties_buildId ON properties(buildId);
CREATE INDEX IF NOT EXISTS idx_materials_pipelinename ON materials(pipelinename);
CREATE INDEX IF NOT EXISTS idx_artifactpropertiesgenerator_jobid ON artifactpropertiesgenerator(jobid);
CREATE INDEX IF NOT EXISTS idx_environmentvariables_entitytype ON environmentvariables(entitytype);
CREATE INDEX IF NOT EXISTS idx_stageartifactcleanupprohibited_pipelinename ON stageartifactcleanupprohibited(pipelinename);
CREATE INDEX IF NOT EXISTS idx_pipelineLabelCounts_pipelinename ON pipelineLabelCounts(pipelinename);


--//@UNDO

DROP INDEX idx_properties_buildId IF EXISTS;
DROP INDEX idx_materials_pipelinename IF EXISTS;
DROP INDEX idx_artifactpropertiesgenerator_jobid IF EXISTS;
DROP INDEX idx_environmentvariables_entitytype IF EXISTS;
DROP INDEX idx_stageartifactcleanupprohibited_pipelinename IF EXISTS;
DROP INDEX idx_pipelineLabelCounts_pipelinename IF EXISTS;


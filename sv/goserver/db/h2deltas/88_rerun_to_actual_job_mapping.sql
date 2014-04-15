ALTER TABLE builds ADD COLUMN originalJobId BIGINT;
ALTER TABLE builds ADD COLUMN rerun BOOLEAN DEFAULT false NOT NULL;
ALTER TABLE stages ADD COLUMN rerunJobs BOOLEAN DEFAULT false NOT NULL;

-- recreate the view since H2 does not automatically include new columns into views

DROP VIEW _builds;

CREATE VIEW _builds AS
SELECT b.*,
  p.id pipelineId, p.name pipelineName, p.label pipelineLabel, p.counter pipelineCounter,
  s.name stageName, s.counter stageCounter, s.fetchMaterials, s.cleanWorkingDir
FROM builds b
  INNER JOIN stages s ON s.id = b.stageId
  INNER JOIN pipelines p ON p.id = s.pipelineId;

DROP VIEW _stages;

CREATE VIEW _stages AS
SELECT s.*,
  p.name pipelineName, p.buildCauseType, p.buildCauseBy, p.label pipelineLabel, p.buildCauseMessage, p.counter pipelineCounter, p.locked, p.naturalOrder
FROM stages s
  INNER JOIN pipelines p ON p.id = s.pipelineId;


--//@UNDO

DROP VIEW _stages;

DROP VIEW _builds;

ALTER TABLE stages DROP COLUMN rerunJobs;
ALTER TABLE builds DROP COLUMN rerun;
ALTER TABLE builds DROP COLUMN originalJobId;

CREATE VIEW _stages AS
SELECT s.*,
  p.name pipelineName, p.buildCauseType, p.buildCauseBy, p.label pipelineLabel, p.buildCauseMessage, p.counter pipelineCounter, p.locked, p.naturalOrder
FROM stages s
  INNER JOIN pipelines p ON p.id = s.pipelineId;

CREATE VIEW _builds AS
SELECT b.*,
  p.id pipelineId, p.name pipelineName, p.label pipelineLabel, p.counter pipelineCounter,
  s.name stageName, s.counter stageCounter, s.fetchMaterials, s.cleanWorkingDir
FROM builds b
  INNER JOIN stages s ON s.id = b.stageId
  INNER JOIN pipelines p ON p.id = s.pipelineId;
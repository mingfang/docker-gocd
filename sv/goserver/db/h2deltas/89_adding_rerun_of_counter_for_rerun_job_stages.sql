DROP VIEW _stages;
DROP VIEW _builds;

ALTER TABLE stages ADD COLUMN rerunOfCounter INT;

UPDATE stages SET rerunOfCounter = (SELECT counter FROM stages AS self WHERE self.name = stages.name and self.counter < stages.counter and self.pipelineid = stages.pipelineid and self.rerunjobs = false order by self.counter desc limit 1) where stages.rerunjobs = true;

ALTER TABLE stages DROP COLUMN rerunJobs;

CREATE VIEW _builds AS
SELECT b.*,
  p.id pipelineId, p.name pipelineName, p.label pipelineLabel, p.counter pipelineCounter,
  s.name stageName, s.counter stageCounter, s.fetchMaterials, s.cleanWorkingDir, s.rerunOfCounter
FROM builds b
  INNER JOIN stages s ON s.id = b.stageId
  INNER JOIN pipelines p ON p.id = s.pipelineId;

CREATE VIEW _stages AS
SELECT s.*,
  p.name pipelineName, p.buildCauseType, p.buildCauseBy, p.label pipelineLabel, p.buildCauseMessage, p.counter pipelineCounter, p.locked, p.naturalOrder
FROM stages s
  INNER JOIN pipelines p ON p.id = s.pipelineId;

--//@UNDO

DROP VIEW _stages;
DROP VIEW _builds;

ALTER TABLE stages ADD COLUMN rerunJobs BOOLEAN DEFAULT false NOT NULL;

UPDATE stages SET rerunjobs = true WHERE rerunOfCounter IS NOT NULL;

ALTER TABLE stages DROP COLUMN rerunOfCounter;

CREATE VIEW _builds AS
SELECT b.*,
  p.id pipelineId, p.name pipelineName, p.label pipelineLabel, p.counter pipelineCounter,
  s.name stageName, s.counter stageCounter, s.fetchMaterials, s.cleanWorkingDir
FROM builds b
  INNER JOIN stages s ON s.id = b.stageId
  INNER JOIN pipelines p ON p.id = s.pipelineId;

CREATE VIEW _stages AS
SELECT s.*,
  p.name pipelineName, p.buildCauseType, p.buildCauseBy, p.label pipelineLabel, p.buildCauseMessage, p.counter pipelineCounter, p.locked, p.naturalOrder
FROM stages s
  INNER JOIN pipelines p ON p.id = s.pipelineId;

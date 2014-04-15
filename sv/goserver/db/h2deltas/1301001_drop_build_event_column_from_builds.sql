DROP VIEW _builds;

ALTER TABLE builds DROP COLUMN buildEvent;

CREATE VIEW _builds AS
SELECT b.*,
  p.id pipelineId, p.name pipelineName, p.label pipelineLabel, p.counter pipelineCounter,
  s.name stageName, s.counter stageCounter, s.fetchMaterials, s.cleanWorkingDir, s.rerunOfCounter, s.artifactsDeleted
FROM builds b
  INNER JOIN stages s ON s.id = b.stageId
  INNER JOIN pipelines p ON p.id = s.pipelineId;

--//@UNDO

ALTER TABLE builds ADD COLUMN buildEvent LONGVARCHAR;

DROP VIEW _builds;
CREATE VIEW _builds AS
SELECT b.*,
  p.id pipelineId, p.name pipelineName, p.label pipelineLabel, p.counter pipelineCounter,
  s.name stageName, s.counter stageCounter, s.fetchMaterials, s.cleanWorkingDir, s.rerunOfCounter, s.artifactsDeleted
FROM builds b
  INNER JOIN stages s ON s.id = b.stageId
  INNER JOIN pipelines p ON p.id = s.pipelineId;
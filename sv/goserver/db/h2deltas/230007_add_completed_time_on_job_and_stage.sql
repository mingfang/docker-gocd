ALTER TABLE stages ADD COLUMN lastTransitionedTime TIMESTAMP;

DROP VIEW _builds;

DROP VIEW _stages;

CREATE VIEW _builds AS
SELECT b.*,
  p.id pipelineId, p.name pipelineName, p.label pipelineLabel, p.counter pipelineCounter,
  s.name stageName, s.counter stageCounter, s.fetchMaterials, s.cleanWorkingDir, s.rerunOfCounter, s.artifactsDeleted
FROM builds b
  INNER JOIN stages s ON s.id = b.stageId
  INNER JOIN pipelines p ON p.id = s.pipelineId;

CREATE VIEW _stages AS
SELECT s.*,
  p.name pipelineName, p.buildCauseType, p.buildCauseBy, p.label pipelineLabel, p.buildCauseMessage, p.counter pipelineCounter, p.locked, p.naturalOrder
FROM stages s
  INNER JOIN pipelines p ON p.id = s.pipelineId;

MERGE INTO stages (id, lastTransitionedTime) KEY(id) (
  SELECT s.id as id, bst.stateChangeTime as lastTransitionedTime
  FROM stages s
  INNER JOIN buildStateTransitions bst on s.completedByTransitionId = bst.id
);

CREATE TRIGGER lastTransitionedTimeUpdate AFTER INSERT ON buildStateTransitions FOR EACH ROW CALL "com.thoughtworks.cruise.server.sqlmigration.Migration_230007";

--//@UNDO

DROP TRIGGER lastTransitionedTimeUpdate;

ALTER TABLE STAGES DROP COLUMN lastTransitionedTime;

DROP VIEW _builds;

DROP VIEW _stages;

CREATE VIEW _builds AS
SELECT b.*,
  p.id pipelineId, p.name pipelineName, p.label pipelineLabel, p.counter pipelineCounter,
  s.name stageName, s.counter stageCounter, s.fetchMaterials, s.cleanWorkingDir, s.rerunOfCounter, s.artifactsDeleted
FROM builds b
  INNER JOIN stages s ON s.id = b.stageId
  INNER JOIN pipelines p ON p.id = s.pipelineId;

CREATE VIEW _stages AS
SELECT s.*,
  p.name pipelineName, p.buildCauseType, p.buildCauseBy, p.label pipelineLabel, p.buildCauseMessage, p.counter pipelineCounter, p.locked, p.naturalOrder
FROM stages s
  INNER JOIN pipelines p ON p.id = s.pipelineId;

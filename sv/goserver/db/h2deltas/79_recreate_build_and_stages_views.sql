
-- recreate the view from 72_create_builds_view.sql and 73_create_stages_view.sql since H2 does not automatically include new columns into views

DROP VIEW _builds;

CREATE VIEW _builds AS
SELECT b.*,
  p.id pipelineId, p.name pipelineName, p.label pipelineLabel, p.counter pipelineCounter,
  s.name stageName, s.counter stageCounter, s.fetchMaterials
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

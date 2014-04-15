CREATE VIEW _builds AS
SELECT b.*,
  p.id pipelineId, p.name pipelineName, p.label pipelineLabel, p.counter pipelineCounter,
  s.name stageName, s.counter stageCounter
FROM builds b
  INNER JOIN stages s ON s.id = b.stageId
  INNER JOIN pipelines p ON p.id = s.pipelineId;

--//@UNDO

DROP VIEW _builds;
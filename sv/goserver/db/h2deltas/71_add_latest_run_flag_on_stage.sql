ALTER TABLE stages ADD latestRun boolean NOT NULL DEFAULT FALSE;
CREATE TABLE tmpStage AS (SELECT MAX(id) id FROM stages GROUP BY pipelineId, name);
MERGE INTO stages (id, latestRun) KEY(id) SELECT id, true FROM tmpStage;
DROP TABLE tmpStage;

CREATE INDEX idx_stages_name_latestRun_result ON stages(name, latestRun, result);

--//@UNDO

DROP INDEX idx_stages_name_latestRun_result;
ALTER TABLE stages DROP COLUMN latestRun;

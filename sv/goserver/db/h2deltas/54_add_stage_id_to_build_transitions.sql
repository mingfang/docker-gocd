ALTER TABLE buildstatetransitions ADD COLUMN stageId BIGINT;

update buildstatetransitions set stageId=(select stageId from builds where id=buildstatetransitions.buildId);

ALTER TABLE buildstatetransitions ADD CONSTRAINT fk_buildtransitions_stages FOREIGN KEY (stageId) REFERENCES stages(id);

--//@UNDO

ALTER TABLE buildstatetransitions DROP CONSTRAINT IF EXISTS fk_buildtransitions_stages;

ALTER TABLE buildstatetransitions DROP COLUMN stageId;
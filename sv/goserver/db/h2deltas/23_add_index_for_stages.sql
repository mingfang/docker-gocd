ALTER TABLE stages ADD COLUMN counter INTEGER;
CREATE INDEX idx_stages_counter_index ON stages(counter);
update stages SET counter = (SELECT Count(*)  FROM stages s2 where s2.pipelineid = stages.pipelineid AND s2.name = stages.name AND s2.id<=stages.id);
ALTER TABLE stages ALTER COLUMN counter SET NOT NULL;


--//@UNDO
DROP INDEX idx_stages_counter_index IF EXISTS;
ALTER TABLE stages DROP COLUMN counter;

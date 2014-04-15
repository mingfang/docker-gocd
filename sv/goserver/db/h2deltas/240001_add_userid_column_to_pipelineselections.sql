ALTER TABLE pipelineselections ADD COLUMN userId BIGINT(19);
ALTER TABLE  pipelineselections ADD CONSTRAINT fk_pipelineselections_userid FOREIGN KEY(userid) REFERENCES users(id) ON DELETE CASCADE;

--//@UNDO
ALTER TABLE pipelineselections DROP CONSTRAINT fk_pipelineselections_userid;
ALTER TABLE pipelineselections DROP COLUMN userId;


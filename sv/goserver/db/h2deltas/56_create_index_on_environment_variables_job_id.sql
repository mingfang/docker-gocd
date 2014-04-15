
CREATE INDEX idx_env_job_id ON environmentVariables (jobId);

--//@UNDO

DROP INDEX IF EXISTS idx_env_job_id;
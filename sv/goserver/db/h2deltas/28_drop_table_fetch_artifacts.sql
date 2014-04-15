DROP TABLE fetchArtifactPlans IF EXISTS CASCADE;

--//@UNDO
CREATE TABLE fetchArtifactPlans (
id BIGINT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
jobId           BIGINT,
pipelineLabel   VARCHAR(255),
pipeline        VARCHAR(255),
stage           VARCHAR(255),
job             VARCHAR(255),
path            VARCHAR(255),
dest            VARCHAR(255)
);


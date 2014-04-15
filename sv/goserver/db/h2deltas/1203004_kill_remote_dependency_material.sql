ALTER TABLE materials DROP COLUMN serveralias;

SET @delimiter = '<|>';

UPDATE materials SET
    fingerprint = HASH('SHA256', STRINGTOUTF8(concat('type=', type, @delimiter, 'pipelineName=', pipelineName, @delimiter, 'stageName=', stageName)), 1)
    WHERE type = 'DependencyMaterial';

--//@UNDO

ALTER TABLE materials ADD COLUMN serveralias VARCHAR(255);

SET @delimiter = '<|>';

UPDATE materials SET
    fingerprint = HASH('SHA256', STRINGTOUTF8(concat('type=', type, @delimiter, 'pipelineName=', pipelineName, @delimiter, 'stageName=', stageName, @delimiter, 'serverAlias=null')), 1)
    WHERE type = 'DependencyMaterial';


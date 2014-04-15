SET @delimiter = '<|>';

UPDATE materials SET
    fingerprint = HASH('SHA256', STRINGTOUTF8(concat('type=', type, @delimiter, 'pipelineName=', pipelineName, @delimiter, 'stageName=', stageName, @delimiter, 'serverAlias=null')), 1)
    WHERE type = 'DependencyMaterial' AND serverAlias IS null;

--//@UNDO

--//no undo required because it makes fingerprints invalid
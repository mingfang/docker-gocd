SET @delimiter = '<|>';

UPDATE materials
    SET branch = 'master',
        fingerprint = HASH('SHA256', STRINGTOUTF8(concat('type=', type, @delimiter, 'url=', url, @delimiter, 'branch=', branch) ), 1)
    WHERE
        type = 'GitMaterial' AND
        branch IS null;

--//@UNDO


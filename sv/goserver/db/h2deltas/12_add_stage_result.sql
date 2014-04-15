ALTER TABLE Stages ADD result VARCHAR(50);

UPDATE stages
SET result='Cancelled'
WHERE exists
    (select *
    from builds
    where builds.stageId = stages.id
    and builds.result ='Cancelled')           
AND stages.result is null;

UPDATE stages
SET result='Failed'
WHERE exists
    (select *
    from builds
    where builds.stageId = stages.id
    and builds.result ='Failed')
AND stages.result is null;

UPDATE stages
SET result='Unknown'
WHERE exists
    (select *
    from builds
    where builds.stageId = stages.id
    and builds.result ='Unknown')
AND stages.result is null;

UPDATE stages
SET result='Passed'
WHERE stages.result is null;

ALTER TABLE stages
ALTER COLUMN result
SET DEFAULT 'Unknown';

ALTER TABLE stages
ALTER COLUMN result
SET NOT NULL;

--//@UNDO

ALTER TABLE stages DROP result;

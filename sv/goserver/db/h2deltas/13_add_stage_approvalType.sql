ALTER TABLE stages ADD COLUMN approvalType VARCHAR(255);

//a stage's approvalType should be decided by the approvedBy of the first stage instance in a pipeline
UPDATE stages a SET a.approvalType = 'success' WHERE
    'cruise' = (SELECT TOP 1 b.approvedBy FROM stages b WHERE b.name = a.name AND b.pipelineId = a.pipelineId ORDER BY b.id ASC);

UPDATE stages SET approvalType = 'manual' WHERE approvalType != 'success';

--//@UNDO

ALTER TABLE stages DROP COLUMN approvalType;

ALTER TABLE stages ADD COLUMN completedByTransitionId BIGINT;

UPDATE stages SET completedByTransitionId = -1 WHERE id IN
    (SELECT DISTINCT b.stageid FROM builds b WHERE state <> 'Completed' and state <> 'Rescheduled');

CREATE INDEX idx_stages_completedByTransitionId ON stages (completedByTransitionId DESC);

UPDATE stages SET completedByTransitionId =
    (SELECT MAX(bst.id) FROM buildstatetransitions bst WHERE bst.stageid = stages.id) WHERE completedByTransitionId IS null;

UPDATE stages SET completedByTransitionId = null WHERE completedByTransitionId = -1;

--//@UNDO

DROP INDEX IF EXISTS idx_stages_completedByTransitionId;

ALTER TABLE stages DROP COLUMN completedByTransitionId;
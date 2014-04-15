CREATE INDEX idx_bst_buildid_currentstate ON buildstatetransitions(buildid, currentstate);

--//@UNDO
DROP INDEX idx_bst_buildid_currentstate IF EXISTS;
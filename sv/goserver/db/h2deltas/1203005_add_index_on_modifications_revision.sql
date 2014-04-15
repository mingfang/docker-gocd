CREATE INDEX idx_modifications_revision ON modifications(revision);
--//@UNDO
DROP INDEX idx_modifications_revision IF EXISTS;
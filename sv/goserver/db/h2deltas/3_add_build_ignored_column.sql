ALTER TABLE builds ADD COLUMN ignored BOOLEAN DEFAULT false;
CREATE INDEX idx_build_ignored ON builds (ignored);

--//@UNDO

DROP INDEX idx_build_ignored;
ALTER TABLE builds DROP COLUMN ignored;
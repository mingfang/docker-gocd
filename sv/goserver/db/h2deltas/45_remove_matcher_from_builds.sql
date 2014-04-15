ALTER TABLE builds DROP COLUMN matcher;

--//@UNDO

ALTER TABLE builds ADD COLUMN matcher VARCHAR(4000);
UPDATE TABLE builds SET matcher = "com.thoughtworks.cruise.domain.BuildOutputMatcher";
ALTER TABLE pipelines ADD locked BOOLEAN DEFAULT false NOT NULL;

--//@UNDO

ALTER TABLE pipelines DROP COLUMN locked;

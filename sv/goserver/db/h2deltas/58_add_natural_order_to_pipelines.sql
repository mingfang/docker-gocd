
ALTER TABLE pipelines ADD naturalOrder DOUBLE DEFAULT 0.0 NOT NULL;

--//@UNDO

ALTER TABLE pipelines DROP COLUMN naturalOrder;
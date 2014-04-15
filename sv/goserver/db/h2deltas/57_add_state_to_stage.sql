
ALTER TABLE stages ADD state VARCHAR(50) DEFAULT 'Unknown' NOT NULL;
UPDATE stages SET state = result;

--//@UNDO

ALTER TABLE stages DROP state;
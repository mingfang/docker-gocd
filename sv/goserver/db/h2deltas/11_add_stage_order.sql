ALTER TABLE stages ADD COLUMN orderId INTEGER;
CREATE INDEX idx_stages_orderId ON stages(orderId);
UPDATE stages SET orderId = CONVERT(id, INTEGER);

--//@UNDO

DROP INDEX idx_stages_orderId IF EXISTS;
ALTER TABLE stages DROP COLUMN orderId;
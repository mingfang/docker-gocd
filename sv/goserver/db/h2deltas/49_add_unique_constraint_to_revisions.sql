ALTER TABLE modifications ADD CONSTRAINT unique_revision UNIQUE (materialId, revision);


--//@UNDO

-- we don't support undo for this 

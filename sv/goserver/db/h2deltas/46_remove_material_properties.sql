ALTER TABLE materials ADD COLUMN branch TEXT;
UPDATE materials SET branch = (SELECT props.value FROM MaterialProperties props WHERE props.materialId = materials.id AND props.key = 'branch');

ALTER TABLE materials ADD COLUMN submoduleFolder TEXT;
UPDATE materials SET submoduleFolder = (SELECT props.value FROM MaterialProperties props WHERE props.materialId = materials.id AND props.key = 'submoduleFolder');

ALTER TABLE materials ADD COLUMN useTickets VARCHAR(10);
UPDATE materials SET useTickets = (SELECT props.value FROM MaterialProperties props WHERE props.materialId = materials.id AND props.key = 'useTickets');

ALTER TABLE materials ADD COLUMN view TEXT;
UPDATE materials SET view = (SELECT props.value FROM MaterialProperties props WHERE props.materialId = materials.id AND props.key = 'view');

DROP TABLE materialProperties;

--//@UNDO

-- we do not support undo for this migration

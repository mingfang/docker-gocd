ALTER TABLE stages ADD fetchMaterials boolean DEFAULT true NOT NULL;

--//@UNDO

ALTER TABLE stages DROP fetchMaterials;
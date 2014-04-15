ALTER TABLE materials ADD flyweightName VARCHAR(50);
UPDATE materials SET flyweightName = RANDOM_UUID() WHERE flyweightName IS NULL;

ALTER TABLE materials ADD CONSTRAINT materials_FlyweightName_unique UNIQUE(flyweightName);
ALTER TABLE materials ALTER COLUMN flyweightName SET NOT NULL;


--//@UNDO

-- we don't support undo for this 

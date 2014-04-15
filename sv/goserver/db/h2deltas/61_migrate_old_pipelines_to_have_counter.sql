SELECT SET(@max_null, MAX(id)) FROM pipelines WHERE counter IS null;
UPDATE pipelines SET counter=(id - @max_null - 1) WHERE counter IS null;

--//@UNDO

UPDATE pipelines SET counter=null WHERE counter < 0;
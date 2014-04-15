
ALTER TABLE users ADD COLUMN preffered_id BIGINT;
ALTER TABLE users ADD COLUMN in_name varchar_ignorecase(255);
UPDATE users SET in_name = name;

CREATE TABLE preffered AS SELECT MIN(id) id, in_name FROM users WHERE enabled = true GROUP BY in_name;
UPDATE users SET preffered_id = (SELECT preffered.id FROM preffered WHERE users.in_name = preffered.in_name);
DELETE FROM users WHERE preffered_id IS NOT NULL AND id != preffered_id;

DROP TABLE preffered;
CREATE TABLE preffered AS SELECT MIN(id) id, in_name FROM users WHERE preffered_id IS NULL GROUP BY in_name;
UPDATE users SET preffered_id = (SELECT preffered.id FROM preffered WHERE users.in_name = preffered.in_name) WHERE preffered_id IS NULL;
DELETE FROM users WHERE id != preffered_id;

ALTER TABLE users DROP COLUMN preffered_id;
ALTER TABLE users DROP COLUMN in_name;

ALTER TABLE users ALTER COLUMN name varchar_ignorecase(255) NOT NULL;

--//@UNDO

ALTER TABLE users ALTER COLUMN name VARCHAR(255) NOT NULL;

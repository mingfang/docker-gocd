ALTER TABLE materials ADD COLUMN workspace VARCHAR(255);
ALTER TABLE materials ADD COLUMN workspaceOwner VARCHAR(255);
ALTER TABLE materials ADD COLUMN projectPath VARCHAR(255);

--//@UNDO

ALTER TABLE materials DROP COLUMN projectPath;
ALTER TABLE materials DROP COLUMN workspaceOwner;
ALTER TABLE materials DROP COLUMN workspace;

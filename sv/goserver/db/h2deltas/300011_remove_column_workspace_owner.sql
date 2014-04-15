ALTER TABLE materials DROP COLUMN workspaceOwner;

--//@UNDO
ALTER TABLE materials ADD COLUMN workspaceOwner VARCHAR(255);

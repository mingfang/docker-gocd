ALTER TABLE stages ADD cleanWorkingDir boolean DEFAULT false NOT NULL;

--//@UNDO

ALTER TABLE stages DROP cleanWorkingDir;
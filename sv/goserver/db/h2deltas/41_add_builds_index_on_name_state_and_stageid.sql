create index idx_builds_name_state_stageid on builds( name, state, stageid );

--//@UNDO

drop index idx_builds_name_state_stageid;

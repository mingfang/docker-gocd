create index idx_stages_state on stages(state);

--//@UNDO

DROP INDEX idx_stages_state;

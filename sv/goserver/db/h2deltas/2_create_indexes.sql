CREATE INDEX idx_pipeline_name ON pipelines (name);
CREATE INDEX idx_stage_name ON stages (name);
CREATE INDEX idx_properties_key ON properties (key);
CREATE INDEX idx_state_transition ON buildStateTransitions (currentState);
CREATE INDEX idx_build_state ON builds (state);
CREATE INDEX idx_build_name ON builds (name);
CREATE INDEX idx_build_result ON builds (result);
CREATE INDEX idx_build_agent ON builds (agentUuid);

--//@UNDO

DROP INDEX idx_build_agent
DROP INDEX idx_build_result
DROP INDEX idx_build_name
DROP INDEX idx_build_state
DROP INDEX idx_state_transition
DROP INDEX idx_properties_key
DROP INDEX idx_stage_name
DROP INDEX idx_pipeline_name
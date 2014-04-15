module ConfigUpdate
  module PipelineGroupNode
    include ::ConfigUpdate::LoadConfig
    def node(cruise_config)
      load_pipeline_group_config(cruise_config)
    end
  end
end
module ConfigUpdate
  module PipelineNode
    include ::ConfigUpdate::LoadConfig
    def node(cruise_config)
      load_pipeline_or_template(cruise_config)
    end
  end
end
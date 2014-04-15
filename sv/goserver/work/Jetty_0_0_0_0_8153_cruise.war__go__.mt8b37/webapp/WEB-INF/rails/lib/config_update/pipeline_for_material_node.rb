module ConfigUpdate
  module PipelineForMaterialNode
    include ::ConfigUpdate::LoadConfig
    def node(cruise_config)
      load_pipeline(cruise_config)
    end
  end
end
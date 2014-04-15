module ConfigUpdate
  module StageNode
    include ::ConfigUpdate::LoadConfig
    def node(cruise_config)
      load_stage(cruise_config)
    end
  end
end
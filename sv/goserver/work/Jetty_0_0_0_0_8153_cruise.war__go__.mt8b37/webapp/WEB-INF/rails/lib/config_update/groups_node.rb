module ConfigUpdate
  module GroupsNode
    include ::ConfigUpdate::LoadConfig
    def node(cruise_config)
      load_all_pipeline_groups(cruise_config)
    end
  end
end
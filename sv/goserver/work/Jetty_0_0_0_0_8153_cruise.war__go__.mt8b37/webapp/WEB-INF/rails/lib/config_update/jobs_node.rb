module ConfigUpdate
  module JobsNode
    include ::ConfigUpdate::LoadConfig
    def node(cruise_config)
      load_stage(cruise_config).getJobs()
    end
  end
end
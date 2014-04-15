module ConfigUpdate
  module JobNode
    include ::ConfigUpdate::LoadConfig
    def node(cruise_config)
      load_job(cruise_config)
    end
  end
end
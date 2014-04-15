module ConfigUpdate
  module TaskNode
    include ::ConfigUpdate::LoadConfig
    def node(cruise_config)
      load_task_of_job(cruise_config, task_index)
    end
  end
end
module ConfigUpdate
  module GroupsGroupSubject
    def subject(cruise_config)
      load_pipeline_group_config(cruise_config)
    end
  end
end
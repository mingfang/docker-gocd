module ConfigUpdate
  module PipelineStageSubject
    def subject(pipeline)
      load_stage_from_pipeline(pipeline)
    end
  end
end
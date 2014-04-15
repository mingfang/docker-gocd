module PauseInfoLoader
  def load_pause_info
    @pipeline && assert_load(:pause_info, pipeline_pause_service.pipelinePauseInfo(@pipeline.name().to_s))
  end
end
module StageConfigLoader
  include JavaImports

  def self.included base
    base.send(:include, ::PipelineConfigLoader)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def load_stage_except_for *actions
      load_pipeline_except_for *actions
      before_filter :load_stage, :except => actions
    end
  end

  private

  def load_stage
    stage_name = CaseInsensitiveString.new(params[:stage_name])
    stage = @pipeline.find { |stage_config| stage_name == stage_config.name() }
    assert_load :stage, stage, l.stageNotFoundInPipeline(stage_name, @pipeline.name())
  end
end
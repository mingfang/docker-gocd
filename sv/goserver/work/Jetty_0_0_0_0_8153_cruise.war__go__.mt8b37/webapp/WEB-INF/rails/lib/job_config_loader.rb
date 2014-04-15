module JobConfigLoader
  include JavaImports

  def self.included base
    base.send(:include, ::StageConfigLoader)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def load_job_except_for *actions
      load_stage_except_for *actions
      before_filter :load_job, :except => actions
    end
  end

  private

  def load_job
    job_name = CaseInsensitiveString.new(params[:job_name])
    assert_load :job, @stage.getJobs().find { |job_config| job_name == job_config.name() }, l.jobNotFoundInStage(job_name, @stage.name(), @pipeline.name())
  end
end
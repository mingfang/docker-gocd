module PipelineConfigLoader
  include JavaImports
  include PauseInfoLoader
  
  def self.included base
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def load_pipeline_for_all_actions
      load_pipeline_except_for
    end

    def load_pipeline_except_for *except_for
      options = except_for.extract_options!
      before_filter :load_pipeline, :except => except_for
      before_filter(:load_pause_info, :except => except_for) unless options[:skip_pause_info]
    end
  end

  def load_pipeline
    result = HttpLocalizedOperationResult.new
    if (params[:stage_parent] == 'templates')
      pipeline_for_edit = template_config_service.loadForEdit(params[:pipeline_name], current_user, result)
    else
      pipeline_for_edit = cruise_config_service.loadForEdit(params[:pipeline_name], current_user, result)
    end
    unless result.isSuccessful()
      render_localized_operation_result result
      return
    end
    assert_load(:pipeline, pipeline_for_edit.getConfig()) &&
            assert_load(:cruise_config, pipeline_for_edit.getCruiseConfig()) &&
            assert_load(:processed_cruise_config, pipeline_for_edit.getProcessedConfig())
  end
end
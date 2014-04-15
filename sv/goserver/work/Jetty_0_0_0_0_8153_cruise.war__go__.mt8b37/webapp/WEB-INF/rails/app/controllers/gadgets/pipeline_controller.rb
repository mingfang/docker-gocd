class Gadgets::PipelineController < ApplicationController

  layout 'application', :except => [:content, :index]


  def index   
    expires_in 24.hours, :public => true
  end

  def content

    pipeline_name = params[:pipeline_name]

    if(pipeline_name == nil)
      render_error_response(l.string("GADGET_PIPELINE_NAME_MISSING", [:pipeline_name]), 400, true)
      return
    end

    if(pipeline_name.empty?)
      render_error_response(l.string("GADGET_PIPELINE_NAME_EMPTY", [:pipeline_name]), 400, true)
      return
    end

    if (!cruise_config_service.hasPipelineNamed(CaseInsensitiveString.new(pipeline_name)))
      render_error_response(l.string("PIPELINE_NOT_FOUND", [pipeline_name]), 404, true)
      return
    end

    if (!security_service.hasViewPermissionForPipeline(current_user, pipeline_name))
      render_error_response(l.string("NO_VIEW_PERMISSION_ON_PIPELINE", [current_user.getDisplayName(), pipeline_name]), 403, true)
      return
    end

    @pipeline = pipeline(pipeline_history_service.getActivePipelineInstance(current_user, pipeline_name), pipeline_name)

  end

  private

  def pipeline(models, pipeline_name)
    models.get(0).getPipelineModel(pipeline_name)
  end
end
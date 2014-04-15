class ValueStreamMapController < ApplicationController
  include ApplicationHelper, PipelinesHelper
  layout "value_stream_map"

  before_filter :redirect_to_stage_pdg_if_ie8, :only => [:show]

  def show
    begin
    @pipeline = pipeline_service.findPipelineByCounterOrLabel(params[:pipeline_name], params[:pipeline_counter])
    rescue
    end
    respond_to do |format|
      format.html
      format.json { render :json => generate_vsm_json }
    end
  end

  private

  def generate_vsm_json
    result = HttpLocalizedOperationResult.new
    vsm = value_stream_map_service.getValueStreamMap(params[:pipeline_name], params[:pipeline_counter].to_i, current_user, result)
    vsm_path_partial = proc do |name, counter| vsm_show_path(name, counter) end
    stage_detail_path_partial = proc do |pipeline_name, pipeline_counter, stage_name, stage_counter|
      return stage_detail_path(:pipeline_name => pipeline_name, :pipeline_counter => pipeline_counter, :stage_name => stage_name, :stage_counter => stage_counter)
    end
    ValueStreamMapModel.new(vsm, result.message(localizer), localizer, vsm_path_partial, stage_detail_path_partial).to_json
  end

  def redirect_to_stage_pdg_if_ie8
    format = params[:format]
    user_agent = request.env["HTTP_USER_AGENT"]
    if (is_ie8?(user_agent) and (format.blank? || format == :html))
      result = HttpOperationResult.new
      pim = pipeline_history_service.findPipelineInstance(params[:pipeline_name], params[:pipeline_counter].to_i, current_user, result)
      redirect_to url_for_pipeline_instance(pim)
    end
  end

end

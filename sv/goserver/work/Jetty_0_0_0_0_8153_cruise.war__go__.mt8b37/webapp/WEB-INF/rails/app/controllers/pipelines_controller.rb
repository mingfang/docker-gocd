class PipelinesController < ApplicationController
  include ApplicationHelper
  layout "application", :except => ["show", "material_search", "show_for_trigger"]

  def build_cause
    result = HttpOperationResult.new
    pipeline_instance = pipeline_history_service.findPipelineInstance(params[:pipeline_name], params[:pipeline_counter].to_i, current_user, result)
    result.canContinue() ?  render(:partial => 'shared/build_cause_popup', :locals => {:scope => {:pipeline_instance => pipeline_instance}}, :layout => false) : render_operation_result_if_failure(result)
  end

  def index
    @pipeline_selections = cruise_config_service.getSelectedPipelines(cookies[:selected_pipelines], current_user_entity_id)
    @pipeline_groups = pipeline_history_service.allActivePipelineInstances(current_user, @pipeline_selections)
    @pipeline_configs = security_service.viewableGroupsFor(current_user)
    if @pipeline_configs.isEmpty() && security_service.canCreatePipelines(current_user)
      redirect_to url_for_path("/admin/pipeline/new?group=defaultGroup")
    end
  end

  def show
    populate_and_show(false)
  end

  def show_for_trigger
    populate_and_show(true)
  end

  def material_search
    @matched_revisions = material_service.searchRevisions(params[:pipeline_name], params[:fingerprint], params[:search], current_user, result = HttpLocalizedOperationResult.new)
    unless result.isSuccessful()
      render_localized_operation_result(result)
      return
    end
    @material_type = cruise_config_service.materialForPipelineWithFingerprint(params[:pipeline_name], params[:fingerprint]).getType
  end

  def select_pipelines
    pipeline_selections_id = cruise_config_service.persistSelectedPipelines(cookies[:selected_pipelines], current_user_entity_id, ((params[:selector]||{})[:pipeline]||[]))
    cookies[:selected_pipelines] = {:value => pipeline_selections_id, :expires => 1.year.from_now.beginning_of_day} if !mycruise_available? 
    render :nothing => true
  end

  private

  def populate_and_show should_show
    pipeline_name = params[:pipeline_name]
    @pipeline = pipeline_history_service.latest(pipeline_name, current_user)
    @variables = cruise_config_service.variablesFor(pipeline_name)
    render :partial => "pipeline_material_revisions", :locals => {:scope => {:show_on_pipelines => should_show, :pegged_revisions => params["pegged_revisions"]}}
  end

end

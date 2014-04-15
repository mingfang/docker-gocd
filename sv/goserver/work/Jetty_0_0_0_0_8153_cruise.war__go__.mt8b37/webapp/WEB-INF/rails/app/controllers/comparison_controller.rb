class ComparisonController < ApplicationController
  include ComparisonHelper
  layout "comparison", :except => [:list,:timeline]

  PAGE_SIZE = 10

  def show
    redirect_to compare_pipelines_path(:pipeline_name => params[:pipeline_name], :to_counter => params[:to_counter], :from_counter => "1") and return if (params[:from_counter].to_i < 1)
    redirect_to compare_pipelines_path(:pipeline_name => params[:pipeline_name], :from_counter => params[:from_counter], :to_counter => "1") and return if (params[:to_counter].to_i < 1)
    
    @pipeline_name = params[:pipeline_name]

    @to_pipeline = load_pipeline_instance(@pipeline_name, params[:to_counter].to_i)
    return unless @to_pipeline

    @from_pipeline = load_pipeline_instance(@pipeline_name, params[:from_counter].to_i)
    return unless @from_pipeline

    @mingle_config = mingle_config_service.mingleConfigForPipelineNamed(@pipeline_name, current_user, result = HttpLocalizedOperationResult.new)
    return render_localized_operation_result(result) unless result.isSuccessful()

    revisions = changeset_service.revisionsBetween(@pipeline_name, @from_pipeline.getCounter(), @to_pipeline.getCounter(), current_user, result = HttpLocalizedOperationResult.new, true, show_bisect?) || {}
    @material_revisions = revisions.find_all { | material | material.getMaterialType() != "Pipeline" }
    @dependency_material_revisions = revisions.find_all { | material | material.getMaterialType() == "Pipeline" }

    @cruise_config = cruise_config_service.getCurrentConfig()
    
    render_localized_operation_result(result) unless result.isSuccessful()
  end

  def list
    @pipeline_instances = pipeline_history_service.findMatchingPipelineInstances(params[:pipeline_name], params[:q], PAGE_SIZE, current_user, HttpLocalizedOperationResult.new)
  end

  def timeline
    page = params[:page] || 1
    @pipeline_instances = pipeline_history_service.findPipelineInstancesByPageNumber(params[:pipeline_name],page.to_i,PAGE_SIZE, CaseInsensitiveString.str(current_user.getUsername()))
  end

  private

  def load_pipeline_instance(pipeline_name, counter)
    pipeline = pipeline_history_service.findPipelineInstance(pipeline_name, counter, current_user, result = HttpOperationResult.new)
    unless result.canContinue()
      render_operation_result(result)
      return nil
    end
    pipeline
  end
end

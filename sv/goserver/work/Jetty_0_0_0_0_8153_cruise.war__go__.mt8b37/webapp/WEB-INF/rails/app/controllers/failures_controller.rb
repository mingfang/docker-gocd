class FailuresController < ApplicationController
  include ParamEncoder

  layout nil
  decode_params :suite_name, :test_name, :only => 'show'

  def show
    job_id = JobIdentifier.new(StageIdentifier.new(params[:pipeline_name], params[:pipeline_counter].to_i, params[:stage_name], params[:stage_counter]), params[:job_name])
    result = HttpLocalizedOperationResult.new
    @failure_details = failure_service.failureDetailsFor(job_id, params[:suite_name], params[:test_name], current_user, result)
    render_localized_operation_result(result) unless result.isSuccessful()
  end
end
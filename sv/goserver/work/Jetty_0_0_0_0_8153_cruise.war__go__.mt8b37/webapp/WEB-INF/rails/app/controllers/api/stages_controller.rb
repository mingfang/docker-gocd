include_class 'org.springframework.dao.DataRetrievalFailureException'

class Api::StagesController < Api::ApiController
  include ApplicationHelper

  def index
    return render_not_found unless number?(params[:id])

    stage_id = Integer(params[:id])
    begin
      @stage = stage_service.stageById(stage_id)
      @doc = xml_api_service.write(StageXmlViewModel.new(@stage), "#{request.protocol}#{request.host_with_port}/go")
      respond_to do |format|
        format.xml
      end
    rescue Exception => e
      logger.error(e)
      return render_not_found
    end

  end

  def cancel
    stage_id = Integer(params[:id])
    result = HttpLocalizedOperationResult.new
    schedule_service.cancelAndTriggerRelevantStages(stage_id, current_user, result)
    render_localized_operation_result result
  end

  def cancel_stage_using_pipeline_stage_name
    pipeline_name = params[:pipeline_name]
    stage_name = params[:stage_name]
    result = HttpLocalizedOperationResult.new
    schedule_service.cancelAndTriggerRelevantStages(pipeline_name,stage_name, current_user, result)
    render_localized_operation_result result
  end

  private
  def render_not_found()
    render :text => "Not Found!", :status => 404
  end

end

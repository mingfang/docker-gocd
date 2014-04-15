class Api::AgentsController < Api::ApiController
  include AgentBulkEditor

  def index
    agents = agent_service.agents
    agents_api_arr = agents.collect{|agent| AgentAPIModel.new(agent)}
    render :json => agents_api_arr.to_json
  end

  def delete
      agent_service.deleteAgents(current_user, result = HttpOperationResult.new, [params[:uuid]])
      render_operation_result(result)
  end

  def disable
    agent_service.disableAgents(current_user, result = HttpOperationResult.new, [params[:uuid]])
    render_operation_result(result)
  end

  def enable
    agent_service.enableAgents(current_user, result = HttpOperationResult.new, [params[:uuid]])
    render_operation_result(result)
  end

  def edit_agents
    render :text => bulk_edit.message()
  end
end
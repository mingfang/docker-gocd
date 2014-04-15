module AgentBulkEditor
  include JavaImports
  include ApplicationHelper

  def bulk_edit
    result = HttpOperationResult.new
    if params[:selected].nil? || params[:selected].size == 0
      result.notAcceptable("No agents were selected. Please select at least one agent and try again.", HealthStateType.general(HealthStateScope::GLOBAL))
    elsif params[:operation] == 'Enable'
      agent_service.enableAgents(current_user, result, params[:selected])
    elsif params[:operation] == 'Disable'
      agent_service.disableAgents(current_user, result, params[:selected])
    elsif params[:operation] == 'Delete'
      agent_service.deleteAgents(current_user, result, params[:selected])
    elsif params[:operation] == 'Apply_Resource'
      agent_service.modifyResources(current_user, result, params[:selected], selections)
    elsif params[:operation] == 'Add_Resource'
      agent_service.modifyResources(current_user, result, params[:selected], [TriStateSelection.new(params[:add_resource], "add")]);
    elsif params[:operation] == 'Apply_Environment'
      agent_service.modifyEnvironments(current_user, result, params[:selected], selections)
    else
      result.notAcceptable("The operation #{params[:operation]} is not recognized.", HealthStateType.general(HealthStateScope::GLOBAL))
    end
    result
  end


end